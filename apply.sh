#!/bin/bash

if ! [ $(id -u) = 0 ]; then
   echo "The script need to be run as root." >&2
   exit 1
fi

# basic packages
apt install -y curl
apt-get install -y python-software-properties
apt install -y snapd

# configure apt
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list
curl -sL https://deb.nodesource.com/setup_13.x | bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg |  apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
apt update

# install
apt install -y google-chrome-stable
apt install -y openjdk-11-jdk
apt-get install -y eclipse
apt-get install -y maven
apt-get install -y git
snap install node --classic
apt-get -o Dpkg::Options::="--force-overwrite" install -y yarn
snap install -y code --classic
snap install insomnia
apt install -y fonts-firacode
npm install -g eslint
npm install -g expo-cli
apt install -y zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# init current dir as config-pack git repository
git init
git remote add github https://github.com/birutaibm/config-pack.git


# create .gitconfig
ln -rs ./.gitconfig ~/.gitconfig
ln -rs vscode/settings.json ~/.config/Code/User/settings.json

