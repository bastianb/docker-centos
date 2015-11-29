FROM bastianb/python:3.4.3_with-run-it

# pcre for uwsgi
RUN yum install -y pcre pcre-devel

# Copy runit conf
COPY ./etc/sv/myapp /etc/sv/myapp
RUN ln -s /etc/sv/myapp /etc/service/

# Copy App code
RUN mkdir -p /usr/src/myapp
COPY ./myapp /usr/src/myapp
WORKDIR /usr/src/myapp

# Install App
COPY ./requirements.txt /usr/src/myapp/
RUN pip3.4 install --no-cache-dir -r requirements.txt

EXPOSE 8080

# Redirect runit logs to docker log collector
RUN ln -sf /dev/stdout /etc/sv/myapp/log/current

# Runit bootstrap
ADD https://github.com/bastianb/docker-centos/raw/master/tools/runit/go-runsvinit/bin/runsvinit /sbin/runsvinit
RUN chmod +x /sbin/runsvinit
CMD ["/sbin/runsvinit"]
