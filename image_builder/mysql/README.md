# docker-mysql

Base docker image to run a MySQL database server


## MySQL version

5.6


## Usage

To create the image `bastianb/mysql`, execute the following command on the mysql folder:

        docker build -t bastianb/mysql 5.6/

To run the image and bind to port 3306:

        docker run -d -p 3306:3306 bastianb/mysql

The first time that you run your container, a new user `admin` with all privileges will be created in MySQL with a random password. To get the password, check the logs of the container by running:

        docker logs <CONTAINER_ID>

You will see an output like the following:

        =======================================================================
        You can now connect to this MySQL Server using:
            mysql -uadmin -p47nnf4FweaKu -h<host> -P<port>
        Please remember to change the above password as soon as possible!
        MySQL user 'root' has no password but only allows local connections.
        =======================================================================

In this case, `47nnf4FweaKu` is the password allocated to the `admin` user.

Remember that the `root` user has no password, but it's only accessible from within the container.

You can now test your deployment:

        mysql -uadmin -p

Done!


## Setting a specific password for the admin account

If you want to use a preset password instead of a random generated one, you can set the environment variable `MYSQL_PASS` to your specific password when running the container:

        docker run -d -p 3306:3306 -e MYSQL_PASS="mypass" bastianb/mysql

You can now test your deployment:

        mysql -uadmin -p"mypass"

The admin username can also be set via the `MYSQL_USER` environment variable.



## Creating a database on container creation


If you want a database to be created inside the container when you start it up
for the first time you can set the environment variable `MYSQL_DB` to string
that names the database.

        docker run -d -p 3306:3306 -e ON_CREATE_DB="database" bastianb/mysql


## Mounting the database file volume

In order to persist the database data, you can mount a local folder from the host
on the container to store the database files. To do so:

        docker run -d -v /path/in/host:/var/lib/mysql bastianb/mysql /bin/bash -c "/usr/bin/mysql_install_db"

This will mount the local folder `/path/in/host` inside the docker in `/var/lib/mysql` (where MySQL will store the database files by default). `mysql_install_db` creates the initial database structure.

Remember that this will mean that your host must have `/path/in/host` available when you run your docker image!

After this you can start your MySQL image, but this time using `/path/in/host` as the database folder:

        docker run -d -p 3306:3306 -v /path/in/host:/var/lib/mysql bastianb/mysql


## Migrating an existing MySQL Server


In order to migrate your current MySQL server, perform the following commands from your current server:

To dump your databases structure:

        mysqldump -u<user> -p --opt -d -B <database name(s)> > /tmp/dbserver_schema.sql

To dump your database data:

        mysqldump -u<user> -p --quick --single-transaction -t -n -B <database name(s)> > /tmp/dbserver_data.sql

To import a SQL backup which is stored for example in the folder `/tmp` in the host, run the following:

        sudo docker run -d -v /tmp:/tmp bastianb/mysql /bin/bash -c "/import_sql.sh <user> <pass> /tmp/<dump.sql>"

Also, you can start the new database initializing it with the SQL file:

        sudo docker run -d -v /path/in/host:/var/lib/mysql -e STARTUP_SQL="/tmp/<dump.sql>" bastianb/mysql

Where `<user>` and `<pass>` are the database username and password set earlier and `<dump.sql>` is the name of the SQL file to be imported.


## Replication - Master/Slave

To use MySQL replication, please set environment variable `REPLICATION_MASTER`/`REPLICATION_SLAVE` to `true`. Also, on master side, you may want to specify `REPLICATION_USER` and `REPLICATION_PASS` for the account to perform replication, the default value is `replica:replica`

Examples:
- Master MySQL
-
        docker run -d -e REPLICATION_MASTER=true -e REPLICATION_PASS=mypass -p 3306:3306 --name mysql bastianb/mysql

- Example on Slave MySQL:
-
        docker run -d -e REPLICATION_SLAVE=true -p 3307:3306 --link mysql:mysql bastianb/mysql

Now you can access port `3306` and `3307` for the master/slave MySQL.

## Environment variables

`MYSQL_USER`: Set a specific username for the admin account (default 'admin').

`MYSQL_PASS`: Set a specific password for the admin account.

`STARTUP_SQL`: Defines one or more SQL scripts separated by spaces to initialize the database. Note that the scripts must be inside the container, so you may need to mount them.

## Compatibility Issues

- Volume created by MySQL 5.6 cannot be used in MySQL 5.5 Images.
