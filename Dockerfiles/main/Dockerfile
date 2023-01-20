# Ruby 3.1.3を利用
FROM ruby:3.1.2

# workdirを作成
RUN mkdir -p /environment/app

# Rails 6.1.4
RUN gem install rails -v 6.1.4

# update
RUN apt-get update -qq
# Node.js
RUN apt-get install -y nodejs npm git
# self-update npm
RUN npm install n -g

# yarn
RUN npm install -g yarn

# Imagemagick
RUN apt-get install -y imagemagick libmagick++-dev

# sqlite
RUN wget https://www.sqlite.org/2021/sqlite-autoconf-3360000.tar.gz && \
    tar xzvf sqlite-autoconf-3360000.tar.gz && \
    cd /sqlite-autoconf-3360000 && \
    ./configure --prefix=/opt/sqlite/sqlite3 && \
    make && \
    make install && \
    /opt/sqlite/sqlite3/bin/sqlite3 --version && \
    gem pristine --all && \
    gem install sqlite3 -- --with-sqlite3-include=/opt/sqlite/sqlite3/include --with-sqlite3-lib=/opt/sqlite/sqlite3/lib && \
    echo 'export LD_LIBRARY_PATH="/opt/sqlite/sqlite3/lib"' >> ~/.profile

# ここを変える
RUN cd /environment && \
    git clone https://github.com/ukwhatn/dmm-webcamp.git && \
    mv dmm-webcamp/task3/Bookers2/* /environment/app

WORKDIR /environment/app/

RUN bundle install && \
    rails webpacker:install && \
    rails webpacker:compile && \
    rails db:migrate && \
    rails db:migrate RAILS_ENV=test

RUN bundle exec rspec spec/ --format documentation

CMD ["/bin/sh", "/remote/scripts/start.sh"]

