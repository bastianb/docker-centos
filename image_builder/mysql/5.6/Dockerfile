############################################################
# Dockerfile to build MySQL container images
# Based on bastianb/centos6.5
############################################################

# Set the base image to Centos
FROM bastianb/centos6.5

# File Author / Maintainer
MAINTAINER Bretagne Bastian <bastian.b@webinterpret.com>

RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm 

# Install dependencies
RUN yum install -y epel-release wget pwgen

# Instal MySQL
RUN wget -P /tmp/ http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm && \
	rpm -Uvh /tmp/mysql-community-release-el6-5.noarch.rpm && \
	yum -y install mysql-community-server

# Solves `/etc/init.d/mysqld: line XX: /etc/sysconfig/network: No such file or directory`
RUN echo "NETWORKING=yes" >/etc/sysconfig/network

# Remove pre-installed database
RUN rm -rf /var/lib/mysql/*

# Add MySQL configuration
ADD my.cnf /etc/my.cnf

# Add MySQL scripts
RUN mkdir -p /tmp/mysql_tools
ADD import_sql.sh /tmp/mysql_tools/import_sql.sh
ADD run.sh /tmp/mysql_tools/run.sh
RUN chmod 755 /tmp/mysql_tools/*.sh

# Exposed ENV
ENV MYSQL_USER admin
ENV MYSQL_PASS **Random**
ENV ON_CREATE_DB **False**

# Replication ENV
ENV REPLICATION_MASTER **False**
ENV REPLICATION_SLAVE **False**
ENV REPLICATION_USER replica
ENV REPLICATION_PASS replica

EXPOSE 3306

CMD ["/bin/bash", "/tmp/mysql_tools/run.sh"]
