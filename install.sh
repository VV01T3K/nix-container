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

nix-channel --list
nix --version

nix-store --gc
nix-collect-garbage -d

# Install direnv if not already installed
if ! command -v direnv &> /dev/null; then
    nix profile install nixpkgs#direnv
fi

nix-store --optimise

# Add shell configurations only if they don't exist
if [ -f $HOME/.zshrc ]; then
    if ! grep -q "direnv hook zsh" $HOME/.zshrc; then
        echo 'eval "$(direnv hook zsh)"' >> $HOME/.zshrc
        echo 'export DIRENV_LOG_FORMAT=""' >> $HOME/.zshrc
    fi
    if ! grep -q "Hello! Welcome to your dev environment" $HOME/.zshrc; then
        echo "echo 'Hello! Welcome to your dev environment 👋'" >> $HOME/.zshrc
    fi
fi

if [ -f $HOME/.bashrc ]; then
    if ! grep -q "direnv hook bash" $HOME/.bashrc; then
        echo 'eval "$(direnv hook bash)"' >> $HOME/.bashrc
        echo 'export DIRENV_LOG_FORMAT=""' >> $HOME/.bashrc
    fi
    if ! grep -q "Hello! Welcome to your dev environment" $HOME/.bashrc; then
        echo "echo 'Hello! Welcome to your dev environment 👋'" >> $HOME/.bashrc
    fi
fi

echo "
set current shell with: 

 . $HOME/.nix-profile/etc/profile.d/nix.sh

"
nix --version
nix-channel --list