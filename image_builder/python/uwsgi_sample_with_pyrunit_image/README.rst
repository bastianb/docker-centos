Tiny containerized uWSGI python application

Description
-----------
Minimal setup of a Python app using uWSGI and runit based on bastianb/python:3.4.3_with-run-it.
Runit is used as an entry point for the container.
This way application is shutdown gracefully when SIGTERM is sent
from a `docker stop` command thanks to runsvinit entry point.
See: https://github.com/bastianb/docker-centos/tree/master/tools/runit/go-runsvinit

Build Image
-----------

    docker build -t myapp:0.0.1-dev .

Start Container
---------------

    docker run -d -p 8080:8080 myapp:0.0.1-dev
