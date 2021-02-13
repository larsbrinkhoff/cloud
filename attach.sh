#! /bin/sh

stty -ixon -ixoff

cd $HOME/bin
. conf.sh

PORT="$1"
OPTIONS="-o ServerAliveInterval=5 -t -l $USER -p $PORT"

while :; do
    ssh $OPTIONS "$SERVER" screen -U -S cloud -x
    sleep 2
done
