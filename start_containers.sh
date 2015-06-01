#!/bin/bash

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


echo "Do you want to use persistence? "
select yn in "Yes" "No"; do
    case $yn in
        Yes ) persistence=**True**; break;;
        No ) exit;;
    esac
done

if [ "$persistence" == "**True**" ]; then
  default=/data/docker_volumes
  read -p "Enter docker volume for persitence storage[$default]: " DATA_VOL
  DATA_VOL=${DATA_VOL:-$default}
  echo "=> data volume: $DATA_VOL"

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
  cmd_mysql='docker run --name mysql-server-5.6 -d -p 3306:3306 -v /data/docker_volumes/mysql:/var/lib/mysql bastianb/mysql5.6'
  cmd_rabbitmq='docker run --name rabbitmq-server -d -p 5672:5672 -p 15672:15672 -h rabbithost -v /data/docker_volumes/rabbitmq/mnesia:/var/lib/rabbitmq/mnesia bastianb/rabbitmq'
  cmd_memcached='docker run --name memcached -d -p 11211:11211 bastianb/memcached'
  cmd_mongodb='docker run --name mongodb-2.6 -d -p 27017:27017 -p 28017:28017 -v /data/docker_volumes/mongo:/data/db bastianb/mongod2.6'
else
  cmd_mysql='docker run --name mysql-server-5.6 -d -p 3306:3306  bastianb/mysql5.6'
  cmd_rabbitmq='docker run --name rabbitmq-server -d -p 5672:5672 -p 15672:15672 -h rabbithost bastianb/rabbitmq'
  cmd_memcached='docker run --name memcached -d -p 11211:11211 bastianb/memcached'
  cmd_mongodb='docker run --name mongodb-2.6 -d -p 27017:27017 -p 28017:28017 bastianb/mongod2.6'
fi

echo "=> Creating docker volume storage.."
mkdir -p $DATA_VOL && echo OK || echo "Failed - Are you trying to create a directory to a protected place? 
Try running the script with sudo."


echo "=>Stopping Host Services"
echo "=>Stopping  MySQL"
sudo /etc/init.d/mysql stop && echo OK
echo "=>Stopping Memcached"
sudo /etc/init.d/memcached stop && echo OK
echo "=>Stopping Mongod"
sudo /etc/init.d/mongodb stop && echo OK
echo "=>Stopping RabbitMQ Server"
sudo /etc/init.d/rabbitmq-server stop && echo OK

echo "=>Starting containers"
RUNNING=$(docker inspect --format="{{ .State.Running }}" mysql-server-5.6 2> /dev/null)
if [ "$RUNNING" == "false" ] || [ "$RUNNING" == "true" ]; then
  echo "=>CRITICAL - mysql-server-5.6 already exist removing"
  docker stop mysql-server-5.6 2> /dev/null && \
  docker rm   mysql-server-5.6 2> /dev/null
  echo "=>Stopped and removed"
fi
$cmd_mysql && echo MySQL - OK



RUNNING=$(docker inspect --format="{{ .State.Running }}" mongodb-2.6 2> /dev/null)
if [ "$RUNNING" == "false" ] || [ "$RUNNING" == "true" ]; then
  echo "=>CRITICAL - mongodb-2.6 already exist removing"
  docker stop mongodb-2.6 2> /dev/null && \
  docker rm  mongodb-2.6 2> /dev/null
  echo "=>Stopped and removed"
fi
$cmd_mongodb && echo Mongod -  OK



RUNNING=$(docker inspect --format="{{ .State.Running }}" memcached 2> /dev/null)
if [ "$RUNNING" == "false" ] || [ "$RUNNING" == "true" ]; then
  echo "=>CRITICAL - memcached already exist removing"
  docker stop memcached 2> /dev/null && \
  docker rm  memcached 2> /dev/null
  echo "=>Stopped and removed"
fi
$cmd_memcached && echo Memcached - OK


RUNNING=$(docker inspect --format="{{ .State.Running }}" rabbitmq-server 2> /dev/null)
if [ "$RUNNING" == "false" ] || [ "$RUNNING" == "true" ]; then
  echo "=>CRITICAL - rabbitmq-server already exist removing"
  docker stop rabbitmq-server 2> /dev/null && \
  docker rm  rabbitmq-server 2> /dev/null
  echo "=>Stopped and removed"
fi
$cmd_rabbitmq && echo RabbitMq-Server - OK

echo "Done"

