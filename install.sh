#!/bin/zsh
set -e

DOTFILES="$HOME/dotfiles"
ICLOUD="$HOME/Library/Mobile Documents/com~apple~CloudDocs"

# Homebrew (before stow so we can install it)

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install stow

# Symlinks

ln -sf "$ICLOUD/secrets/.secrets" "$HOME/.secrets"
cd "$DOTFILES"
stow brew ghostty git zed zsh

brew bundle
brew tap domt4/autoupdate
brew autoupdate start --upgrade

# Volta

curl https://get.volta.sh | bash
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
volta completions zsh > "$HOME/.volta-completions.zsh"
volta install node

# Git

gh auth status &>/dev/null || gh auth login
