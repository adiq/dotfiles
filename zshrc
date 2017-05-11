# Open tmux on login
if [ "$TMUX" = "" ]; then tmux; fi

# Path to oh-my-zsh installation.
export ZSH=/Users/rutgerfarry/.oh-my-zsh

# Theme
ZSH_THEME="agnoster"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(brew cabal cp docker git node pip pod python stack tmux)

source $ZSH/oh-my-zsh.sh

# User configuration

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Default user
export DEFAULT_USER=rutgerfarry

# Path configuration

# Yarn: https://yarnpkg.com/en/docs/install
export PATH=$PATH:`yarn global bin`
# Add packages installed with `pip3 install --user`
export PATH=~/Library/Python/3.6/bin:$PATH
# Use rbenv Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
# Haskell (Stack) https://github.com/commercialhaskell/stack
export PATH=~/.local/bin:$PATH
# Use MacVim's version of vim
export PATH=~/bin:$PATH
