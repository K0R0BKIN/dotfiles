typeset -U path

[[ -r "$HOME/.secrets" ]] && source "$HOME/.secrets"

export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR='vim'

if command -v fnm &>/dev/null; then
    eval "$(fnm env --use-on-cd --shell zsh)"
fi
