# Tyler Green

#===========================
# Prompt
#===========================

export PS1="\u@\h: \w > "

#===========================
# Input mode
#===========================
set -o vi # vim

#===========================
# Aliases
#===========================

alias ll="ls -la"
alias lr="ls -lR"
alias lt="ls -ltr"

alias v="vim"
alias g="grep -rI"

alias erc="v ~/.bashrc"
alias evrc="v ~/.vimrc"
alias s="source ~/.bashrc"
