# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository that uses **GNU Stow** to manage symlinks from this directory into `$HOME`. The repo is cloned to `~/dotfiles` (or similar) and `stow .` creates symlinks for all non-ignored files/directories into `~`.

## Key Commands

```sh
# Install system dependencies (Homebrew-based, macOS)
./install.sh

# Sync dotfiles (removes ~/.zshrc, then runs stow)
./sync.sh
source ~/.zshrc

# Enter devbox shell (provides stow, gum, teller, gcloud, kubectl, etc.)
devbox shell

# Remove all installed tools and symlinks
./uninstall.sh
```

## How Stow Works Here

- The repo root is the stow directory; `stow .` symlinks everything into `$HOME`
- `.stow-local-ignore` excludes: `.devbox/`, `.gitignore`, `.teller.yml`, `devbox.*`, `gcloud/`, `install.sh`, `.git/`
- Any new config file/directory added at the repo root will be symlinked to `$HOME` — be intentional about what goes in the root

## Architecture

- **`.zshrc`** — Shell config: Devbox global shellenv, Starship prompt, Zinit plugin manager (autosuggestions, syntax highlighting, history substring search), Zoxide (`cd` replacement), aliases (git, docker, terraform, terragrunt, kubectl/kubecolor)
- **`.config/starship.toml`** — Starship prompt config with emoji git status indicators, kubernetes context display, nix/devbox shell indicator
- **`.config/zellij/config.kdl`** — Zellij terminal multiplexer with `clear-defaults=true` keybindings (vim-style hjkl navigation), tmux compatibility layer via `Ctrl b`
- **`.config/fabric/`** — Fabric AI patterns (system/user prompt templates); secrets in `.env` are gitignored and managed via Teller from Google Secret Manager
- **`.kube/color.yaml`** — kubecolor theme config (dark preset)
- **`.local/share/devbox/global/default/devbox.json`** — Devbox global packages (gh, starship, bat, zoxide, fzf, eza, thefuck)
- **`devbox.json`** — Project-level devbox packages (kind, gcloud, gum, teller, stow, gh, jq, yq, kubectl)

## Secrets Management

Teller (`.teller.yml`) pulls secrets from Google Secret Manager (project `vfarcic`) into `.config/fabric/.env`. The `.env` file is gitignored. Running `teller env > .config/fabric/.env` requires prior `gcloud auth login`.
