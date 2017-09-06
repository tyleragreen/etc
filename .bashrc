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
alias gb="git branch"
alias gd="git diff"
alias gdl="git diff --color=always | less -r"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gpu="git pull"
alias gg="git grep -i"
alias gcam="git commit -am"
alias gitignore="git config --global core.excludesfile ~/.gitignore"

#--------------------------------------------------------------
# Node.js

alias nt="npm test"
alias ns="npm start"
alias vp="v package.json"

# Load nvm
export NVM_DIR="/Users/tylergreen/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
