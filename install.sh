#!/usr/bin/env bash

# # Detect if script is being piped
# if [ -t 0 ]; then
#     # Running directly
#     if [ "$EUID" -ne 0 ]; then 
#         echo "Elevating privileges..."
#         exec sudo "$0" "$@"
#         exit $?
#     fi
# else
#     # Being piped through curl
#     if [ "$EUID" -ne 0 ]; then
#         echo "Please run with sudo"
#         exit 1
#     fi
# fi


curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate --no-confirm

. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix --extra-substituters https://cache.nixos.org channel --update
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
