# Source secrets
[[ -f "$HOME/.secrets" ]] && source "$HOME/.secrets"

# Preferences

# Locale
export LANG=en_US.UTF-8

# Editor
export EDITOR='nano'
export VISUAL_EDITOR='code --wait'
export VISUAL=$VISUAL_EDITOR

# Git
git config --global core.editor "$VISUAL_EDITOR"
