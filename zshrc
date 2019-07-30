export ZSH=~/.oh-my-zsh

ZSH_THEME="ys"

plugins=(cp git node pip python docker kubectl)

source $ZSH/oh-my-zsh.sh

############################## User configuration ##############################

# ssh
export SSH_KEY_PATH="~/.ssh/id_ed25519"

# Default user
export DEFAULT_USER=$(whoami)

source ~/.zsh_aliases

# FASD
eval "$(fasd --init auto)"

############################## Path configuration ##############################

# nvm init
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Yarn: https://yarnpkg.com/en/docs/install
export PATH=$PATH:`yarn global bin`

# Add Google Cloud Platform to PATH
# export PATH="$HOME/Software/google-cloud-sdk/bin:$PATH"
# source ~/Software/google-cloud-sdk/completion.zsh.inc

# Local User Defined RC script
source ~/.zshrc-local
