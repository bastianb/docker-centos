Tiny containerized uWSGI python application

Description
-----------
Minimal setup of a Python app using uWSGI and runit.
Runit is used as an entry point for the container.
This way application is shutdown gracefully when SIGTERM is sent
from a `docker stop` command and take much less time to execute.

Python image: I am using a centos based image that I made earlier.
Its heavy and not optimized. Feel free to change it for any other python3 image ;)

Build Image
-----------

    docker build -t myapp:0.0.1-dev

Start Container
---------------

    docker run -d -p 8080:8080 myapp:0.0.1-dev
