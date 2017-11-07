#!/bin/bash
# Rutger's Ubuntu 16.04 setup script

# Fail on any error
set -e

whitespace_echo() {
  printf "\n\n### $1 ###\n"
}

printf "🙆‍  Oh no!! Your computer's all fucked! Don't worry, the software boi is on it 🏃👌"

whitespace_echo "Adding Oh My Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

whitespace_echo "Installing nvm"
if [ ! -d ~/.nvm ]; then
  git clone https://github.com/creationix/nvm.git ~/.nvm;
fi

whitespace_echo "Installing pyenv"
if [ ! -d ~/.pyenv ]; then
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv;
fi

whitespace_echo "Installing powerline fonts"
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts && ./install.sh
cd .. && rm -rf fonts

whitespace_echo "Installing dotfiles"
if [ ! -d ~/Projects/dotfiles ]; then
  git clone https://github.com/rutgerfarry/dotfiles ~/Projects/dotfiles
fi
ln -sf ~/Projects/dotfiles/vim             ~/.vim
ln -sf ~/Projects/dotfiles/vimrc           ~/.vimrc
ln -sf ~/Projects/dotfiles/vimrc.bundles   ~/.vimrc.bundles
ln -sf ~/Projects/dotfiles/vimrc.filetypes ~/.vimrc.filetypes
ln -sf ~/Projects/dotfiles/tmux.conf       ~/.tmux.conf
ln -sf ~/Projects/dotfiles/zshrc           ~/.zshrc

cd ~
whitespace_echo "You're ready to go!"
