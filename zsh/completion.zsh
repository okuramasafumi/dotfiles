zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

# Use ~/.ssh/config for host completions
# zstyle -s ':completion:*:hosts' hosts _ssh_config
# [[ -r ~/.ssh/config ]] && _ssh_config+=($(cat ~/.ssh/config | sed -ne 's/Host[=\t ]//p'))
# zstyle ':completion:*:hosts' hosts $_ssh_config

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab] - move through the completion menu backwards
fi

# If LS_COLORS is set, use the same colors for completion
if [ -n "$LSCOLORS" ]; then
  zstyle ':completion:*' list-colors ${(s.:.)LSCOLORS}
elif [ -n "$LS_COLORS" ]; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi
