ARG VARIANT=8.2.1

FROM squidfunk/mkdocs-material:${VARIANT}

RUN apk add --no-cache su-exec

RUN addgroup -S mkdocs && adduser -S -g mkdocs mkdocs \
    && mkdir -p /home/mkdocs \
    && chown -R mkdocs:mkdocs /home/mkdocs

USER mkdocs

WORKDIR /home/mkdocs/bin
COPY --chown=mkdocs:mkdocs entrypoint.sh .

# Setup workspace for user
USER root
ENV MKDOCS_USER mkdocs:mkdocs


# Set working directory
WORKDIR /docs

# Expose MkDocs development server port
EXPOSE 8000

# Start development server by default
ENTRYPOINT ["/home/mkdocs/bin/entrypoint.sh"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]

