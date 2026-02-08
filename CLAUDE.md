# CLAUDE.md

## Overview

Personal dotfiles for macOS. Install script is idempotent — safe to re-run.

## Structure

- `.zshenv`
- `.zshrc`
- `Brewfile`
- `git/ignore` (symlinked to `~/.config/git/ignore`, the git default path, so no `core.excludesfile` needed)
- `ghostty/config`
- `zed/settings.json`
- `install.sh`

## Conventions

- **Comments explain why, not what.** Don't label self-documenting code. If a section is short and obvious, skip the comment entirely. Section headers (e.g., `# Completions`) are fine when separating distinct concerns.
- **Minimal and intentional.** Don't add tooling, config, or aliases unless there's a clear reason.
- **Secrets live in iCloud**, symlinked to `~/.secrets`. Contains API keys, tokens, etc.

## Tools

- **npm**
- **Volta**
- **Homebrew**
- **gh**

## Notes

### Zsh keybindings

`EDITOR='vim'` in `.zshenv` causes Zsh to automatically switch to vi keybinding mode, which disables standard keybindings like ctrl+r, ctrl+p, and opt+arrow. `bindkey -e` in `.zshrc` overrides this by telling Zsh to use emacs keybindings (which is what Bash uses by default). These two lines are coupled — removing `bindkey -e` breaks keybindings, and removing `EDITOR='vim'` makes `bindkey -e` unnecessary.

### Brew autoupdate

`brew autoupdate` runs `brew upgrade` in the background so that cask-installed tools like Claude Code stay up to date without manual intervention.

### GitHub authentication

GitHub requires authentication for git operations over HTTPS (push, pull, clone of private repos). Without a credential helper, git will prompt for a username and password, which will fail because GitHub no longer accepts passwords. `gh auth login` solves this — when it prompts "Authenticate Git with your GitHub credentials?", saying yes configures git to use gh as the credential helper, so all future git operations authenticate through gh automatically.
