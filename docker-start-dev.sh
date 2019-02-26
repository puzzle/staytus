#!/bin/bash

cp config/database.example.yml config/database.yml
sed -i "s|password:.*|password: <%= ENV['MYSQL_PASSWORD'] %>|" config/database.yml
sed -i "s|host:.*|host: <%= ENV['MYSQL_HOST'] %>|" config/database.yml

if [[ -v STAYTUS_UPGRADE ]] ; then
  bundle exec rake staytus:build staytus:upgrade
fi

bundle exec rake staytus:build staytus:install

bundle exec foreman start
