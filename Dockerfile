FROM debian
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>
RUN apt-get -yq update

# The following needed for logrotate
RUN apt-get install -yq logrotate gzip curl
RUN curl --silent --show-error --retry 5 -o /usr/local/bin/docker https://get.docker.io/builds/Linux/x86_64/docker-latest
RUN chmod +x /usr/local/bin/docker
ADD cron.sh /usr/local/bin/cron.sh
ADD logrotate.sh /usr/local/bin/logrotate.sh
CMD /usr/local/bin/cron.sh

## The following needed for FUSE
#RUN apt-get install -yq python2.7 curl fuse logrotate gzip
#RUN curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | python2.7
#ADD requirements.txt /tmp/requirements.txt
#RUN pip install -r /tmp/requirements.txt
#ADD logfs.py /usr/local/bin/logfs.py
#RUN chmod +x /usr/local/bin/logfs.py
#VOLUME /var/logfs
#CMD /usr/local/bin/logfs.py /var/logfs /var/logfs
