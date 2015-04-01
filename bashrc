export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export PS1="\[\e[33m\]\u@\W -\[\e[0m\] "

export EDITOR=vim
export PYTHONPATH="/usr/local/lib/python:/usr/local/lib/python/site-packages:/usr/local/lib/python/site-packages/caption_positioning:/usr/local/lib/python/site-packages/dsptools:$PYTHONPATH"

alias rm="rm -i"
alias gh="git hist"
alias gs="git status"
alias gcm="git commit -m"
alias gbr="git branch"
alias gdiff="git diff"
alias gaa="git add -A"
alias gco="git checkout"
alias ls="ls -alF"

alias mrmt="rake db:migrate && rake db:rollback && rake db:migrate && rake db:test:prepare"
alias mrm="rake db:migrate && rake db:rollback && rake db:migrate"
alias test!="rake db:test:prepare"
alias rollback!="rake db:rollback"
alias migrate!="rake db:migrate"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Jobcase
alias starteu='bundle exec rails s -p 3009 -b 127.0.0.1'
alias startfr='rails s -p 3001 -b 127.0.0.1'
alias startjc='rails s -p 3030 -b 127.0.0.1'
alias startjc-a='rails s -p 3031 -b 127.0.0.1'
alias startapi='rails s -p 3050 -b 127.0.0.1'
alias startjc-s='rails s -p 3020 -b 127.0.0.1'
alias startjr="ruby script/server -b 127.0.0.1 -p 3000"
alias startjr2="ruby script/server -b 127.0.0.1 -p 3006"
alias startjiz='rails s -p 3002 -b 127.0.0.1'
alias bcon='~/bundle_config_on.sh'
alias bcoff='~/bundle_config_off.sh'
