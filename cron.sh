#!/bin/bash
#
# Fake cron - this one runs in the foreground, and only runs logrotate

while true; do
  [ -e /container/logs/logrotate.conf ] && {
    cp /container/logs/logrotate.conf /tmp/logrotate.conf
    sed -i 's/kill -(.*) CONTAINER/docker kill -s \1 $CLIENT_NAME' /tmp/logrotate.conf
    /usr/sbin/logrotate -v /tmp/logrotate.conf
  }
  sleep 60
done
