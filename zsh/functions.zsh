# https://gist.github.com/siriusjack/0b0032f22c72ffc7e5ba217f80674ad2
function fzf-cdr () {
  local selected_dir=$(cdr -l | awk '{ print $2 }' | fzf --preview "bat --color=always '{}/README.md' 2> /dev/null" --preview-window '~3' --bind 'ctrl-/:change-preview-window(60%|70%||30%|40%|50%)')
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-cdr
bindkey "^Z" fzf-cdr
