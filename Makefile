IMAGE_VERSION?=$(shell grep -Po 'org.opencontainers.image.version="\K.*?(?=")' Dockerfile)-dev
IMAGE_URL=$(shell grep -Po 'org.opencontainers.image.url="\K.*?(?=")' Dockerfile)
IMAGE?=${IMAGE_URL}:${IMAGE_VERSION}

.PHONY: test clean all build
.DEFAULT_GOAL := build

build:
	@echo "[I] Building image ${IMAGE}"
	@docker build --rm --force-rm -t ${IMAGE} .
