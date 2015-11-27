FROM bastianb/centos6.5

MAINTAINER Bretagne Bastian <bastian.b@webinterpret.com>

# Get essentials
RUN yum groupinstall -y "Development tools" && \
    yum install -y zlib-devel bzip2-devel openssl-devel wget tar

# Install python 3.5.0
RUN wget https://www.python.org/ftp/python/3.5.0/Python-3.5.0.tgz && \
    tar -zxvf Python-3.5.0.tgz -C /tmp/
RUN cd /tmp/Python-3.5.0 && \
    ./configure --prefix=/usr/local --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib" && \
    make && \
    make altinstall

RUN export PATH="/usr/local/bin:$PATH"

# Enable utf support
ENV LC_ALL=en_US.utf8
ENV LANG=en_US.utf8

# Python3.5 come up with pip-3.5 and easy_install-3.5 and pyvenv-3.5 
# no need to install additional packages

# Cleanup
RUN rm -rf /tmp/Python-3.5.0*

CMD ["python3.5"]
