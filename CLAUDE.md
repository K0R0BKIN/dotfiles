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

### Idempotency

The install script assumes a fresh machine. It doesn't guard against Homebrew or Volta already being installed — re-running just reinstalls or updates them, which is harmless. The goal is "doesn't cause damage on re-runs," not "perfectly skips everything already done." Adding `command -v` guards would make the script noisier without meaningful benefit.

### `~/.config/git/config` vs. `~/.gitconfig`

Git automatically reads `~/.config/git/config` as a fallback config location. Declarative settings (user, editor, init) live there via the symlinked `git/` directory. Tool-generated entries like credential helpers (written by `gh auth login`) go to `~/.gitconfig`. Git merges both files, with `~/.gitconfig` taking priority on a per-key basis. This keeps authored settings version-controlled while letting generated config live outside the repo.

### `bindkey -e`

`EDITOR='vim'` in `.zshenv` causes Zsh to automatically switch to vi keybinding mode, which disables standard keybindings like ctrl+r, ctrl+p, and opt+arrow. `bindkey -e` in `.zshrc` overrides this by telling Zsh to use emacs keybindings (which is what Bash uses by default). These two lines are coupled — removing `bindkey -e` breaks keybindings, and removing `EDITOR='vim'` makes `bindkey -e` unnecessary.

### `brew autoupdate`

`brew autoupdate` runs `brew upgrade` in the background so that cask-installed tools like Claude Code stay up to date without manual intervention.

### `gh auth login`

GitHub requires authentication for git operations over HTTPS (push, pull, clone of private repos). Without a credential helper, git will prompt for a username and password, which will fail because GitHub no longer accepts passwords. `gh auth login` solves this — when it prompts "Authenticate Git with your GitHub credentials?", saying yes configures git to use gh as the credential helper, so all future git operations authenticate through gh automatically.

### `claude()` wrapper

Claude Code has no CLI flag for theme and no automatic system appearance detection. The only way to change the theme is the interactive `/theme` command, which writes to `~/.claude.json`. The wrapper works around this by reading the macOS appearance before launch and updating the config file directly.

The wrapper uses `jq` to update `.claude.json` before launching Claude, writing to a temp file and then `mv`-ing it over the original. On macOS, `mktemp` writes to `$TMPDIR` (`/var/folders/.../T/`), which is on the same APFS volume as `$HOME`, so the `mv` is an atomic rename — not a cross-filesystem copy. The race condition where another process writes to `.claude.json` between the `jq` read and `mv` is theoretically possible but not a practical concern, since `claude` takes over the terminal session. The `jq` dependency is also safe — this is an interactive function, not a shell startup path, so `brew bundle` has always run first.

### `ln -sfn`

Without `-n`, `ln -sf` on a directory target follows the existing symlink and creates a nested link inside it (e.g., `~/.config/git/git` pointing back to `~/dotfiles/git`). The `-n` flag treats an existing symlink-to-directory as a file and replaces it in place. This only matters for the `git/` directory symlink — file-level symlinks like `.zshrc` don't need it because `-f` handles those fine.
