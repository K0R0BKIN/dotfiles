bindkey -e

alias c='claude'
alias cc='claude -c'
alias csp='claude --dangerously-skip-permissions'

# Completions

if command -v brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

autoload -Uz compinit
compinit

[[ -r "$HOME/.volta-completions.zsh" ]] && source "$HOME/.volta-completions.zsh"

compdef _gnu_generic zed
