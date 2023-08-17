# Run .bashrc on terminal start
[[ -s ~/.bashrc ]] && source ~/.bashrc

# Hide 'The default interactive shell is now zsh.' message on MacOS.
export BASH_SILENCE_DEPRECATION_WARNING=1

# Run alias to navigate to main repo/code directory
# tr

. "$HOME/.cargo/env"

if command -v rbenv >/dev/null 2>&1; then
    eval "$(rbenv init -)"
fi
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
