FROM centos:6.7

MAINTAINER Bretagne Bastian <bastian.b@webinterpret.com>

# Install runit
RUN curl -s https://packagecloud.io/install/repositories/imeyer/runit/script.rpm.sh | bash
RUN yum install -y runit

# Create the sv folder
RUN mkdir /etc/sv

# Default command
CMD ["/sbin/runsvdir", "/etc/service"]
