typeset -U path

eval "$(/opt/homebrew/bin/brew shellenv)"

[[ -r "$HOME/.secrets" ]] && source "$HOME/.secrets"

export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR='vim'

# pnpm
export PNPM_HOME="/Users/nikita/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH="$HOME/.local/bin:$PATH"
