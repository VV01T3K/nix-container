#!/usr/bin/env bash

set -e  # Exit on any error

# Remove Nix directories if they exist
if [ -d "/nix" ] || [ -d "/etc/nix" ] || [ -d "$HOME/.nix-channels" ] || [ -d "$HOME/.nix-defexpr" ] || [ -d "$HOME/.nix-profile" ]; then
    echo "Removing Nix directories..."
    sudo rm -rf /etc/nix /nix "$HOME/.nix-channels" "$HOME/.nix-defexpr" "$HOME/.nix-profile"
else
    echo "Nix directories not found"
fi

# Remove direnv configuration from zshrc
if [ -f "$HOME/.zshrc" ]; then
    echo "Removing direnv configuration from .zshrc..."
    sed -i '/eval "$(direnv hook zsh)"/d' "$HOME/.zshrc"
    sed -i '/export DIRENV_LOG_FORMAT=""/d' "$HOME/.zshrc"
    sed -i '/echo '\''Hello! Welcome to your dev environment 👋'\''/d' "$HOME/.zshrc"
fi

# Remove direnv configuration from bashrc
if [ -f "$HOME/.bashrc" ]; then
    echo "Removing direnv configuration from .bashrc..."
    sed -i '/eval "$(direnv hook bash)"/d' "$HOME/.bashrc"
    sed -i '/export DIRENV_LOG_FORMAT=""/d' "$HOME/.bashrc"
    sed -i '/echo '\''Hello! Welcome to your dev environment 👋'\''/d' "$HOME/.bashrc"
fi

echo "Uninstall complete"