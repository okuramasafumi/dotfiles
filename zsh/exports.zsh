export GOPATH=~/.go

export EDITOR=nvim
export DISABLE_AUTO_TITLE=true
export TERM="xterm-256color"
export PATH="~/bin:$PATH:$GOPATH/bin"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export MANPAGER='nvim +Man! --clean' # Use nvim as a man pager

# liquidprompt
export LP_ENABLE_BATT=false

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
