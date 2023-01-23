#!/usr/bin/env bash

set -o errexit

npm install
npm run build

bundle install
bundle exec rake db:migrate
