#!/bin/bash
#
# Run the container linked to a given other container
# Usage: `run.sh client_container_name`

# This is naive, but will work for most cases
[ ${DOCKER_IP+z} ] || {
  DOCKER_IP=$(/sbin/ifconfig docker0 | grep 'inet ' | awk '{ print $2 }')
}
[ ${DOCKER_IP+z} ] || {
  echo "This script cuold not determine the DOCKER_HOST to pass into the container."
  echo "Please export DOCKER_IP and try again."
  exit -1
}
DOCKER_RUN="docker run -d -e DOCKER_HOST=tcp://${DOCKER_IP}:4243 ${TIMEZONE_FLAGS}"

set -x

${DOCKER_RUN} logcabin /usr/local/bin/cron.sh
