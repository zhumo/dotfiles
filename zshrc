export PS1="%F{yellow}%n@%1~ =>%f  "

export EDITOR=nvim
alias vim="nvim"
alias v="vim"

export PYTHONPATH="/usr/local/lib/python:/usr/local/lib/python/site-packages:/usr/local/lib/python/site-packages/caption_positioning:/usr/local/lib/python/site-packages/dsptools:$PYTHONPATH"

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

eval "$(rbenv init - zsh)"

# Added by Windsurf
export PATH="/Users/mozhu/.codeium/windsurf/bin:$PATH"

. "$HOME/.local/bin/env"

# Load local secrets in .zshrc.local
if [ -f "${HOME}/.zshrc.local" ]; then
  source "${HOME}/.zshrc.local"
else
  echo "Warning: ${HOME}/.zshrc.local not found. Copy zshrc.local.example → ~/.zshrc.local." >&2
fi
