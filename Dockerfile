FROM ubuntu
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>

RUN apt-get install logrotate gzip
ADD cron.sh /usr/local/bin/cron.sh
CMD /usr/local/bin/cron.sh
