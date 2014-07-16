#!/bin/bash
#
# Run the container linked to a given other container
# Usage: `run.sh client_container_name`

CLIENT=$1
TIMEZONE_FLAGS="-v /etc/localtime:/etc/localtime:ro -v /etc/timezone:/etc/timezone:ro"
DOCKER_RUN="docker run -d --privileged ${TIMEZONE_FLAGS}"
# XXX Need to map the docker socket in here for docker commands to work

${DOCKER_RUN} --link ${CLIENT}:client --volumes-from ${CLIENT}
