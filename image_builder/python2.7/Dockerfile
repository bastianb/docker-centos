############################################################
# Dockerfile to build pythom 2.7.6 container images
# Based on bastianb/centos6.5
############################################################

# Set the base image to Centos
FROM bastianb/centos6.5

# File Author / Maintainer
MAINTAINER Bretagne Bastian <bastian.b@webinterpret.com>

# Get essentials
# RUN yum update -y  # Is it really necessary?
RUN	yum groupinstall -y "Development tools" && \
	yum install -y zlib-devel bzip2-devel openssl-devel wget tar

# Install python 2.7
RUN wget https://www.python.org/ftp/python/2.7.6/Python-2.7.6.tgz && \
	tar -zxvf Python-2.7.6.tgz -C /tmp/
RUN cd /tmp/Python-2.7.6 && \
	./configure --prefix=/usr/local --enable-unicode=ucs4 --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib" && \
    make && \
	make altinstall

RUN export PATH="/usr/local/bin:$PATH"

# Install setuptools 1.4.2
RUN wget --no-check-certificate https://pypi.python.org/packages/source/s/setuptools/setuptools-1.4.2.tar.gz && \
	tar -zxvf setuptools-1.4.2.tar.gz -C /tmp/
RUN cd /tmp/setuptools-1.4.2 && \
	python2.7 setup.py install

# Latest pip
RUN easy_install-2.7 -U pip
# upgrade pip and setuptools
RUN pip install -U setuptools pip virtualenv

# Do a cleanup
RUN rm -rf /tmp/Python-2.7.6 && \
    rm -rf /tmp/setuptools-1.4.2

CMD ["/bin/bash"]
