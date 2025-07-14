#!/bin/zsh

DOTFILES="$HOME/dotfiles"

# Symlink Zsh startup files
ln -sf "$DOTFILES/.zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES/.zshrc" "$HOME/.zshrc"

# Install Xcode Command Line Tools
xcode-select --install

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Symlink Brewfile and install packages
ln -sf "$DOTFILES/Brewfile" "$HOME/Brewfile"
brew bundle

# Install Volta and Node
curl https://get.volta.sh | bash
volta install node

