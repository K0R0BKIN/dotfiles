# Completions

# Homebrew
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
    compinit
fi

# Volta
source "$HOME/.volta-completions.zsh"
