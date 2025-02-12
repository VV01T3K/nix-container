#!/usr/bin/env bash

if ! dpkg -l | grep xz-utils; then
    echo "xz-utils is not installed. Please install it and run this again."
    exit 1
fi

curl -L https://nixos.org/nix/install | sh -s -- --no-daemon

. /home/q/.nix-profile/etc/profile.d/nix.sh

nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update --extra-substituters https://cache.nixos.org
nix-channel --list
nix --version

nix --extra-substituters https://cache.nixos.org profile install nixpkgs#direnv

nix-collect-garbage -d
nix-store --optimise

echo 'eval "$(direnv hook zsh)"' >> /etc/zsh/zshrc
echo 'export DIRENV_LOG_FORMAT=""' >> /etc/zsh/zshrc
echo 'eval "$(direnv hook bash)"' >> /etc/bash.bashrc
echo 'export DIRENV_LOG_FORMAT=""' >> /etc/bash.bashrc

echo "echo 'Hello! Welcome to your dev environment 👋'" >> /etc/zsh/zshrc
echo "echo 'Hello! Welcome to your dev environment 👋'" >> /etc/bash.bashrc
