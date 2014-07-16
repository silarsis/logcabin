#!/bin/bash
#
# Fake cron - this one runs in the foreground, and only runs logrotate

while true; do
  [ -e /container/logs/logrotate.conf ] && /usr/sbin/logrotate -v /container/logs/logrotate.conf
  sleep 60
done
