############################################################
# Dockerfile to build memcached container images
# Based on bastianb/centos6.5
############################################################

# Set the base image to Centos
FROM bastianb/centos6.5

# File Author / Maintainer
MAINTAINER Bretagne Bastian <bastian.b@webinterpret.com>

# Install dependencies
RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
# RUN yum update -y

# TODO: SASL2 support
# RUN yum install -y cyrus-sasl.x86_64 cyrus-sasl-lib.x86_64 cyrus-sasl-devel.x86_64 
# RUN yum install -y wget pwgen
# ADD create_memcached_admin_user.sh /create_memcached_admin_user.sh
# RUN chmod 755 /create_memcached_admin_user.sh

# Install memcached
RUN yum install -y memcached

ADD run.sh /run.sh
RUN chmod 755 /run.sh

EXPOSE 11211

CMD ["/run.sh"]
