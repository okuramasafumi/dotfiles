# zshrc

# Load uitily function
autoload -Uz is-at-least

# Config directory
ZSH_DIR="$HOME/.zsh"

# Remove dups from paths
typeset -aU path cdpath fpath manpath

# Add some completions (we need this before compinit)
[ -e /opt/boxen/homebrew/share/zsh-completions ] && fpath=(/opt/boxen/homebrew/share/zsh-completions $fpath)
#[ -f /opt/boxen/homebrew/share/zsh/site-functions/git-completion.bash ] && source /opt/boxen/homebrew/share/zsh/site-functions/git-completion.bash

# The most important feature of zsh
autoload -Uz compinit
compinit

# cdr
if is-at-least 4.3.11; then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ":chpwd:*" recent-dirs-max 500
  zstyle ":chpwd:*" recent-dirs-defalut true
  zstyle ":completion:*" recent-dirs-insert always
fi

# Boxen
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh
[ -f /opt/boxen/nvm/nvm.sh ] && source /opt/boxen/nvm/nvm.sh

# My aliases
source $ZSH_DIR/aliases.zsh

# Antigen
source $ZSH_DIR/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle git-flow
antigen bundle rails4
antigen theme simple

antigen apply

# Zaw
source $ZSH_DIR/zaw/zaw.zsh
zstyle ":filter:select" case-insensitive yes
bindkey "^X'" zaw-cdr

# Reload path to remove dups
path=($path)
