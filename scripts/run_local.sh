#!/bin/bash
RUBY=$1
DB=$2
REDMINE=$3

docker run -t -i -v `pwd`:/var/www/$RUBY/$DB/$REDMINE/plugins/redmine_checklists \
  --env RUBY=$1 \
  --env DB=$2 \
  --env REDMINE=$3 \
  --env PLUGIN=redmine_checklists \
  redmineup/redmine_checklists \
  /root/run_local.sh
