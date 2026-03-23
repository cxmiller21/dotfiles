# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles repository forked from `vfarcic/dotfiles`. Uses **GNU Stow** to manage symlinks from this directory into `$HOME`. Running `stow .` creates symlinks for all non-ignored files/directories into `~`.

## Key Commands

```sh
# Install system dependencies (Homebrew-based, macOS)
./install.sh        # One-time installs: Zinit, Fira Code font, Ghostty, Devbox, OBS, kubecolor, bat, starship, thefuck, kubectl
brew bundle         # Installs everything from Brewfile (CLI tools, casks, taps)

# Sync dotfiles (WARNING: deletes ~/.zshrc first, then runs stow)
./sync.sh
source ~/.zshrc

# Enter devbox shell (provides stow, gum, teller, gcloud, kubectl, terraform, terragrunt, etc.)
devbox shell

# Set up VS Code extensions and link settings (not managed by stow)
./vscode/setup.sh

# Remove all installed tools and symlinks
./uninstall.sh
```

## How Stow Works Here

- The repo root is the stow directory; `stow .` symlinks everything into `$HOME`
- `.stow-local-ignore` excludes from symlinking: `.devbox/`, `.gitignore`, `.teller.yml`, `.DS_Store`, `devbox.*`, `devbox.lock`, `gcloud/`, `install.sh`, `Brewfile`, `vscode/`, `.git/`, `CLAUDE.md`, `README.md`, `sync.sh`, `uninstall.sh`
- Any new config file/directory added at the repo root **will** be symlinked to `$HOME` — be intentional about what goes in the root
- If you add a new file/directory that should NOT be symlinked, add it to `.stow-local-ignore`

## Architecture

### Package Management (four layers)

1. **`install.sh`** — One-time Homebrew installs for core tools not managed elsewhere (Zinit, Fira Code font, Ghostty, Devbox, OBS, kubecolor, bat, starship, thefuck, kubectl)
2. **`Brewfile`** — Declarative Homebrew bundle (`brew bundle`) for CLI tools, languages, casks, and taps not managed by Devbox (git, curl, nvm, go, python, ansible, argocd, helm, eksctl, postgresql, Docker, VS Code, 1Password, Claude, Obsidian, Slack, etc.)
3. **`devbox.json`** — Project-level Nix packages for this repo's dev shell (kind, google-cloud-sdk, gum, stow, gh, jq, yq, kubectl, teller, awscli, terraform, terragrunt, nodejs)
4. **`.local/share/devbox/global/default/devbox.json`** — Devbox global packages available in all shells (starship, bat, zoxide, fzf, eza, thefuck, gh, mise)

Some tools appear in multiple layers (e.g., starship in both install.sh and devbox global). Devbox global is the canonical source for daily shell tools; install.sh/Brewfile handle things Devbox can't (fonts, casks, system-level tools).

### Shell & Config

- **`.zshrc`** — Shell config: Devbox global shellenv, Starship prompt, Zinit plugin manager (autosuggestions, syntax highlighting, history substring search), Google Cloud SDK, NVM, mise, pnpm, zoxide (`cd` replacement), completions (devbox, docker, kubectl, terragrunt), and aliases for git/docker/terraform/terragrunt/kubectl/kubecolor
- **`.gitconfig`** — Git user config (name, email, fast-forward-only pulls, default branch = main)
- **`.config/starship.toml`** — Starship prompt config with emoji git status indicators, AWS region aliases, kubernetes context display, nix/devbox shell indicator
- **`.kube/color.yaml`** — kubecolor theme config (dark preset)

### VS Code (not symlinked via stow)

- **`vscode/settings.json`** — VS Code user settings
- **`vscode/extensions.txt`** — Extension list for batch install
- **`vscode/setup.sh`** — Installs extensions and symlinks settings.json into `~/Library/Application Support/Code/User/`

## Secrets Management

Teller (`.teller.yml`) pulls secrets from Google Secret Manager (project `vfarcic`). Running `teller` commands requires prior `gcloud auth login`.

## Runtime Version Management

mise is used for managing language runtimes (e.g., `mise use --global python@3.13`). NVM handles Node.js versions. Both are initialized in `.zshrc`.
