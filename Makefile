# default image name
IMAGE_NAME?=iromli/spannerbox
VERSION=$(shell cat version.txt)

.DEFAULT_GOAL:=build

build:
	@echo "[I] Building image ${IMAGE_NAME}:${VERSION}"
	@docker build --rm --force-rm -t ${IMAGE_NAME}:${VERSION} .
