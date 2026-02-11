## Overview

Personal dotfiles for macOS. Install script is idempotent — safe to re-run.

## Structure

Symlinks are managed by [GNU Stow](https://www.gnu.org/software/stow/). Each subdirectory is a Stow package whose contents mirror the home directory layout.

- `zsh/` — `.zshenv`, `.zshrc` (stowed to `~/`)
- `brew/` — `.config/homebrew/Brewfile` (stowed to `~/.config/homebrew/`)
- `git/` — `.config/git/config`, `.config/git/ignore` (stowed to `~/.config/git/`)
- `ghostty/` — `.config/ghostty/config` (stowed to `~/.config/ghostty/`)
- `zed/` — `.config/zed/settings.json` (stowed to `~/.config/zed/`)
- `install.sh`

## Conventions

- **Comments explain why, not what.** Don't label self-documenting code. If a section is short and obvious, skip the comment entirely. Section headers (e.g., `# Completions`) are fine when separating distinct concerns.
- **Minimal and intentional.** Don't add tooling, config, or aliases unless there's a clear reason.
- **Secrets live in iCloud**, symlinked to `~/.secrets`. Contains API keys, tokens, etc.

## Tools

- **pnpm**
- **fnm**
- **Homebrew**
- **GNU Stow**
- **gh**

## Notes

### Idempotency

The install script assumes a fresh machine. It doesn't guard against Homebrew already being installed — re-running just reinstalls or updates it, which is harmless. The goal is "doesn't cause damage on re-runs," not "perfectly skips everything already done." Adding `command -v` guards would make the script noisier without meaningful benefit.

### `~/.config/git/config` vs. `~/.gitconfig`

Git automatically reads `~/.config/git/config` as a fallback config location. Declarative settings (user, editor, init) live there via Stow-managed symlinks. Tool-generated entries like credential helpers (written by `gh auth login`) go to `~/.gitconfig`. Git merges both files, with `~/.gitconfig` taking priority on a per-key basis. This keeps authored settings version-controlled while letting generated config live outside the repo.

### `bindkey -e`

`EDITOR='vim'` in `.zshenv` causes Zsh to automatically switch to vi keybinding mode, which disables standard keybindings like ctrl+r, ctrl+p, and opt+arrow. `bindkey -e` in `.zshrc` overrides this by telling Zsh to use emacs keybindings (which is what Bash uses by default). These two lines are coupled — removing `bindkey -e` breaks keybindings, and removing `EDITOR='vim'` makes `bindkey -e` unnecessary.

### `source ~/.zshenv` in `install.sh`

The install script sources `.zshenv` after stow so it inherits environment variables (like `XDG_CONFIG_HOME`) without duplicating them. At that point fnm isn't installed yet (`brew bundle` hasn't run), so the fnm guard is a no-op — the explicit `eval "$(fnm env)"` later in the script is still needed.

### `brew bundle --global`

The Brewfile lives at `~/.config/homebrew/Brewfile` specifically because `brew bundle --global` reads from `${XDG_CONFIG_HOME}/homebrew/Brewfile`. This requires `XDG_CONFIG_HOME` to be set — without it, `--global` falls back to `~/.homebrew/Brewfile` or `~/.Brewfile`.

### `fnm env` in `.zshenv`

fnm docs recommend adding `eval "$(fnm env)"` to `.zshrc`, but it's in `.zshenv` so non-interactive shells (editors, scripts) can find `node`. Same reasoning as why Volta's PATH was in `.zshenv`. The `--use-on-cd` flag adds a chpwd hook for automatic Node version switching — harmless in non-interactive shells since they don't cd around.

### `brew autoupdate`

`brew autoupdate` runs `brew upgrade` in the background so that cask-installed tools like Claude Code stay up to date without manual intervention.

### `gh auth login`

GitHub requires authentication for git operations over HTTPS (push, pull, clone of private repos). Without a credential helper, git will prompt for a username and password, which will fail because GitHub no longer accepts passwords. `gh auth login` solves this — when it prompts "Authenticate Git with your GitHub credentials?", saying yes configures git to use gh as the credential helper, so all future git operations authenticate through gh automatically.

### `claude()` wrapper

Claude Code has no CLI flag for theme and no automatic system appearance detection. The only way to change the theme is the interactive `/theme` command, which writes to `~/.claude.json`. The wrapper works around this by reading the macOS appearance before launch and updating the config file directly.

The wrapper uses `jq` to update `.claude.json` before launching Claude, writing to a temp file and then `mv`-ing it over the original. On macOS, `mktemp` writes to `$TMPDIR` (`/var/folders/.../T/`), which is on the same APFS volume as `$HOME`, so the `mv` is an atomic rename — not a cross-filesystem copy. The race condition where another process writes to `.claude.json` between the `jq` read and `mv` is theoretically possible but not a practical concern, since `claude` takes over the terminal session. The `jq` dependency is also safe — this is an interactive function, not a shell startup path, so `brew bundle` has always run first.

