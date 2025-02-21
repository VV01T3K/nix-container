#!/usr/bin/env bash

set -e  # Exit on any error

# Remove Nix directories if they exist
if [ -d "/nix" ] || [ -d "/etc/nix" ] || [ -d "$HOME/.nix-channels" ] || [ -d "$HOME/.nix-defexpr" ] || [ -d "$HOME/.nix-profile" ]; then
    echo "Removing Nix directories..."
    sudo rm -rf /etc/nix /nix "$HOME/.nix-channels" "$HOME/.nix-defexpr" "$HOME/.nix-profile"
else
    echo "Nix directories not found"
fi

echo "Uninstall complete"