#! /bin/sh

set -ex

. ./conf.sh
NAME="cloud"

stop() {
    screen -S "$NAME" -X quit
}

trap stop INT TERM QUIT EXIT

cd $HOME
screen -d -m -U -S "$NAME"

while :; do
    echo "Cloud screen is alive."
    sleep 3600
done
