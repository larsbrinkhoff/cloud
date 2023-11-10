#! /bin/sh

set -x

. ./conf.sh
OPTIONS="-o ServerAliveInterval=5 -l $USER -N -R $PORT:localhost:22"

announce() {
    ssh -l "$USER" "$SERVER" echo "$1" '>>' .nodes
}

stop() {
    announce "stop $PORT $NAME"
}

trap stop INT TERM QUIT EXIT

# Wait for network to come up.
while ! ping -c1 "$SERVER"; do
    sleep 5
done

# Wait for screen to come up.
while ! screen -ls | grep -q cloud; do
    sleep 5
done

# Announce my name to the server.
while ! announce "start $PORT $NAME"; do
    echo Retrying...;
    sleep 5
done

echo Starting SSH
ssh $OPTIONS "$SERVER"
echo SSH exited: $?
exit $?
