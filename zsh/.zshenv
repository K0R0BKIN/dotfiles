typeset -U path

[[ -r "$HOME/.secrets" ]] && source "$HOME/.secrets"

export EDITOR='vim'

if command -v fnm &>/dev/null; then
    eval "$(fnm env --use-on-cd --shell zsh)"
fi
