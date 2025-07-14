#!/bin/zsh

DOTFILES="$HOME/dotfiles"

# Symlink Zsh startup files
ln -sf "$DOTFILES/.zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES/.zshrc" "$HOME/.zshrc"

# .zshenv sources .secrets
source "$HOME/.zshenv"

# Install Xcode Command Line Tools
xcode-select --install

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Symlink Brewfile and install packages
ln -sf "$DOTFILES/Brewfile" "$HOME/Brewfile"
brew bundle

# Set up Git
git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"
git config --global init.defaultBranch "main"
git config --global core.editor "$VISUAL_EDITOR"
git config --global core.excludesfile "$HOME/.gitignore_global"
# Symlink .gitignore_global
ln -sf "$DOTFILES/.gitignore_global" "$HOME/.gitignore_global"
# Authenticate GitHub CLI
gh auth login
# Configure git to use GitHub CLI as the credential helper
gh auth setup-git

# Install Volta and Node
curl https://get.volta.sh | bash
volta install node

