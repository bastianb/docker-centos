FROM bastianb/centos:6.7_with-run-it

MAINTAINER Bretagne Bastian <bastian.b@webinterpret.com>

# Copy runit conf
COPY ./etc/sv/ /etc/sv/
COPY ./foo-service /usr/src/
RUN for name in $(find /etc/sv/ -mindepth 1 -maxdepth 1 -type d); do ln -s $name /etc/service/; done && \
    chmod +x /usr/src/foo-service && \
    chmod +x /etc/sv/foo/run

ADD https://github.com/bastianb/docker-centos/raw/master/tools/runit/go-runsvinit/bin/runsvinit /sbin/runsvinit
RUN chmod +x /sbin/runsvinit

CMD ["/sbin/runsvinit"]