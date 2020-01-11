#!/bin/bash

if ! [ $(id -u) = 0 ]; then
   echo "The script need to be run as root." >&2
   exit 1
fi

# install google chrome
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list
apt update
apt install -y google-chrome-stable

apt install -y curl
apt install -y openjdk-11-jdk
apt-get install eclipse
apt-get install git
git init
git remote add github https://github.com/birutaibm/config-pack.git

# create .gitconfig
ln -rs ./.gitconfig ~/.gitconfig
