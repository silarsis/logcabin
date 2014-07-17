#!/bin/bash
#
# Assumes that docker commands will find the docker daemon (ie. bound docker.sock)
# If you want to change the conditions for finding containers, you'll need to
# change the main loop here.
# Note: This can be run either in a container, or on the host directly. It assumes
# the docker daemon is llistening on the docker.sock.
# See the README.md for more details on environment variables.

signal() {
  docker kill -s ${SIGNAL} ${CID}
}

rotatelogs() {
  # Run a container with the volume mounted that will run logrotate
  # Run in a container so we can mount the volume to look for logrotate conf
  # Run -it so the logs come through.
  # mount the docker socket through so any kill commands will work
  docker run -it -e CLIENT_NAME=${CID} -v /var/run/docker.sock:/var/run/docker.sock --volumes-from ${CID} logcabin /usr/local/bin/logrotate.sh
}

IDS=$(docker ps -q)
for CID in ${IDS}; do
  for VOLUME in $(docker inspect -f "{{ .Volumes }}" ${CID} | sed 's/^.*\[//' | sed 's/\]$//'); do
    if [ $(echo ${VOLUME} | awk 'BEGIN { FS=":" } { print $1 }') == "/container/log" ]; then
      [ ${ROTATE+z} ] && rotatelogs
      [ ${SIGNAL+z} ] && signal
    fi
  done
done
