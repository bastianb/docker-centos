FROM ubuntu:trusty
MAINTAINER Fernando Mayo <fernando@tutum.co>

# Install RabbitMQ
RUN rpm --import https://www.rabbitmq.com/rabbitmq-signing-key-public.asc && \
    yum install rabbitmq-server-3.5.3-1.noarch.rpm && \
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