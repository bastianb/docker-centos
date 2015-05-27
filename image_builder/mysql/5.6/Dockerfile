############################################################
# Dockerfile to build MySQL container images
# Based on bastianb/centos6
############################################################

# Set the base image to Ubuntu
FROM bastianb/centos6.5

# File Author / Maintainer
MAINTAINER Bretagne Bastian <bastian.b@webinterpret.com>

# Update system
RUN yum -y update && yum install -y wget

# Instal MySQL
RUN wget -P /tmp/ http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm && \
	rpm -Uvh /tmp/mysql-community-release-el6-5.noarch.rpm && \
	yum -y  install mysql-community-server

# Solves `/etc/init.d/mysqld: line 16: /etc/sysconfig/network: No such file or directory`
# On start up
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

# Add VOLUMEs to allow backup of config and databases
VOLUME  ["/data/mysql"]

EXPOSE 3306
CMD ["/tmp/mysql_tools/run.sh"]