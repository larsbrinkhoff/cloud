#! /bin/sh

exec > /tmp/cloud.log 2>&1
set -x

cd /usr/local/bin
. conf.sh

connect(){
    while :; do
        echo Starting SSH
        ssh -l "$USER" -N -R "$PORT":localhost:22 "$SERVER" &
        PID="$!"
        echo "$PID" > /tmp/cloud.pid
        echo Waiting...
        wait
        echo SSH exited: $?
    done
}

start() {
    # Start a new screen in detached state.
    cd $HOME
    screen -d -m -U -S cloud

    # Announce my name to the server.
    while ! ssh -l "$USER" "$SERVER" echo start "$PORT" "$NAME" '>>' .nodes; do
        echo Retrying...;
        sleep 5
    done

    # Forward server port here.
    connect &
    exit 0
}

stop() {
    screen -S cloud -X quit
    PID=`cat /tmp/cloud.pid`
    ssh -l "$USER" "$SERVER" echo stop "$PORT" "$NAME" '>>' .nodes
    kill "$PID"
    sleep 2
    kill -9 "$PID"
    rm -f /tmp/cloud.pid
    exit 0
}

test `whoami` = "$USER" && "$1"
su "$USER" /usr/local/bin/init.sh "$1"
