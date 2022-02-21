#!/bin/sh

exec su-exec "$MKDOCS_USER" mkdocs "$@"
