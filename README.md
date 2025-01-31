# Dotfiles Setup and Synchronization

[![Master Your New Laptop Setup: Tools, Configs, and Secrets!](https://img.youtube.com/vi/FH083GOJoIM/0.jpg)](https://youtu.be/FH083GOJoIM)

Setting up a new machine can be tedious, especially when it comes to configuring tools exactly the way you like them. This guide outlines how to automate the installation and synchronization of dotfiles, ensuring that all your machines are consistently configured.

## Prerequisites

- A Unix-based system (macOS, Linux)
- Git installed
- Homebrew (for macOS users)
- Devbox installed
- Teller for secrets management
- Stow for managing symlinks

## Installation

### Clone the Repository

```sh
cd ~/
git clone https://github.com/<org>/dotfiles
cd dotfiles
git pull
git fetch
git checkout dotfiles
chmod +x install.sh
```

### Run the Installation Script

```sh
./install.sh
```

This script installs the necessary global CLI tools, including:

- Starship prompt
- Zinit
- TheFuck
- Fira Code font
- Eza
- Fzf
- Zoxide
- Bat
- Devbox

If you're not using macOS, adapt the script for your package manager.

## Configuring Dotfiles

### Backup Existing Dotfiles

Before replacing existing configuration files, back them up:

```sh
mv ~/.zshrc ~/.zshrc-orig
mv ~/.config/starship.toml ~/.config/starship.toml-orig
mv ~/.config/fabric ~/.config/fabric-orig
```

### Verify Installation

Ensure that the necessary dotfiles do not exist before proceeding:

```sh
cat ~/.zshrc
cat ~/.config/starship.toml
```

If these files are missing, proceed with synchronization.

## Synchronization

### Start Devbox Shell

```sh
devbox shell
```

This ensures project-specific tools are available.

### Run the Synchronization Script

```sh
./sync.sh
source ~/.zshrc
```

This script:

1. Logs into Google Cloud (`gcloud auth login`)
2. Retrieves secrets using Teller
3. Removes existing `.zshrc`
4. Uses `stow` to create symlinks for dotfiles

## Managing Dotfiles with Git

To keep configurations updated:

```sh
git add .
git commit -m "Update configurations"
git push
```

To pull changes on another machine:

```sh
git pull origin main
./sync.sh
source ~/.zshrc
```

## Conclusion

Using Git, Devbox, Teller, and Stow, you can seamlessly set up and synchronize dotfiles across multiple machines. This approach ensures a consistent development environment whether you're using a desktop or a laptop.

## Cleanup

```sh
mv ~/.zshrc-orig ~/.zshrc
mv ~/.config/starship.toml-orig ~/.config/starship.toml
mv ~/.config/fabric-orig ~/.config/fabric
```
