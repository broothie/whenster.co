#!/usr/bin/env bash

set -o errexit

npm install
npm run build

bin/bundle install
bin/rails db:migrate
