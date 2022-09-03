#!/bin/bash

bundle update
rails db:migrate
rm -f tmp/pids/server.pid && bundle exec rails s -b '0.0.0.0'