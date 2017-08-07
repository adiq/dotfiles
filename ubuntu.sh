#!/bin/bash
# Rutger's Ubuntu 16.04 setup script

# Fail on any error
set -e

# Require root
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

echo "Installing apt tools for getting the best and latest software"
apt update
apt install -y \
  software-properties-common \
  python-software-properties
add-apt-repository -y ppa:pi-rho/dev
apt update

echo "Upgrading existing packages and installing some essentials with apt"
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

echo "Installing Docker CE"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
apt update
apt install -y docker-ce

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

echo "Adding Oh My Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Installing dotfiles"
git clone https://github.com/rutgerfarry/dotfiles ~/dotfiles
ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/vimrc.bundles ~/.vimrc.bundles
ln -s ~/dotfiles/vimrc.filetypes ~/.vimrc.filetypes
ln -s ~/dotfiles/tmux.conf ~/.tumx.conf
ln -s ~/dotfiles/zshrc ~/.zshrc

cd ~
echo "You're ready to go!"
