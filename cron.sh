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
  docker run -it -e CLIENT_NAME=${CID} -e DOCKER_HOST=${DOCKER_HOST} --volumes-from ${CID} logcabin /usr/local/bin/logrotate.sh
}

IDS=$(docker ps -q)
for CID in ${IDS}; do
  for VOLUME in $(docker inspect -f "{{ .Volumes }}" ${CID} | sed 's/^.*\[//' | sed 's/\]$//'); do
    if [ $(echo ${VOLUME} | awk 'BEGIN { FS=":" } { print $1 }') == "/container/log" ]; then
      rotatelogs
    fi
  done
done
