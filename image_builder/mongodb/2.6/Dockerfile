############################################################
# Dockerfile to build mongodb 2.6 container images
# Based on bastianb/centos6.5
############################################################

# Set the base image to Centos
FROM bastianb/centos6.5

# File Author / Maintainer
MAINTAINER Bretagne Bastian <bastian.b@webinterpret.com>

# Install dependencies
RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum install -y pwgen

RUN echo -e "[mongodb-org-2.6]\nname=MongoDB 2.6 Repository\nbaseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/\ngpgcheck=0\nenabled=1" > /etc/yum.repos.d/mongodb-org-2.6.repo

RUN yum install -y mongodb-org

VOLUME /data/db

ENV AUTH yes

ADD run.sh /run.sh
ADD set_mongodb_password.sh /set_mongodb_password.sh
RUN chmod 755 /*.sh

EXPOSE 27017 28017

CMD ["/run.sh"]