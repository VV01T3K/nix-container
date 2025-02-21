# Quick nix for wsl

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
- `sudo` access
- `curl`
- `xz` (xz-utils)

## Quick Start

### Installation
```bash
curl -fsSL https://raw.githubusercontent.com/VV01T3K/nix-container/refs/heads/nix-wsl/install.sh | sh
```

After installation, set up your current shell with:
```bash
. $HOME/.nix-profile/etc/profile.d/nix.sh
```

### Uninstallation
```bash
curl -fsSL https://raw.githubusercontent.com/VV01T3K/nix-container/refs/heads/nix-wsl/uninstall.sh | sh
```

### Just install nix on unstable channel
```bash
curl -fsSL https://raw.githubusercontent.com/VV01T3K/nix-container/refs/heads/nix-wsl/simple-install.sh | sh
```
### Just uninstall nix
```bash
curl -fsSL https://raw.githubusercontent.com/VV01T3K/nix-container/refs/heads/nix-wsl/simple-uninstall.sh | sh
```