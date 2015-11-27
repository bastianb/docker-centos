FROM bastianb/centos6.5

MAINTAINER Bretagne Bastian <bastian.b@webinterpret.com>

# Get essentials
RUN yum groupinstall -y "Development tools" && \
    yum install -y zlib-devel bzip2-devel openssl-devel wget tar

# Install python 3.4.3
RUN wget https://www.python.org/ftp/python/3.4.3/Python-3.4.3.tgz && \
    tar -zxvf Python-3.4.3.tgz -C /tmp/
RUN cd /tmp/Python-3.4.3 && \
    ./configure --prefix=/usr/local --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib" && \
    make && \
    make altinstall

RUN export PATH="/usr/local/bin:$PATH"
ENV LANG=en_US.utf8
ENV LC_ALL=en_US.utf8

# Python3.4 comes up with pip-3.4 and easy_install-3.4 and pyvenv-3.4 
# no need to install additional packages

# Cleanup
RUN rm -rf /tmp/Python-3.4.3*

CMD ["python3.4"]
