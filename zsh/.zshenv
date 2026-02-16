typeset -U path

[[ -r "$HOME/.secrets" ]] && source "$HOME/.secrets"

export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR='vim'
export HOMEBREW_AUTO_UPDATE_SECS=43200

if command -v fnm &>/dev/null; then
    eval "$(fnm env --use-on-cd --shell zsh)"
fi
