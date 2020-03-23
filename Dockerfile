FROM ruby:2.7.0

WORKDIR /shitsucomi-management
ADD Gemfile /shitsucomi-management/Gemfile
ADD Gemfile.lock /shitsucomi-management/Gemfile.lock

RUN set -x && \
    apt-get -qq update && \
    apt-get -qq upgrade -y && \
    apt-get -qq install -y build-essential && \
    apt-get install -y nodejs npm && \
    npm install n -g && \
    n 9.2.0 && \
    bundle install -j4 && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get -qq update && apt-get -y install yarn && \
    yarn install

COPY . /shitsucomi-management
