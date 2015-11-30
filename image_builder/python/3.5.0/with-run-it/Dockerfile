FROM bastianb/centos:6.7_with-run-it

MAINTAINER Bretagne Bastian <bastian.b@webinterpret.com>

# Get essentials
# Get essentials
RUN yum -y install gcc rsyslog \
    wget tar zlib-devel \
    bzip2-devel openssl-devel \
    file

# Install python 3.5.0 and pip
WORKDIR /tmp/
RUN wget https://www.python.org/ftp/python/3.5.0/Python-3.5.0.tgz && \
    tar -zxvf Python-3.5.0.tgz

WORKDIR /tmp/Python-3.5.0
RUN ./configure --prefix=/usr/local --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib" && \
    make && \
    make altinstall
RUN export PATH="/usr/local/bin:$PATH"

WORKDIR /tmp/
RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python3.5 get-pip.py

WORKDIR /
ENV LC_ALL=en_US.utf8
ENV LANG=en_US.utf8

# Cleanup
RUN rm -rf /tmp/Python-3.5.0* /tmp/get-pip.py

CMD ["python3.5"]
