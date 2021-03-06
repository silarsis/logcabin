# logcabin

Logging container for Docker

## LogRotate

This container runs logrotate. To use it:

* In the Dockerfile for the app container, include the line:
  `VOLUME /container/log`
* When running this container, use the `run.sh` command provided. It takes some
  environment variables, `SIGNAL` to tell it to send a signal to each found
  container, and `ROTATE` to tell it to call logrotate on each container. Set
  SIGNAL to the signal you want to send (typically `HUP`), and ROTATE to
  anything non-blank to trigger the behaviour.
* In /container/log in the app container, you should have a logrotate.conf if
  you want logcabin to rotate your logs for you.
* If you need to send signals to your app (eg. `HUP` to re-open logfiles), then
  the line you should use in the logrotate.conf is `kill -HUP CONTAINER`.
  This command will be converted to a signal to the first process in your
  container (ie. PID 1 or the CMD or ENTRYPOINT specified in your Dockerfile),
  so please make sure signals either propogate correctly, or trigger the
  correct behaviour in your app. Note also, the conversion of this command is
  fairly strict in the format it expects, so please don't deviate from the
  above, except in replacing `HUP` with any other signal.

## FUSE

This is an attempt to bulid a user space filesystem in the container that
can be mounted to other containers. The filesystem will take file writes
and convert them to splunkable data - thus getting around the requirement
to rotate logfiles.

**This is not currently operational.**

Expect to take environment variables to indicate where to send logs to,
first cab off the rank will be splunk support.

Run this as:

```
docker build -t logcabin .
docker run --privileged -it --name=logcabin logcabin
```

Use it as:

`docker run -it --volumes-from=logcabin ubuntu /bin/bash`
