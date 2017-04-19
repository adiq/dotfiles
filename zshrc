# Path to oh-my-zsh installation.
export ZSH=/Users/rutgerfarry/.oh-my-zsh

# Theme
ZSH_THEME="ys"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Path configuration
# Yarn: https://yarnpkg.com/en/docs/install
export PATH="$PATH:`yarn global bin`"

