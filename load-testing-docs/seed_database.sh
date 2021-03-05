#! /bin/bash

ENV_PATH=/opt/elasticbeanstalk/deployment/env
READ_COMMAND="sudo cat $ENV_PATH"

secret_cmd="$READ_COMMAND | egrep SECRET_KEY_BASE"
port_cmd="$READ_COMMAND | egrep RDS_PORT"
hostname_cmd="$READ_COMMAND | egrep RDS_HOSTNAME"
username_cmd="$READ_COMMAND | egrep RDS_USERNAME"
db_cmd="$READ_COMMAND | egrep RDS_DB_NAME"
password_cmd="$READ_COMMAND | egrep RDS_PASSWORD"

secret=$(eval $secret_cmd)
port=$(eval $port_cmd)
hostname=$(eval $hostname_cmd)
username=$(eval $username_cmd)
db=$(eval $db_cmd)
password=$(eval $password_cmd)

set -x
bundle exec rake db:reset RAILS_ENV=production $hostname $username $db $password $port $secret DISABLE_DATABASE_ENVIRONMENT_CHECK=1
