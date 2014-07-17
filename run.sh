#!/bin/bash
#
# Run the container linked to a given other container
# Usage: `run.sh client_container_name`

#TIMEZONE_FLAGS="-v /etc/localtime:/etc/localtime:ro -v /etc/timezone:/etc/timezone:ro"
# This is naive, but will work for most cases
#DOCKER_IP=$(/sbin/ifconfig docker0 | grep 'inet ' | awk '{ print $2 }')
DOCKER_IP=10.1.42.1
DOCKER_RUN="docker run -d -e DOCKER_HOST=tcp://${DOCKER_IP}:4243 ${TIMEZONE_FLAGS}"

set -x

${DOCKER_RUN} logcabin /usr/local/bin/cron.sh
