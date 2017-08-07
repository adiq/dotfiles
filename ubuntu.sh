#!/bin/bash
# Rutger's Ubuntu 16.04 setup script

# Fail on any error
set -e

echo "Installing apt tools for getting the best and latest software"
sudo apt update
sudo apt install -y \
  software-properties-common \
  python-software-properties
sudo add-apt-repository -y ppa:pi-rho/dev
sudo apt update

echo "Upgrading existing packages and installing some essentials with apt"
sudo apt upgrade -y
sudo apt install -y \
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
sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
sudo apt update
sudo apt install -y docker-ce

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
ln -sf ~/dotfiles/vim ~/.vim
ln -sf ~/dotfiles/vimrc ~/.vimrc
ln -sf ~/dotfiles/vimrc.bundles ~/.vimrc.bundles
ln -sf ~/dotfiles/vimrc.filetypes ~/.vimrc.filetypes
ln -sf ~/dotfiles/tmux.conf ~/.tumx.conf
ln -sf ~/dotfiles/zshrc ~/.zshrc

cd ~
echo "You're ready to go!"
