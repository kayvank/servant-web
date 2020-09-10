##
# Project Title
#
# @file
# @version 0.1

COMPANY=kayvank
APP_NAME=servant-web
BUILD_NUMBER=$(CIRCLE_BUILD_NUM)
GIT_SHA=$(shell git rev-parse --short HEAD)
IMAGE_NAME=$(COMPANY)/$(APP_NAME)

login:
	@docker login -u "$(DOCKER_USER_NAME)" -p "$(DOCKER_USER_PASSWORD)" docker.io

setup: login
	stack setup

build:
	stack build
	stack test

build_image: setup
	docker build -t $(IMAGE_NAME) .


publish: build_image
	docker push $(IMAGE_NAME):$(BUILD_NUMBER)
	docker push $(IMAGE_NAME):latest


.DEFAULT_GOAL :=publish
.PHONY: all
all: ; $(info $$var is [${var}]) $(IMAGE_NAME)
# end
