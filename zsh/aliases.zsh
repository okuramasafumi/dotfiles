alias vi='vim -N -u NONE -U NONE --noplugin --cmd "filetype indent on"'
alias todo='todo.sh'
alias sed='gsed'
alias ss='ssh'
alias bu='bundle'
alias be='bundle exec'
alias va='vagrant'
alias vsh='vagrant ssh'
alias reload='source ~/.zshrc'

# ls
alias ll='ls -l'
alias la='ls -a'
alias las='ls -la'

# Git
alias g='git'
alias gci='git commit'
alias gss='git status --short'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gl='git pull'
alias glr='git pull --rebase'
alias gst='git stash'
alias gstp='git stash pop'
alias grpo='git remote prune origin'

# Rails
alias ra='rails'
alias rdm='rake db:migrate'
alias rdmr='rake db:migrate:reset'
alias rdr='rake db:rollback'

function _rails_command () {
  if [ -e "bin/rails" ]; then
    bin/rails $@
  elif type bundle &> /dev/null && [ -e "Gemfile" ]; then
    bundle exec rails $@
  else
    command rails $@
  fi

}

function _rake_command () {
  if [ -e "bin/rake" ]; then
    bin/rake $@
  elif type bundle &> /dev/null && [ -e "Gemfile" ]; then
    bundle exec rake $@
  else
    command rake $@
  fi

}

alias rails='_rails_command'
compdef _rails_command=rails

alias rake='_rake_command'
compdef _rake_command=rake
