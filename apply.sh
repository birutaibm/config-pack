#!/bin/bash
if ! [ $(id -u) = 0 ]; then
   echo "The script need to be run as root." >&2
   exit 1
fi
if [ $SUDO_USER ]; then
    real_user=$SUDO_USER
else
    real_user=$(whoami)
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
apt-get install -y maven
apt-get install -y git
apt-get install -y gimp inkscape
apt-get install -y python3-gpg dropbox
add-apt-repository ppa:openshot.developers/ppa
add-apt-repository ppa:openshot.developers/libopenshot-daily
apt-get update
apt-get install -y openshot-qt libopenshot
snap install --classic eclipse
snap install node --classic --channel=13/stable
apt-get -o Dpkg::Options::="--force-overwrite" install -y yarn
snap install code --classic
snap install insomnia
apt install -y fonts-firacode
npm install -g eslint
npm install -g expo-cli
apt install -y zsh

cd ~
sudo -u $real_user git clone https://github.com/birutaibm/config-pack.git
cd config-pack
git remote rename origin github

# create .gitconfig
rm ~/.gitconfig
sudo -u $real_user ln -rs ./.gitconfig ~/.gitconfig
sudo -u $real_user mkdir ~/.config/Code
sudo -u $real_user mkdir ~/.config/Code/User
sudo -u $real_user ln -rs vscode/settings.json ~/.config/Code/User/settings.json

sudo -u $real_user chsh -s $(which zsh)
sudo -u $real_user sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

