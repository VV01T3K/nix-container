#!/usr/bin/env bash

set -e  # Exit on any error

# if ! dpkg -l | grep xz-utils; then
#     echo "xz-utils is not installed. Please install it and run this again."
#     exit 1
# fi

curl -L https://nixos.org/nix/install | sh -s -- --no-daemon

mkdir -p /etc/nix
# echo 'sandbox = false' >> /etc/nix/nix.conf
echo 'experimental-features = nix-command flakes' >> /etc/nix/nix.conf # enable flakes

. ~/.nix-profile/etc/profile.d/nix.sh

nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update
nix-channel --list
nix --version

nix-store --gc
nix-collect-garbage -d

nix profile install nixpkgs#direnv  # with flakes
# nix-env -iA nixpkgs.direnv        # without flakes

nix-store --optimise

echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc
echo 'export DIRENV_LOG_FORMAT=""' >> ~/.zshrc
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
echo 'export DIRENV_LOG_FORMAT=""' >> ~/.bashrc

echo "echo 'Hello! Welcome to your dev environment 👋'" >> ~/.zshrc
echo "echo 'Hello! Welcome to your dev environment 👋'" >> ~/.bashrc

echo "
set current shell with: 

 . ~/.nix-profile/etc/profile.d/nix.sh

"
nix --version
nix-channel --list