# Aliases

alias c='claude'
alias cc='claude -c'
alias csp='claude --dangerously-skip-permissions'

# Completions

# Homebrew
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
    compinit
fi

# Volta
source "$HOME/.volta-completions.zsh"

# PATH

# Homebrew
[[ -r "$HOME/.volta-completions.zsh" ]] && source "$HOME/.volta-completions.zsh"

# Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
