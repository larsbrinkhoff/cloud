#! /bin/sh

stty -ixon

cd $HOME/bin
. conf.sh

PORT="$1"

while :; do
    ssh -t -l "$USER" -p "$PORT" "$SERVER" screen -U -S cloud -x
    sleep 2
done
