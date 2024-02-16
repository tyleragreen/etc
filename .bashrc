#==============================================================
# Prompt
#==============================================================

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PS1="\W \$(parse_git_branch) \$ "

export EDITOR=/usr/local/bin/nvim

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

alias ll="ls -lha"
alias llr="ls -lR"
alias llt="ls -lhtr"
alias llf="ls -lhtrd $PWD/*"
alias u="cd .."
alias u2="cd ../.."
alias u3="cd ../../.."
alias u4="cd ../../../.."
alias hi="history"
alias tr="cd ~/Documents/repos"

alias v="nvim"
alias g="grep -rIi"
alias fz="fd | fzf | xargs nvim"

alias t="tmux new-session -c ~/Documents/repos/ -s"
alias tl="tmux list-sessions"
alias ta="tmux attach-session -t"

alias erc="v ~/.bashrc"
alias evrc="v ~/.config/nvim/init.lua"
alias esh="v ~/.ssh/config"
alias s="source ~/.bashrc"

#--------------------------------------------------------------
# Git

alias gs="git status"
alias gl="git log"
alias gb="git branch"
alias gbd="git branch -D"
alias gd="git diff"
alias gdl="git diff --color=always | less -r"
alias gds="git diff --staged --color=always | less -r"
alias ga="git add"
alias gp="git push"
alias gpu="git pull"
alias gg="git grep -i"
alias gcm="git commit -m"
alias gc="git checkout"
alias gcb="git checkout -b"
