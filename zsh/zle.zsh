autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars ' /=;@:{}[]()<>,|.'
zstyle ':zle:*' word-style unspecified
WORDCHARS='*?_-[]~&!#$%^(){}<>'

# Enable autosuggestions automatically.
zle-line-init() {
  zle autosuggest-start
}
zle -N zle-line-init

bindkey '^T' autosuggest-toggle
export AUTOSUGGESTION_ACCEPT_RIGHT_ARROW=1
