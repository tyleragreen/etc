#==============================================================
# Tyler Green
#
# .bashrc
#==============================================================

#==============================================================
# Prompt
#==============================================================

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PS1="\u@\h: \w \$(parse_git_branch) > "

export EDITOR=/usr/bin/vim

#==============================================================
# Input mode
#==============================================================
set -o vi # vim

# Ignore commands starting with spaces and duplicates in .bash_history
export HISTCONTROL=ignoreboth

#==============================================================
# Aliases
#==============================================================

#--------------------------------------------------------------
# Bash basics

alias ll="ls -la"
alias llr="ls -lR"
alias llt="ls -ltr"
alias u="cd .."
alias u2="cd ../.."
alias u3="cd ../../.."
alias u4="cd ../../../.."
alias hi="history"

alias v="vim"
alias g="grep -rIi"

alias erc="v ~/.bashrc"
alias crc="cp ~/.bashrc ."
alias evrc="v ~/.vimrc"
alias cvrc="cp ~/.vimrc ."
alias s="source ~/.bashrc"

#--------------------------------------------------------------
# Git

alias gs="git status"
alias gl="git log"
alias gb="git branch"
alias gd="git diff"
alias gdl="git diff --color=always | less -r"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gpu="git pull"
alias gg="git grep -i"
alias gcam="git commit -am"

# These two commands modify the ~/.gitconfig file
alias gitignore="git config --global core.excludesfile ~/.gitignore"
# This command is intended to make rebasing work on OS X
# I COULDNT GET THIS TO WORK, BUT MAYBE ILL START A REBASING MEETUP AND REVISIT THIS IN THE FUTURE
# A few sources:
# https://www.git-tower.com/blog/make-git-rebase-safe-on-osx/
# https://stackoverflow.com/questions/21889741/git-rebase-continue-wont-work
# https://stackoverflow.com/questions/15136590/what-happened-to-my-these-several-times-git-pull-rebase-with-the-error-your-l
alias gitdistrustctime="git config --global core.trustctime false"

#--------------------------------------------------------------
# Node.js

alias nt="npm test"
alias ns="npm start"
alias vp="v package.json"

# Load nvm
export NVM_DIR="/Users/tylergreen/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 

#--------------------------------------------------------------
# Postgres
# from https://stackoverflow.com/a/18581276

export PGDATA='/usr/local/var/postgres'
export PGHOST=localhost
alias start-pg='pg_ctl -l $PGDATA/server.log start'
alias stop-pg='pg_ctl stop -m fast'
alias pg-status='pg_ctl status'
alias restart-pg='pg_ctl reload'

#--------------------------------------------------------------
# Notetime
# https://github.com/tyleragreen/notetime

alias nn="note-new"
alias nd="note-deploy"
alias no="note-open"

#--------------------------------------------------------------
# Python

alias python="python3"
alias pip="pip3"

#--------------------------------------------------------------
# Docker
alias ds="docker stop"
alias dps="docker ps"
alias dcu="docker-compose up"
