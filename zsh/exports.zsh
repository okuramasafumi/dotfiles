export GOPATH=~/.go

export EDITOR=nvim
export DISABLE_AUTO_TITLE=true
export TERM="xterm-256color"
export PATH="$HOME/.local/bin:$HOME/bin:$GOPATH/bin:/usr/local/opt/python/libexec/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export MANPAGER='nvim +Man! --clean' # Use nvim as a man pager

# Homebrew
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS=1

export RUBYOPT="-r$HOME/.rubyopenssl_default_store.rb $RUBYOPT"

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
