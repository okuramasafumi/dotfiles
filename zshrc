# zshrc

# Config directory
ZSH_DIR="$HOME/.zsh"

# Remove dups from paths
typeset -U path cdpath fpath manpath

# Add some completions (we need this before compinit)
[ -e /opt/boxen/homebrew/share/zsh-completions ] && fpath=(/opt/boxen/homebrew/share/zsh-completions $fpath)
#[ -f /opt/boxen/homebrew/share/zsh/site-functions/git-completion.bash ] && source /opt/boxen/homebrew/share/zsh/site-functions/git-completion.bash

# The most important feature of zsh
autoload -Uz compinit
compinit

# Boxen
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh
[ -f /opt/boxen/nvm/nvm.sh ] && source /opt/boxen/nvm/nvm.sh

# Antigen
source $ZSH_DIR/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle git-flow
antigen bundle rails4
antigen theme simple

antigen apply
