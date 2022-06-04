#! /bin/sh

stty -ixon -ixoff

cd $HOME/bin
. ./conf.sh

PORT="$1"
HOST=`ssh -l $USER $SERVER grep \"start $PORT\" .nodes | tail -1 | cut -d' ' -f3`
printf "\033]0;$HOST\007"

OPTIONS="-o ServerAliveInterval=5 -t -l $USER -p $PORT"
while :; do
    ssh $OPTIONS "$SERVER" screen -U -S cloud -x
    sleep 2
done
