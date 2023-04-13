ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION

# install dependencies
RUN apt update -qq
RUN apt update -qq &&  apt install -y git imagemagick libmagick++-dev sqlite3

# install nodejs 16
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt install -y nodejs

# install yarn
RUN npm install n -g
RUN npm install -g yarn

# for nokogiri
# ref: https://qiita.com/ohakutsu/items/4d14bee46da26f55a9be
# ref: https://regardie.dev/post-5126
# ref: https://matsu.teraren.com/blog/2022/04/26/docker-m1-arm-glibc-error-on-nokogiri
RUN bundle config set force_ruby_platform true  # for bundler >=2.1
RUN bundle config force_ruby_platform true  # for bundler <2.1

RUN mkdir -p /environment
WORKDIR /environment
