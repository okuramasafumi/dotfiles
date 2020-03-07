export GOPATH=~/.go

export EDITOR=nvim
export DISABLE_AUTO_TITLE=true
export TERM="xterm-256color"
export PATH="~/bin:$PATH:$GOPATH/bin"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# liquidprompt
export LP_ENABLE_BATT=false

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='cdr -l'
