#!/usr/bin/env bash

set -e  # Exit on any error

# Check if Nix is already installed
if ! command -v nix &> /dev/null; then
    curl -L https://nixos.org/nix/install | sh -s -- --no-daemon
else
    echo "Nix is already installed"
fi

# Create /etc/nix if it doesn't exist
sudo mkdir -p /etc/nix

# Add experimental features only if not already present
if ! grep -q "experimental-features = nix-command flakes" /etc/nix/nix.conf 2>/dev/null; then
    echo 'experimental-features = nix-command flakes' | sudo tee -a /etc/nix/nix.conf
fi

. $HOME/.nix-profile/etc/profile.d/nix.sh

# Add update channel to bleeding edge :v
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update

nix-store --gc
nix-collect-garbage -d

nix-store --optimise

nix-channel --list
nix --version