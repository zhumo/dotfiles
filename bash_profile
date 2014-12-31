export PATH=/usr/local/git/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:~/bin:$PATH
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend
EVENT_NOKQUEUE=yes
eval "$(hub alias -s)"
[ -s "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"
[ -e "$HOME/.bashrc" ] && source $HOME/.bashrc
export POW_DOMAINS=dev,text,local
source ~/.bashrc
source ~/.profile
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
