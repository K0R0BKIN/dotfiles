# Aliases

alias c='claude'
alias cc='claude -c'
alias csp='claude --dangerously-skip-permissions'

# Completions

# Homebrew
if command -v brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
    compinit
fi

# Volta
[[ -r "$HOME/.volta-completions.zsh" ]] && source "$HOME/.volta-completions.zsh"
