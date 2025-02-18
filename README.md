# Quick nix for wsl setup

A simple setup script for installing Nix package manager with direnv integration in WSL.

## Features

- Installs Nix package manager in non-daemon mode (single-user)
- Updates nix channel to unstable for latest features on the bleeding edge
- Enables experimental features (nix-command and flakes)
- Sets up direnv for environment management
- Configures shell integration (bash and zsh support)

## Prerequisites

- Linux-based environment
- bash or zsh shell
- sudo access
- curl
- xz (xz-utils)

## Quick Start

### Installation
```bash
curl -fsSL https://raw.githubusercontent.com/VV01T3K/nix-container/refs/heads/nix-wsl/install.sh | sh
```

### Uninstallation
```bash
curl -fsSL https://raw.githubusercontent.com/VV01T3K/nix-container/refs/heads/nix-wsl/uninstall.sh | sh
```

### Post-Installation
After installation, set up your current shell with:
```bash
. $HOME/.nix-profile/etc/profile.d/nix.sh
```