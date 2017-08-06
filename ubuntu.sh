#!/bin/bash
# Rutger's Ubuntu 16.04 setup script

# Fail on any error
set -e

# Helpers
fancy_echo() {
  local fmt="$1"; shift
  printf "\n$fmt\n" "$@"
}

# Require root
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

fancy_echo "Installing apt tools for getting the best and latest software"
apt update
apt install -y \
  software-properties-common \
  python-software-properties
add-apt-repository -y ppa:pi-rho/dev
apt update

fancy_echo "Upgrading existing packages and installing some essentials with apt"
apt upgrade -y
apt install -y \
  apt-transport-https \
  build-essential \
  cmake \
  curl \
  curl \
  exuberant-ctags \
  gcc \
  git \
  haskell-platform \
  openssl \
  silversearcher-ag \
  tmux \
  vim-gtk \
  zsh

fancy_echo "Installing Docker CE"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
apt update
apt install -y docker-ce

fancy_echo "Installing nvm"
if [ ! -d ~/.nvm ]; then
  git clone https://github.com/creationix/nvm.git ~/.nvm;
fi

fancy_echo "Installing pyenv"
if [ ! -d ~/.pyenv ]; then
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv;
fi

fancy_echo "Installing rbenv"
if [ ! -d ~/.rbenv ]; then
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv;
fi

cd ~
fancy_echo "You're ready to go!"
