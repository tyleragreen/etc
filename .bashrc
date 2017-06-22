# Tyler Green

#===========================
# Prompt
#===========================

export PS1="\u@\h: \w > "

#===========================
# Input mode
#===========================
set -o vi # vim

# Ignore commands starting with spaces and duplicates in .bash_history
export HISTCONTROL=ignoreboth

#===========================
# Aliases
#===========================

# Bash basics
alias ll="ls -la"
alias lr="ls -lR"
alias lt="ls -ltr"
alias u="cd .."
alias hi="history"

alias v="vim"
alias g="grep -rIi"

alias erc="v ~/.bashrc"
alias evrc="v ~/.vimrc"
alias s="source ~/.bashrc"

alias gs="git status"
alias gb="git branch"
alias gd="git diff"

export NVM_DIR="/Users/tylergreen/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
