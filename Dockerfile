FROM ubuntu
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>

RUN apt-get install logrotate gzip
# XXX Need to install docker client in here
ADD cron.sh /usr/local/bin/cron.sh
CMD /usr/local/bin/cron.sh
