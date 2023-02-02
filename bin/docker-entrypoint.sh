#! /usr/bin/env bash

set -o errexit

bin/rails db:migrate
bin/rails server
