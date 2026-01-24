# Source secrets
[[ -r "$HOME/.secrets" ]] && source "$HOME/.secrets"

# Preferences

# Locale
export LANG=en_US.UTF-8

# Editor
export EDITOR='vim'
export VISUAL_EDITOR='zed --wait  --reuse'
export VISUAL=$VISUAL_EDITOR

# Git
git config --global core.editor "$EDITOR"
