#!/bin/bash
#
# Run log rotate based on the configuration file in /container/log

cp /container/log/logrotate.conf /tmp/logrotate.conf
sed -i 's/kill -(.*) CONTAINER/docker kill -s \1 ${CLIENT_NAME}' /tmp/logrotate.conf
/usr/sbin/logrotate -v /tmp/logrotate.conf
