# Source secrets
[[ -f "$HOME/.secrets" ]] && source "$HOME/.secrets"

# Preferences

# Locale
export LANG=en_US.UTF-8

# Editor
export EDITOR='nano'
export VISUAL_EDITOR='code --wait'
export VISUAL=$VISUAL_EDITOR

# PATH

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"