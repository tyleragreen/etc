# Run .bashrc on terminal start
[[ -s ~/.bashrc ]] && source ~/.bashrc

# Hide 'The default interactive shell is now zsh.' message on MacOS.
export BASH_SILENCE_DEPRECATION_WARNING=1

# Run alias to navigate to main repo/code directory
# tr

. "$HOME/.cargo/env"
eval "$(rbenv init -)"
