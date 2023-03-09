# vars
APP_DIR ?= ""
BRANCH ?= main

# image names
BASE_IMAGE_NAME := webcamp_rails_env
REVIEW_IMAGE_NAME := webcamp_review_temp
RUN_IMAGE_NAME := $(REVIEW_IMAGE_NAME)_check

# container name
CHECK_CONTAINER_NAME := $(RUN_IMAGE_NAME)_container

build-base:
	docker build ./base/ -t $(BASE_IMAGE_NAME):$(VER) --build-arg RUBY_VERSION=$(VER)

build-all-base:
	make build-base VER=2.6.3
	make build-base VER=3.1.2

build-noauth:
	make build-base VER=$(VER)
	docker build \
		-t $(REVIEW_IMAGE_NAME) \
		./layer/noauth/ \
		--build-arg BASE_IMAGE_NAME=$(BASE_IMAGE_NAME) \
		--build-arg RUBY_VERSION=$(VER) \
		--build-arg REPO_HOST=$(HOST) \
		--build-arg REPO_USER=$(USER) \
		--build-arg REPO_NAME=$(REPO) \
		--build-arg APP_DIR=$(APP_DIR) \
		--build-arg GIT_BRANCH=$(BRANCH)

check:
	docker build ./layer/check/ -t $(RUN_IMAGE_NAME) --build-arg IMAGE_FROM=$(REVIEW_IMAGE_NAME) --progress plain
	docker run -p 127.0.0.1:3901:3000 -d --name $(CHECK_CONTAINER_NAME) -it $(RUN_IMAGE_NAME)
	open -a "Google Chrome" http://127.0.0.1:3901
	docker logs -f $(CHECK_CONTAINER_NAME)

check-bookers:
	make build-noauth VER="3.1.2" HOST="github.com" USER=$(USER) REPO=$(REPO) APP_DIR=$(APP_DIR) BRANCH=$(BRANCH)
	make check

stop:
	docker stop $(CHECK_CONTAINER_NAME)
	docker rm $(CHECK_CONTAINER_NAME)

clean:
	docker image rm $(REVIEW_IMAGE_NAME)
	docker image rm $(RUN_IMAGE_NAME)

finish:
	make stop
	make clean
