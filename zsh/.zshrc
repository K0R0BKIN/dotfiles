# Options

bindkey -e
setopt CORRECT

# Aliases

alias c='claude --dangerously-skip-permissions'
alias cr='c --resume'
alias cc='c --continue'

# Wrappers

claude() {
  local config="$HOME/.claude.json"

  if [[ -f "$config" ]]; then
    if defaults read -g AppleInterfaceStyle &>/dev/null; then
      local theme="dark"
    else
      local theme="light"
    fi

    local tmp=$(mktemp)
    jq --arg t "$theme" '.theme = $t' "$config" > "$tmp" && mv "$tmp" "$config"
  fi

  command claude "$@"
}

# Completions

if command -v brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

autoload -Uz compinit
compinit

compdef _gnu_generic zed
compdef _gnu_generic claude
