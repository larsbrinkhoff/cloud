#! /bin/sh

echo "Installing to $HOME, OK?"
read x

echo "Checking for screen."
command -v screen || exit 1
echo "Checking for systemd."
command -v systemctl || exit 1
test -d /etc/systemd/system || exit 1

. ./conf.sh || exit 1

echo "Configuration:"
echo SERVER=$SERVER
echo PORT=$PORT
echo USER=$USER
echo NAME=$NAME

echo "Copy key to $SERVER."
ssh-copy-id "$USER@$SERVER" || exit 1

mkdir -p $HOME/bin

cp attach.sh $HOME/bin

cp cloud-screen.service /etc/systemd/system
cp cloud-tunnel.service /etc/systemd/system
systemctl daemon-reload
systemctl enable cloud-screen.service
systemctl enable cloud-tunnel.service
systemctl restart cloud-tunnel.service
