ARG RUBY_VERSION
ARG GITHUB_USER
ARG GITHUB_PASSWORD
ARG GITHUB_REPO
ARG GIT_BRANCH="main"
ARG GIT_DIR=""

FROM webcamp_rails_env:$RUBY_VERSION

WORKDIR /environment

RUN git clone https://$GITHUB_USER:$GITHUB_PASSWORD@$GITHUB_REPO /tmp/app && \
    mv /tmp/app/$GIT_DIR/* /environment/app

WORKDIR /environment/app

RUN git checkout $GIT_BRANCH && git pull

RUN bundle install && \
    rails webpacker:install && \
    rails webpacker:compile && \
    rails db:setup && \
    rails db:migrate && \
    rails db:migrate RAILS_ENV=test

RUN bundle exec rspec spec/ --format documentation

CMD ["rails", "s", "-b", "0.0.0.0"]


