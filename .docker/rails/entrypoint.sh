#!/bin/bash

gem install mimemagic -v 0.3.7
bundle install
yarn install
bundle exec rails webpacker:install
bower install --allow-root
rake assets:precompile --trace --verbose
cd timeline && yarn && yarn build && cd ..

rails s