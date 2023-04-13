ARG RUBY_VERSION
ARG BASE_IMAGE_NAME

FROM $BASE_IMAGE_NAME:$RUBY_VERSION

ARG REPO_HOST
ARG REPO_USER
ARG REPO_NAME
ARG GIT_BRANCH
ARG APP_DIR

WORKDIR /environment

RUN git clone https://$REPO_HOST/$REPO_USER/$REPO_NAME.git /tmp/app

WORKDIR /tmp/app

RUN ls -la

RUN git checkout $GIT_BRANCH
RUN git pull
RUN mv /tmp/app/$APP_DIR /environment/app

WORKDIR /environment/app

RUN bundle install && \
    rails webpacker:install && \
    rails webpacker:compile && \
    rails db:setup && \
    rails db:migrate && \
    rails db:migrate RAILS_ENV=test

