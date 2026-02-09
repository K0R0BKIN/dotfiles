#!/bin/zsh
set -e

DOTFILES="$HOME/dotfiles"
ICLOUD="$HOME/Library/Mobile Documents/com~apple~CloudDocs"

# Symlinks

ln -sf "$DOTFILES/.zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/Brewfile" "$HOME/Brewfile"
ln -sf "$ICLOUD/secrets/.secrets" "$HOME/.secrets"

mkdir -p "$HOME/.config/git"
ln -sf "$DOTFILES/git/ignore" "$HOME/.config/git/ignore"

mkdir -p "$HOME/.config/ghostty"
ln -sf "$DOTFILES/ghostty/config" "$HOME/.config/ghostty/config"

mkdir -p "$HOME/.config/zed"
ln -sf "$DOTFILES/zed/settings.json" "$HOME/.config/zed/settings.json"

# Homebrew

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
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

git config --global user.name "Nikita Korobkin"
git config --global user.email "nikita.korobkin.personal@gmail.com"
git config --global init.defaultBranch "main"
gh auth login
