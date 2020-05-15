#! /bin/sh

echo "Installing to $HOME, OK?"
read x

echo "Checking for screen."
command -v screen || exit 1

. conf.sh || exit 1

echo "Configuration:"
echo SERVER=$SERVER
echo PORT=$PORT
echo USER=$USER
echo NAME=$NAME

echo "Copy key to $SERVER."
ssh-copy-id "$USER@$SERVER" || exit 1

mkdir -p /usr/local/bin
mkdir -p $HOME/bin

cp init.sh conf.sh /usr/local/bin
cp attach.sh conf.sh $HOME/bin

rm -f /etc/rc5.d/S90cloud

# Have init run the init.sh script.
test -d /etc/init.d && cp init.sh /etc/init.d/cloud.sh
test -d /etc/rc5.d && ln -s /etc/init.d/cloud.sh /etc/rc5.d/S90cloud
test -d /etc/systemd/system && cp cloud.service /etc/systemd/system
command -v systemctl && systemctl enable cloud.service
