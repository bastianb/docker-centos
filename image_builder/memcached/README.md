#docker-memcached

Base docker image to run a Memcached server

##Usage

To create the image bastianb/memcached, execute the following command on the docker-memcached folder:

    docker build -t bastianb/memcached .
To run the image and bind to port 11211:

    docker run -d -p 11211:11211 bastianb/memcached

TODO - Not yet supported
The first time that you run your container, a new user memcached with all privileges will be created in Memcached with a random password. To get the password, check the logs of the container by running:

    docker logs <CONTAINER_ID>
You will see an output like the following:

```
========================================================================
You can now connect to this Memcached server using:

      USERNAME:admin      PASSWORD:h0znMbk3RkM8

Please remember to change the above password as soon as possible!
========================================================================
```

In this case, `h0znMbk3RkM8` is the password assigned to the `admin` user.

Done!

## Test connection

In a python shell, except a True:
```
import memcache
mc = memcache.Client(['0.0.0.0:11211'], debug=0)
mc.set('name', 'John Snow')
```

## TODO Setting a specific password for the admin account

If you want to use a preset password instead of a random generated one, you can set the environment variable MEMCACHED_PASS to your specific password when running the container:

    docker run -d -p 11211:11211 -e MEMCACHED_PASS="mypass" bastianb/memcached