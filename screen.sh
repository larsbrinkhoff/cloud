#! /bin/sh

set -ex

. ./conf.sh
NAME="cloud"

stop() {
    screen -S "$NAME" -X quit
}

trap stop INT TERM QUIT EXIT

if command -v emacs; then
    EMACS="emacs -nw"
fi

cd $HOME
screen -d -m -U -S "$NAME" $EMACS

while :; do
    echo "Cloud screen is alive."
    sleep 3600
done
