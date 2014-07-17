#!/bin/bash
#
# Fake cron - this one runs in the foreground, and only runs logrotate
# Assumes that DOCKER_HOST is set

signal() {
  docker kill -s HUP ${CID}
}

rotatelogs() {
  # Run a container with the volume mounted that will run logrotate
  # Run in a container so we can mount the volume to look for logrotate conf
  docker run -d -e CLIENT_NAME=${CID} --volumes-from ${CID} logcabin /usr/local/bin/logrotate.sh
}

IDS=$(docker ps -q)
for CID in ${IDS}; do
  for VOLUME in $(docker inspect -f "{{ .Volumes }}" ${CID} | sed 's/^.*\[//' | sed 's/\]$//'); do
    if [ $(echo ${VOLUME} | awk 'BEGIN { FS=":" } { print $1 }') == "/container/log" ]; then
      rotatelogs
      signal
    fi
  done
done

# while true; do
#   [ -e /container/logs/logrotate.conf ] && {
#     cp /container/logs/logrotate.conf /tmp/logrotate.conf
#     sed -i 's/kill -(.*) CONTAINER/docker kill -s \1 $CLIENT_NAME' /tmp/logrotate.conf
#     /usr/sbin/logrotate -v /tmp/logrotate.conf
#   }
#   sleep 60
# done
