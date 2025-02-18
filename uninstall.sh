#!/usr/bin/env bash

set -e  # Exit on any error

# Remove Nix directories if they exist
if [ -d "/nix" ] || [ -d "/etc/nix" ]; then
    echo "Removing Nix directories..."
    sudo rm -rf /nix /etc/nix
else
    echo "Nix directories not found"
fi

# Remove direnv configuration from zshrc
if [ -f ~/.zshrc ]; then
    echo "Removing direnv configuration from .zshrc..."
    sed -i '/eval "$(direnv hook zsh)"/d' ~/.zshrc
    sed -i '/export DIRENV_LOG_FORMAT=""/d' ~/.zshrc
    sed -i '/echo '\''Hello! Welcome to your dev environment 👋'\''/d' ~/.zshrc
fi

# Remove direnv configuration from bashrc
if [ -f ~/.bashrc ]; then
    echo "Removing direnv configuration from .bashrc..."
    sed -i '/eval "$(direnv hook bash)"/d' ~/.bashrc
    sed -i '/export DIRENV_LOG_FORMAT=""/d' ~/.bashrc
    sed -i '/echo '\''Hello! Welcome to your dev environment 👋'\''/d' ~/.bashrc
fi

echo "Uninstall complete"