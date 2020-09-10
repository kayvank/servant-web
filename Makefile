##
# Project Title
#
# @file
# @version 0.1

VERSION=1.0
COMPANY=kayvank
APP_NAME=servant-web
BUILD_NUMBER=$(CIRCLE_BUILD_NUM)
GIT_SHA=$(shell git rev-parse --short HEAD)
IMAGE=$(COMPANY)/$(APP_NAME)
TAG=$(VERSION).$(BUILD_NUMBER)

login:
	@docker login -u "$(DOCKER_USER_NAME)" -p "$(DOCKER_USER_PASSWORD)" docker.io

setup: login
	stack setup

build_image: setup
	docker build -t $(IMAGE):$(VERSION) .

tag_image: build_image
	docker tag $(IMAGE):$(VERSION)   $(IMAGE):$(TAG)
	docker tag $(IMAGE):$(VERSION)   $(IMAGE):lates

publish: build_image
	docker push $(IMAGE):$(TAG)
	docker push $(IMAGE):latest


.DEFAULT_GOAL :=publish
.PHONY: all
all: ; $(info $$var is [${var}]) $(IMAGE)
# end
