#!/bin/bash

BRANCH=$1
ELK_SERVER_IP=$2

sudo apt-get update
sudo apt-get install git -y

CLONE_PATH=~/touchstone
git clone https://github.com/BigWhale/touchstone.git $CLONE_PATH
pushd $CLONE_PATH

if [ "$BRANCH" != "master" ]; then
    git checkout -b $BRANCH origin/$BRANCH
fi

pushd logging/rsyslog/server
./install.sh $ELK_SERVER_IP
popd

popd
