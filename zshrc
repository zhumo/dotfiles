export PS1="%F{yellow}%n@%1~ =>%f  "

export EDITOR=vim
export PYTHONPATH="/usr/local/lib/python:/usr/local/lib/python/site-packages:/usr/local/lib/python/site-packages/caption_positioning:/usr/local/lib/python/site-packages/dsptools:$PYTHONPATH"

alias dc="docker-compose"
alias dcs="dc stop"
alias dcrs="dc restart"
alias dcb="dc build"
alias dcu="dc up"
alias dcr="dc run"
alias dcra="dcr app"

alias rm="rm -i"
alias gh="git hist"
alias gs="git status"
alias gcm="git commit -m"
alias gbr="git branch"
alias gd="git diff"
alias gds="git diff --staged"
alias gaa="git add -A"
alias gco="git checkout"
alias ls="ls -alF"
alias gss="git stash"
alias gsp="git stash pop"
alias gsa="git stash apply"

alias mrmt="rake db:migrate && rake db:rollback && rake db:migrate && rake db:test:prepare"
alias mrm="rake db:migrate && rake db:rollback && rake db:migrate"
alias test!="rake db:test:prepare"
alias rollback!="rake db:rollback"
alias migrate!="rake db:migrate"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Vimming
alias v="vim"

eval "$(rbenv init - zsh)"
