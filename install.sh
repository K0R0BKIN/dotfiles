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
cd "$DOTFILES" && stow brew ghostty git zed zsh

brew bundle

curl https://get.volta.sh | bash
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
volta completions zsh > "$HOME/.volta-completions.zsh"

volta install node

gh auth status &>/dev/null || gh auth login
