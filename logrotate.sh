#!/bin/bash
#
# Run log rotate based on the configuration file in /container/log

echo "looking for a logrotate.conf file"

[ -e /container/log/logrotate.conf ] && {
  echo "Found conf file - running logrotate"
  cp /container/log/logrotate.conf /tmp/logrotate.conf
  sed -i 's/kill -\(.*\) CONTAINER/docker kill -s \1 ${CLIENT_NAME}/' /tmp/logrotate.conf
  /usr/sbin/logrotate --force -v /tmp/logrotate.conf
}
