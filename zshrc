# Open tmux on login
if [ "$TMUX" = "" ]; then tmux; fi

# Path to oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Theme
ZSH_THEME="agnoster"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(cp git node pip python docker)

source $ZSH/oh-my-zsh.sh

############################## User configuration ##############################

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Default user
export DEFAULT_USER=rutgerfarry

############################## Path configuration ##############################

# nvm init
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Yarn: https://yarnpkg.com/en/docs/install
export PATH=$PATH:`yarn global bin`

# rbenv init
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Haskell Stack https://github.com/commercialhaskell/stack
export PATH=~/.local/bin:$PATH

# OPAM configuration
. ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# Pyenv init
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
