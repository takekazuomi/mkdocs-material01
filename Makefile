REPO_NAME	?= local
IMAGE_NAME	= $(REPO_NAME)/mkdocs-material01
TAG		= 8.2.1
MKDOCS_USER	= MKDOCS_USER="$$(id -u):$$(id -g)"
MKDOCS_MOUNT	= $(PWD)/tmp:/docs
MKDOCS_CMD	= docker run -it --rm --name mkdocs-material01 -v $(MKDOCS_MOUNT) -e $(MKDOCS_USER) -p 8000:8000

help:	## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

build:	## build
	docker build \
		-t $(IMAGE_NAME):$(TAG) \
		-t $(IMAGE_NAME):latest \
		--build-arg VARIANT=$(TAG) \
		.

mkdocs-help:
	$(MKDOCS_CMD) $(IMAGE_NAME):latest --help

new:
	$(MKDOCS_CMD) $(IMAGE_NAME):latest new .

up:
	$(MKDOCS_CMD) $(IMAGE_NAME):latest serve --dev-addr=0.0.0.0:8000

down:
	docker stop mkdocs-material01

push:	## push
	docker push $(IMAGE_NAME):$(TAG)
	docker push $(IMAGE_NAME):latest

login:	## login docker shell
	docker run -it --rm -v $(PWD):/docs --entrypoint /bin/sh $(IMAGE_NAME):latest

