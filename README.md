# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). Running `stow .` symlinks config files from this repo into `$HOME`.

## Prerequisites

- macOS
- [Homebrew](https://brew.sh/)
- Git

## Quick Start

```sh
# Clone the repo
git clone https://github.com/cxmiller21/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install core tools (Zinit, fonts, Ghostty, Devbox, etc.)
chmod +x install.sh
./install.sh

# Install CLI tools, languages, and applications from Brewfile
brew bundle

# Back up existing dotfiles
mv ~/.zshrc ~/.zshrc.bak
mv ~/.config/starship.toml ~/.config/starship.toml.bak

# Symlink dotfiles into $HOME
./sync.sh
source ~/.zshrc
```

## What Gets Installed

### `install.sh` — Core Tools

One-time Homebrew installs for tools not managed elsewhere:

- [Zinit](https://github.com/zdharma-continuum/zinit) — Zsh plugin manager
- [Fira Code](https://github.com/tonsky/FiraCode) font (regular + Nerd Font)
- [Ghostty](https://ghostty.org/) terminal
- [Devbox](https://www.jetify.com/devbox/) — Nix-based dev environments
- [OBS](https://obsproject.com/)
- kubecolor, bat, starship, thefuck, kubectl

### `Brewfile` — CLI Tools & Applications

Declarative Homebrew bundle (`brew bundle`) for everything else:

- **CLI:** git, curl, wget, nvm, ffmpeg, nushell
- **Cloud & Infra:** ansible, argocd, helm, eksctl, skaffold, terraform (via devbox)
- **Languages:** Go, Python 3.13, pipx, pnpm, poetry
- **Security:** gitleaks, trufflehog, bfg, tailscale
- **Casks:** Docker, VS Code, 1Password, Chrome, iTerm2, Claude, Obsidian, Slack, Zoom, and more

### `devbox.json` — Project Dev Shell

Nix packages available in `devbox shell` for this repo:

- kind, google-cloud-sdk, gum, stow, gh, jq, yq
- kubectl, teller, awscli, terraform, terragrunt, nodejs

### Devbox Global — Daily Shell Tools

Packages available in all shells (`~/.local/share/devbox/global/default/devbox.json`):

- starship, bat, zoxide, fzf, eza, thefuck, gh, mise

## How Stow Works

The repo root is the stow directory. `stow .` creates symlinks from files here into `$HOME`. Files and directories listed in `.stow-local-ignore` are excluded from symlinking:

- `.devbox/`, `.git/`, `.gitignore`, `.teller.yml`, `.DS_Store`
- `devbox.*`, `devbox.lock`, `gcloud/`, `install.sh`, `Brewfile`, `vscode/`
- `CLAUDE.md`, `README.md`, `sync.sh`, `uninstall.sh`

Any new file added to the repo root **will** be symlinked to `$HOME` — add it to `.stow-local-ignore` if that's not intended.

## Shell Configuration

`.zshrc` sets up:

- **Prompt:** [Starship](https://starship.rs/) with emoji git status indicators
- **Plugins (Zinit):** autosuggestions, syntax highlighting, history substring search
- **Navigation:** [zoxide](https://github.com/ajeetdsouza/zoxide) (`cd` replacement), fzf
- **Tools:** eza (`ls`), bat (`cat`), kubecolor (`kubectl`), thefuck
- **Runtime managers:** mise (Python, etc.), NVM (Node.js), pnpm
- **Completions:** devbox, docker, kubectl, terragrunt
- **Aliases:** git, docker-compose, terraform, terragrunt, kubectl

## VS Code Setup

VS Code settings are **not** managed by Stow. Use the setup script:

```sh
./vscode/setup.sh
```

This installs extensions from `vscode/extensions.txt` and symlinks `vscode/settings.json` into `~/Library/Application Support/Code/User/`.

## Syncing Changes

```sh
# After modifying dotfiles
./sync.sh
source ~/.zshrc

# Pull updates on another machine
git pull
./sync.sh
source ~/.zshrc
```

## Uninstall

```sh
./uninstall.sh
```

Removes Devbox, symlinked configs, and Homebrew-installed tools (starship, thefuck, fonts, bat, etc.).

## Secrets Management

[Teller](https://github.com/tellerops/teller) (`.teller.yml`) pulls secrets from Google Secret Manager. Requires `gcloud auth login` first.
