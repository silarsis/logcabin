#!/bin/bash
#
# Run the container linked to a given other container
# Usage: `run.sh client_container_name`
# We bind the docker socket in from the host for ease of use.

DOCKER_RUN="docker run -it -v /var/run/docker.sock:/var/run/docker.sock ${TIMEZONE_FLAGS}"

set -x

${DOCKER_RUN} logcabin /usr/local/bin/cron.sh
