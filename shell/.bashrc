export EDITOR=/usr/local/bin/nvim

# Input mode
set -o vi # vim

# Ignore commands starting with spaces and duplicates in .bash_history
export HISTCONTROL=ignoreboth

#==================================================================================================
# Aliases
#==================================================================================================

#--------------------------------------------------------------------------------------------------
# Bash basics

# eza is a modern ls replacement written in Rust. It was originall called exa, but is now
# maintained under the name eza.
#
# Change the dark blue of the git modified character and the datetime to a lighter blue.
# Reference: https://the.exa.website/docs/colour-themes
export EZA_COLORS="gm=1;34:da=1;34"
alias ls="eza"
alias ll="eza -lao --icons=always --git-ignore --git"
alias llR="eza -laoT --icons=always --git-ignore --git"
alias llt="eza -lao -s modified --icons=always --git-ignore --git"
alias llf="ls -lhtrd $PWD/*"

alias u="cd .."
alias u2="cd ../.."
alias u3="cd ../../.."
alias u4="cd ../../../.."
alias hi="history"
alias c="clear"
alias tr="cd ~/Documents/repos"

alias v="nvim"
alias g="grep -rIi"
alias fz="fd | fzf | xargs nvim"

alias cat="bat"
cb() {
  cat "$1" | pbcopy
}

alias t="tmux new-session -c ~/Documents/repos/ -s"
alias tl="tmux list-sessions"
alias ta="tmux attach-session -t"

alias erc="v ~/.bashrc"
alias evrc="v ~/.config/nvim/init.lua"
alias esh="v ~/.ssh/config"
alias s="source ~/.bashrc"

#--------------------------------------------------------------------------------------------------
# Git

alias gs="git status"
alias gl="git log"
alias gb="git branch"
alias gbd="git branch -D"
alias gd="git diff"
# I don't need gdl anymore technically but my muscle memory keeps using it
alias gdl="git diff"
alias gds="git diff --staged"
alias ga="git add"
alias gp="git push"
alias gpu="git pull"
alias gg="git grep -i"
alias gcm="git commit -m"
alias gc="git checkout"
alias gcb="git checkout -b"
