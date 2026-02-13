#!/bin/zsh
set -e

DOTFILES="$HOME/dotfiles"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

brew tap domt4/autoupdate
brew autoupdate delete && brew autoupdate start 21600 --upgrade

ICLOUD="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
ln -sf "$ICLOUD/secrets/.secrets" "$HOME/.secrets"

brew install stow
cd "$DOTFILES" && stow --adopt brew ghostty git zed zsh && git restore .
source "$HOME/.zshenv"

brew bundle --global

eval "$(fnm env)"
fnm install --lts

gh auth status &>/dev/null || gh auth login
