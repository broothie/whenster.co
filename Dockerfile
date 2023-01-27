ARG NODE_VERSION=18.12.1
FROM node:18.12.1 AS frontend

WORKDIR /usr/src/app

COPY . .

RUN npm install
RUN npm run build

FROM ruby:3.2.0

RUN \
    apt-get update -qq && \
    apt-get install -y build-essential libvips && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man

WORKDIR /rails

ENV RAILS_LOG_TO_STDOUT="1" \
    RAILS_SERVE_STATIC_FILES="true" \
    BUNDLE_WITHOUT="development:test"

COPY . .
RUN bundle install
RUN bundle exec bootsnap precompile --gemfile app/ lib/

COPY --from=frontend /usr/src/app/public public

ENTRYPOINT ["bin/docker-entrypoint.sh"]

CMD ["./bin/rails", "server"]
