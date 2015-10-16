export PATH=/usr/local/git/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:~/bin:$PATH
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend
EVENT_NOKQUEUE=yes
eval "$(hub alias -s)"
[ -e "$HOME/.bashrc" ] && source $HOME/.bashrc
export POW_DOMAINS=dev,text,local
source ~/.bashrc
source ~/.profile
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH

# added by Anaconda 2.1.0 installer
export PATH="//anaconda/bin:$PATH"

#init rbenv
eval "$(rbenv init -)"
