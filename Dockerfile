from ruby:3.1.2-alpine AS builder

RUN apk update && apk add --no-cache \
  build-base postgresql-dev git bash \
  tzdata netcat-openbsd \
  && rm -rf /var/cache/apk/*

WORKDIR /app

COPY Gemfile Gemfile.lock ./

ENV LANG=C.UTF-8 \ BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

RUN gem install bundler --no-document \
  && bundle config --global frozen 1 \
  # Following line for production build(needed for testing)
  # && bundle config set without 'development test' \
  && bundle install --quiet \
  && rm -rf /usr/local/bundle/cache/*.gem \
  && find /usr/local/bundle/gems/ -name "*.c" -delete \
  && find /usr/local/bundle/gems/ -name "*.o" -delete

COPY . /app
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
