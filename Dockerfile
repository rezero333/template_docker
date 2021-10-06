ARG RUBY_VERSION=3.0.1-jemalloc

FROM quay.io/evl.ms/fullstaq-ruby:${RUBY_VERSION}-buster-slim

RUN apt-get update && apt-get install -y build-essential libssl-dev libreadline-dev wget git-all && apt-get clean
RUN apt-get install -y default-libmysqlclient-dev default-mysql-client && apt-get clean

WORKDIR /app
ADD Gemfile Gemfile.lock /app/
COPY Gemfile Gemfile.lock ./

RUN gem install bundler --no-document
RUN bundle install --no-binstubs --jobs $(nproc) --retry 3
RUN echo 'IRB.conf[:USE_MULTILINE] = false' > ~/.irbrc
ADD . /app