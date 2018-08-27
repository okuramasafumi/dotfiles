autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars ' /=;@:{}[]()<>,|.'
zstyle ':zle:*' word-style unspecified
WORDCHARS='*?_-[]~&!#$%^(){}<>'

# Workaround to enable syntax highlighting after accepting suggestions.
# See: https://github.com/zsh-users/zsh-autosuggestions/issues/158
my-autosuggest-accept() {
    zle autosuggest-accept
    zle redisplay
    zle redisplay
}

zle -N my-autosuggest-accept

ZSH_AUTOSUGGEST_IGNORE_WIDGETS+=my-autosuggest-accept

bindkey '^ ' my-autosuggest-accept
