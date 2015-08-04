#!/bin/bash

if [ -f /data/db/.mongodb_password_set ]; then
	echo "MongoDB password already set!"
	exit 0
fi

mongod --smallfiles --nojournal &

DB=${MONGODB_DB:-"test"}
PASS=${MONGODB_PASS:-$(pwgen -s 12 1)}
USER=${MONGODB_USER:-"admin"}
_word=$( [ ${MONGODB_PASS} ] && echo "preset" || echo "random" )

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MongoDB service startup"
    sleep 5
    mongo admin --eval "help" >/dev/null 2>&1
    RET=$?
done

echo "=> Creating ${USER} user with a ${_word} password in MongoDB"
mongo --eval "db.getSiblingDB('$DB').createUser({user: '$USER', pwd: '$PASS', roles:[{role: 'dbOwner', db: '$DB'}]});"
echo "=> Creating root role in MongoDB"
mongo admin --eval "db.createUser({user: '$USER', pwd: '$PASS', roles:[{role:'root',db:'admin'}]});"
mongo admin --eval "db.shutdownServer();"

echo "=> Done!"
touch /data/db/.mongodb_password_set

echo "========================================================================"
echo "You can now connect to this MongoDB server using:"
echo ""
echo "    mongo $DB -u $USER -p $PASS --host <host> --port <port>"
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "========================================================================"
