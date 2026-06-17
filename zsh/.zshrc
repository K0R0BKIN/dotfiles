bindkey -e
setopt CORRECT

if command -v brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

if command -v fnm &>/dev/null; then
    eval "$(fnm env --use-on-cd --shell zsh)"
fi

autoload -Uz compinit
compinit

compdef _gnu_generic zed
