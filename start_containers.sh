#!/bin/bash

################################
# Prevent stopping local service
################################
echo "This script will stop your following services using /etc/init.d: "
echo "    memcached"
echo "    mysql"
echo "    mongo"
echo "    rabbitmq-server"
echo "Do you want to continue? "
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) exit;;
    esac
done


###########################
# Service password and user
###########################
default_user="admin"
echo "Choose admin username"
echo "If volumes already exists it won't be overriden"
echo "Only works for new containers"
read -p "Choose usernam [$default_user]:" USER
USER=${USER:-$default_user}

default_pass=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-20};echo;)
echo "Only works for new containers"
read -p "Choose admin password [$default_pass]:" PASS
PASS=${PASS:-$default_pass}


######################
# Ask for persistence
######################
echo "Do you want to use persistence? "
select yn in "Yes" "No"; do
    case $yn in
        Yes ) persistence=**True**; break;;
        No ) exit;;
    esac
done



######################
# Prepare persistence
######################
if [ "$persistence" == "**True**" ]; then
  # Ask for folder location
  default=/data/docker_volumes
  read -p "Enter docker volume for persitence storage[$default]: " DATA_VOL
  DATA_VOL=${DATA_VOL:-$default}
  echo "=> data volume: $DATA_VOL"

  # If folder already exists
  if [ -d "$DATA_VOL" ]; then
      # Control will enter here if $DATA_VOL exists.
      echo "=> $DATA_VOL already exists"
      echo "Are you shure that you want to continue?"
      select yn in "Yes" "No"; do
        case $yn in
            Yes ) break;;
            No ) exit;;
        esac
      done
  fi
  # Command with persistence
  persistence_mongo="-v $DATA_VOL/mongo:/data/db"
  persistence_mysql="-v $DATA_VOL/mysql:/var/lib/mysql"
  persistence_rabbit="-v $DATA_VOL/rabbitmq/mnesia:/var/lib/rabbitmq/mnesia"
fi

# Complete CMDs
cmd_mysql="docker run --name mysql-server-5.6 -d -p 3306:3306 -e MYSQL_USER=$USER -e MYSQL_PASS=$PASS $persistence_mysql bastianb/mysql5.6"
cmd_rabbitmq="docker run --name rabbitmq-server -d -p 5672:5672 -p 15672:15672 -h rabbithost -e RABBITMQ_USER=$USER -e RABBITMQ_PASS=$PASS $persistence_rabbit bastianb/rabbitmq"
cmd_mongodb="docker run --name mongodb-2.6 -d -p 27017:27017 -p 28017:28017 -e MONGODB_USER=$USER -e MONGODB_PASS=$PASS $persistence_mongo bastianb/mongod2.6"
cmd_memcached='docker run --name memcached -d -p 11211:11211 bastianb/memcached'

echo "=> Creating docker volume storage.."
mkdir -p $DATA_VOL && echo OK || echo "Failed - Are you trying to create a directory to a protected place? 
Try running the script with sudo."


echo "=>Stopping Host Services"
echo "=>Stopping  MySQL"
sudo /etc/init.d/mysql stop 
sudo service mysql stop
echo "=>Stopping Memcached"
sudo /etc/init.d/memcached stop
sudo service memcached stop
echo "=>Stopping Mongod"
sudo /etc/init.d/mongodb stop
sudo service mongodb stop
echo "=>Stopping RabbitMQ Server"
sudo /etc/init.d/rabbitmq-server stop 
sudo service rabbitmq-server stop

echo "=>Starting containers"

RUNNING=$(docker inspect --format="{{ .State.Running }}" mysql-server-5.6 2> /dev/null)
if [ "$RUNNING" == "false" ] || [ "$RUNNING" == "true" ]; then
  echo "=>CRITICAL - mysql-server-5.6 already exist removing"
  docker stop mysql-server-5.6 &> /dev/null \
    || docker rm mysql-server-5.6 &> /dev/null \
    && docker rm mysql-server-5.6 &> /dev/null \
    || echo "already removed"
  echo "=>Stopped and removed"
fi
$cmd_mysql && echo MySQL - OK



RUNNING=$(docker inspect --format="{{ .State.Running }}" mongodb-2.6 2> /dev/null)
if [ "$RUNNING" == "false" ] || [ "$RUNNING" == "true" ]; then
  echo "=>CRITICAL - mongodb-2.6 already exist removing"
  docker stop mongodb-2.6 &> /dev/null \
     || docker rm mongodb-2.6 &> /dev/null \
     && docker rm mongodb-2.6 &> /dev/null \
     || echo "already removed"
  echo "=>Stopped and removed"
fi
$cmd_mongodb && echo Mongod -  OK



RUNNING=$(docker inspect --format="{{ .State.Running }}" memcached 2> /dev/null)
if [ "$RUNNING" == "false" ] || [ "$RUNNING" == "true" ]; then
  echo "=>CRITICAL - memcached already exist removing"
  docker stop memcached &> /dev/null \
    || docker rm  memcached &> /dev/null \
    && docker rm  memcached &> /dev/null \
    || echo "already removed"
  echo "=>Stopped and removed"
fi
$cmd_memcached && echo Memcached - OK


RUNNING=$(docker inspect --format="{{ .State.Running }}" rabbitmq-server 2> /dev/null)
if [ "$RUNNING" == "false" ] || [ "$RUNNING" == "true" ]; then
  echo "=>CRITICAL - rabbitmq-server already exist removing"
  docker stop rabbitmq-server &> /dev/null \
    || docker rm rabbitmq-server &> /dev/null \
    && docker rm rabbitmq-server &> /dev/null \
    || echo "already removed"
  echo "=>Stopped and removed"
fi
$cmd_rabbitmq && echo RabbitMq-Server - OK

echo "Done, $USER $PASS"

