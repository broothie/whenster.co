FROM node:18.12.1 AS frontend

WORKDIR /usr/src/app

COPY . .

RUN npm install
RUN npm run build

# A log of  this came from here: https://fly.io/ruby-dispatch/rails-on-docker/
FROM ruby:3.2.0

# Install libvips for Active Storage preview support
RUN \
    apt-get update -qq && \
    apt-get install -y build-essential libvips && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man

WORKDIR /rails

# Set production environment
ENV \
    RAILS_LOG_TO_STDOUT="1" \
    RAILS_SERVE_STATIC_FILES="true" \
    BUNDLE_WITHOUT="development:test"

# Take advantage of cache to speed up builds
RUN gem install bundler:2.4.4
RUN gem install rails:7.0.4.1
RUN gem install grpc:1.51.0

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy application code
COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile --gemfile app/ lib/

# Grab compiled frontend, delete original
COPY --from=frontend /usr/src/app/public public
RUN rm -rf www

CMD ["bin/docker-entrypoint.sh"]
