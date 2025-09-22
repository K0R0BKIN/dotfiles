# Aliases

alias dev="cd $HOME/Developer"

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
eval "$(/opt/homebrew/bin/brew shellenv)"

# Git
export PATH="/opt/homebrew/bin:$PATH"

# Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
