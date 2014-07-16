#!/bin/bash
#
# Run the container linked to a given other container
# Usage: `run.sh client_container_name`

CLIENT=$1
DOCKER_RUN="docker run -d --privileged -v /etc/localtime:/etc/localtime:ro -v /etc/timezone:/etc/timezone:ro"

$DOCKER_RUN --link $CLIENT:client --volumes-from $CLIENT 
