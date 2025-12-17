## Setup

### Prerequisites

1. Enable iCloud Drive sync — `.secrets` is stored there
2. Install Xcode Command Line Tools: `xcode-select --install`
3. Clone this repo: `git clone <repo-url> ~/dotfiles`
4. Install and set up Happ manually — requires subscription link from `.secrets`
5. Enable VPN (needed for some cask downloads)

### Installation

```bash
zsh ~/dotfiles/install.sh
```

The script will symlink dotfiles, install Homebrew and tools, and configure your environment. It will pause to prompt for GitHub authentication.
