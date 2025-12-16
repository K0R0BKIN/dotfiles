#!/bin/zsh

DOTFILES="$HOME/dotfiles"


# Symlink dotfiles


# Symlink Zsh startup files
ln -sf "$DOTFILES/.zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES/.zshrc" "$HOME/.zshrc"

# Symlink .secrets
# - .zshenv sources .secrets
ICLOUD="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
ln -sf "$ICLOUD/secrets/.secrets" "$HOME/.secrets"


# Source .zshrc
# - Modifies PATH for tools below
source "$HOME/.zshrc"


# Install tools


# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Volta
curl https://get.volta.sh | bash
# Generate Volta completions
volta completions zsh > "$HOME/.volta-completions.zsh"
# Install Node
volta install node


# Source .zshenv
# - Declares environment variables required for scripts below
source "$HOME/.zshenv"


# Configure tools


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

# Symlink Ghostty config
mkdir -p "$HOME/.config/ghostty"
ln -sf "$DOTFILES/ghostty/config" "$HOME/.config/ghostty/config"

# Symlink Zed config
mkdir -p "$HOME/.config/zed"
ln -sf "$HOME/dotfiles/zed/settings.json" "$HOME/.config/zed/settings.json"
