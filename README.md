# logcabin

Logging container for Docker

## LogRotate

This container runs logrotate. To use it:

* In the Dockerfile for the app container, include the line:
  `VOLUME /container/log`
* When running this container, use the following command line:
  `docker run -d --link <app_container>:client --privileged --volumes-from <app-container> -v /etc/localtime:/etc/localtime:ro -v /etc/timezone:/etc/timezone:ro`
* In /container/log in the app container, you should have a configuration file
  for logrotate.
* If you need to send signals to your app (eg. `HUP` to re-open logfiles), then
  the line you should use is `kill -HUP CONTAINER`. This command will be converted
  to a signal to the first process in your container (ie. PID 1 or the CMD or
  ENTRYPOINT specified in your Dockerfile), so please make sure signals either
  propogate correctly, or trigger the correct behaviour in your app. Note also,
  the conversion of this command is fairly strict in the format it expects, so
  please don't deviate from the above, except in replacing `HUP` with any other signal.
