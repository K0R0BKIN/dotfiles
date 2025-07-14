#!/bin/zsh

# Symlink Zsh startup files
ln -sf $HOME/dotfiles/.zshenv $HOME/.zshenv
ln -sf $HOME/dotfiles/.zprofile $HOME/.zprofile
ln -sf $HOME/dotfiles/.zshrc $HOME/.zshrc

# Install Xcode Command Line Tools
xcode-select --install

# Install Homebrew if not installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
source $HOME/.zprofile

# Symlink Brewfile and install packages
ln -sf $HOME/dotfiles/Brewfile $HOME/Brewfile
brew bundle

# Install Volta and Node
curl https://get.volta.sh | bash
volta install node

# Create directories for projects
mkdir -p $HOME/code