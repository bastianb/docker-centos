############################################################
# Dockerfile to build PostGres container images
# Based on bastianb/centos6.5
############################################################

# Set the base image to Centos
FROM bastianb/centos6.5

# File Author / Maintainer
MAINTAINER Bretagne Bastian <bastian.b@webinterpret.com>

# Install dependencies
RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

RUN yum install -y pwgen

#Install PostgreSQL-9.3
RUN yum install -y postgres

# Adjust PostgreSQL configuration so that remote connections to the database are possible. 
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf


# Add VOLUMEs to allow backup of config, logs and databases
VOLUME	["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

ADD modify_postgres_pass.sh ./modify_postgres_pass.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh

EXPOSE 5432
CMD ["/run.sh"]
