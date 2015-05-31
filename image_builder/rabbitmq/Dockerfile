############################################################
# Dockerfile to build RabbitMQ container images
# Based on bastianb/centos6.5
############################################################

# Set the base image to Centos
FROM bastianb/centos6.5

# File Author / Maintainer
MAINTAINER Bretagne Bastian <bastian.b@webinterpret.com>

# Install dependencies
RUN yum -y install epel-release wget logrotate && \
	wget http://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm && \
	rpm -Uvh erlang-solutions-1.0-1.noarch.rpm	&& \
	yum -y install erlang pwgen

# Install RabbitMQ
RUN wget https://www.rabbitmq.com/releases/rabbitmq-server/v3.5.3/rabbitmq-server-3.5.3-1.noarch.rpm && \
	rpm -Uvh rabbitmq-server-3.5.3-1.noarch.rpm	&& \
	rabbitmq-plugins enable rabbitmq_management
    
RUN echo "ERLANGCOOKIE" > /var/lib/rabbitmq/.erlang.cookie
RUN chown rabbitmq:rabbitmq /var/lib/rabbitmq/.erlang.cookie
RUN chmod 400 /var/lib/rabbitmq/.erlang.cookie

# Add scripts
ADD run.sh /run.sh
ADD set_rabbitmq_password.sh /set_rabbitmq_password.sh
RUN chmod 755 ./*.sh

EXPOSE 5672 15672
CMD ["/run.sh"]