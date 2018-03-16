# Open tmux on login
if [ "$TMUX" = "" ]; then tmux; fi

export ZSH=~/.oh-my-zsh

ZSH_THEME="ys"

plugins=(cp git node pip python docker kubectl)

source $ZSH/oh-my-zsh.sh

############################## User configuration ##############################

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Default user
export DEFAULT_USER=$(whoami)

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

# Add Google Cloud Platform to PATH
export PATH="$HOME/Software/google-cloud-sdk/bin:$PATH"
source ~/Software/google-cloud-sdk/completion.zsh.inc

# Add LaTeX resources from MacTex installation to PATH
export PATH="/Library/TeX/texbin:$PATH"
