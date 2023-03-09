ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION

RUN apt update -qq
RUN apt update -qq &&  apt install -y nodejs npm git imagemagick libmagick++-dev sqlite3

RUN npm install n -g
RUN npm install -g yarn

RUN mkdir -p /environment
WORKDIR /environment
