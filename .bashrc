#==============================================================
# Tyler Green
#
# .bashrc
#==============================================================

#==============================================================
# Prompt
#==============================================================

export PS1="\u@\h: \w > "

#==============================================================
# Input mode
#==============================================================
set -o vi # vim

# Ignore commands starting with spaces and duplicates in .bash_history
export HISTCONTROL=ignoreboth

#==============================================================
# Aliases
#==============================================================

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

alias gs="git status"
alias gb="git branch"
alias gd="git diff"
alias ga="git add"
alias gc="git commit"

#--------------------------------------------------------------
# Node.js

alias nt="npm test"
alias ns="npm start"

# Load nvm
export NVM_DIR="/Users/tylergreen/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
