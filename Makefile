##
# Project Title
#
# @file
# @version 0.1


BUILD_NUMBER=$(CIRCLE_BUILD_NUM)
GIT_TAG=$(shell git rev-parse --short HEAD)-$(BUILD_NUMBER)
IMAGE_NAME=$(COMPANY)/$(APP_NAME)

login:
	@docker login -u "$(DOCKER_USER_NAME)" -p "$(DOCKER_USER_PASSWORD)" docker.io

setup: login
	stack setup

build: setup
	stack build
	stack test

build_image: build
	docker build -t $(IMAGE_NAME) .

tag_image: build_image
	docker tag $(IMAGE_NAME)  $(IMAGE_NAME):$(GIT_TAG)
	docker tag $(IMAGE_NAME) $(IMAGE_NAME):latest

publish: tag_image
	docker push $(IMAGE_NAME):$(GIT_TAG)
	docker push $(IMAGE_NAME):latest

build: publish

.DEFAULT_GOAL :=publish
# end
