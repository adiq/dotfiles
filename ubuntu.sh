#!/bin/bash
# Rutger's Ubuntu 16.04 setup script

# Fail on any error
set -e

echo "Installing apt tools for getting the best and latest software"
sudo apt update
sudo apt install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  python-software-properties \
  software-properties-common

# Common package repository
sudo add-apt-repository -y ppa:pi-rho/dev

# Spotify
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
  --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 \
  0DF731E45CE24F27EEEB1450EFDC8610341D9410
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Load new package repos
sudo apt update

echo "Upgrading existing packages and installing some essentials with apt"
sudo apt upgrade -y
sudo apt install -y \
  build-essential \
  cmake \
  docker-ce \
  exuberant-ctags \
  gcc \
  git \
  google-chrome-stable \
  haskell-platform \
  libbz2-dev \
  libncurses5-dev \
  libncursesw5-dev \
  libreadline-dev \
  libsqlite3-dev \
  libssl-dev \
  linux-image-extra-$(uname -r) \
  linux-image-extra-virtual \
  llvm \
  make \
  openssl \
  silversearcher-ag \
  spotify-client \
  tk-dev\
  tmux \
  vim-gtk \
  wget \
  xz-utils \
  zlib1g-dev \
  zsh

echo "Customizing Docker for non-root usage"
sudo groupadd docker
sudo usermod -aG docker $USER

echo "Installing docker-compose"
sudo curl -L \
  https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o \
  /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Installing nvm"
if [ ! -d ~/.nvm ]; then
  git clone https://github.com/creationix/nvm.git ~/.nvm;
fi

echo "Installing pyenv"
if [ ! -d ~/.pyenv ]; then
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv;
fi

echo "Installing rbenv"
if [ ! -d ~/.rbenv ]; then
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv;
fi

echo "Installing Google Chrome"
curl -oj https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

echo "Installing Slack"
curl -oj https://downloads.slack-edge.com/linux_releases/slack-desktop-2.8.2-amd64.deb
sudo apt install ./slack-desktop-2.8.2-amd64.deb
rm slack-desktop-2.8.2-amd64.deb

echo "Adding Oh My Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Installing dotfiles"
git clone https://github.com/rutgerfarry/dotfiles ~/dotfiles
ln -sf ~/dotfiles/vim ~/.vim
ln -sf ~/dotfiles/vimrc ~/.vimrc
ln -sf ~/dotfiles/vimrc.bundles ~/.vimrc.bundles
ln -sf ~/dotfiles/vimrc.filetypes ~/.vimrc.filetypes
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/zshrc ~/.zshrc

cd ~
echo "You're ready to go!"
