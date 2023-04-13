# env
include .env

# vars
APP_DIR ?= ""
BRANCH ?= main

# image names
BASE_IMAGE_NAME := webcamp_rails_env
REVIEW_IMAGE_NAME := webcamp_review_temp

# container name
CHECK_CONTAINER_NAME := $(REVIEW_IMAGE_NAME)_container

build-base:
	docker build ./layer/base/ -t $(BASE_IMAGE_NAME):$(VER) --build-arg RUBY_VERSION=$(VER)

build-all-base:
	make build-base VER=2.6.3
	make build-base VER=2.7.8
	make build-base VER=3.1.2

build-noauth:
	make build-base VER=$(VER)
	docker build \
		-t $(REVIEW_IMAGE_NAME) \
		./layer/https/ \
		--build-arg BASE_IMAGE_NAME=$(BASE_IMAGE_NAME) \
		--build-arg RUBY_VERSION=$(VER) \
		--build-arg REPO_HOST=$(HOST) \
		--build-arg REPO_USER=$(USER) \
		--build-arg REPO_NAME=$(REPO) \
		--build-arg APP_DIR=$(APP_DIR) \
		--build-arg GIT_BRANCH=$(BRANCH)

build-https:
	# 変わってるのはREPO_HOSTだけ
	make build-base VER=$(VER)
	docker build \
		-t $(REVIEW_IMAGE_NAME) \
		./layer/https/ \
		--build-arg BASE_IMAGE_NAME=$(BASE_IMAGE_NAME) \
		--build-arg RUBY_VERSION=$(VER) \
		--build-arg REPO_HOST="$(GIT_USER):$(GIT_PASS)@$(HOST)" \
		--build-arg REPO_USER=$(USER) \
		--build-arg REPO_NAME=$(REPO) \
		--build-arg APP_DIR=$(APP_DIR) \
		--build-arg GIT_BRANCH=$(BRANCH)

run:
	docker run -p 127.0.0.1:$(PORT):3000 -d --name $(CHECK_CONTAINER_NAME) -it $(REVIEW_IMAGE_NAME)

spec:
	docker exec $(CHECK_CONTAINER_NAME) bundle exec rspec spec/ --format documentation

open:
	docker exec $(CHECK_CONTAINER_NAME) rails s -d -b "0.0.0.0"
	open -a "Google Chrome" http://127.0.0.1:$(PORT)
	docker exec $(CHECK_CONTAINER_NAME) tail -f log/development.log

check-bookers:
	make build-noauth VER="3.1.2" HOST="github.com" USER=$(USER) REPO=$(REPO) APP_DIR=$(APP_DIR) BRANCH=$(BRANCH)
	make run
	make spec
	make open

check-s2-bookers:
	make build-https VER="2.6.3" HOST="gitlab.com" USER=$(USER) REPO="bookers2_phase2_debug_Rails6" APP_DIR=$(APP_DIR) BRANCH=$(BRANCH)
	make run
	make open

check-nc:
	make build-https VER="2.6.3" HOST="gitlab.com" USER=$(USER) REPO="NaganoCake-Rails6" APP_DIR=$(APP_DIR) BRANCH=$(BRANCH)
	make run
	make open

stop:
	docker stop $(CHECK_CONTAINER_NAME)
	docker rm $(CHECK_CONTAINER_NAME)

clean:
	docker image rm $(REVIEW_IMAGE_NAME)

finish:
	make stop
	make clean
