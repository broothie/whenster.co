#! /usr/bin/env bash

set -o errexit

bin/rake cloudtasker:setup_queue
bin/rails db:migrate
bin/rails server
