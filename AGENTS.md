## Secrets

Secrets live in iCloud, symlinked to `~/.secrets`.

## Idempotency

The install script assumes a fresh machine. It doesn't guard against Homebrew already being installed — re-running just reinstalls or updates it, which is harmless. The goal is "doesn't cause damage on re-runs," not "perfectly skips everything already done." Adding `command -v` guards would make the script noisier without meaningful benefit.

## Stow conflicts with existing symlinks

If dotfiles were previously symlinked manually (e.g., via `ln -sf`), stow will refuse with "existing target is not owned by stow." `--adopt` doesn't help — it only handles plain files, not symlinks. This is a hard limitation in GNU Stow; there is no flag to force-replace foreign symlinks. The fix is to remove the old symlinks before running stow:

```sh
rm ~/.zshenv ~/.zshrc ~/.config/ghostty/config ~/.config/git/ignore ~/.config/git/config ~/.config/zed/settings.json
```

This is a one-time migration. Once stow owns the symlinks, re-running `install.sh` works without issues.

## `~/.config/git/config` vs. `~/.gitconfig`

Git automatically reads `~/.config/git/config` as a fallback config location. Declarative settings (user, editor, init) live there via Stow-managed symlinks. Tool-generated entries like credential helpers (written by `gh auth login`) go to `~/.gitconfig`. Git merges both files, with `~/.gitconfig` taking priority on a per-key basis. This keeps authored settings version-controlled while letting generated config live outside the repo.

## `bindkey -e`

`EDITOR='vim'` in `.zshenv` causes Zsh to automatically switch to vi keybinding mode, which disables standard keybindings like ctrl+r, ctrl+p, and opt+arrow. `bindkey -e` in `.zshrc` overrides this by telling Zsh to use emacs keybindings (which is what Bash uses by default). These two lines are coupled — removing `bindkey -e` breaks keybindings, and removing `EDITOR='vim'` makes `bindkey -e` unnecessary.

## `source ~/.zshenv` in `install.sh`

The install script sources `.zshenv` after stow so it gets `XDG_CONFIG_HOME` before running `brew bundle --global`.

## `brew bundle --global`

The Brewfile lives at `~/.config/homebrew/Brewfile` because `brew bundle --global` reads from `${XDG_CONFIG_HOME}/homebrew/Brewfile`; without `XDG_CONFIG_HOME`, it falls back to `~/.homebrew/Brewfile` or `~/.Brewfile`.

## `fnm env`

`.zshrc` initializes fnm with `--use-on-cd` because it installs interactive shell hooks for automatic Node version switching. `install.sh` also runs `eval "$(fnm env)"` after `brew bundle --global` so the same script can call `fnm install --lts` immediately after installing fnm.
