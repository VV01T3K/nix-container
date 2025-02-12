#!/usr/bin/env bash

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then 
    echo "Elevating privileges..."
    exec sudo "$0" "$@"
    exit $?
fi

apt-get update
apt-get upgrade
apt update -y
apt upgrade -y
apt autoremove -y

curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate --no-confirm

nix-env -iA nixpkgs.direnv
echo 'eval "$(direnv hook zsh)"' >> /etc/zsh/zshrc
echo 'export DIRENV_LOG_FORMAT=""' >> /etc/zsh/zshrc
echo 'eval "$(direnv hook bash)"' >> /etc/bash.bashrc
echo 'export DIRENV_LOG_FORMAT=""' >> /etc/bash.bashrc

echo "echo 'Hello! Welcome to your dev container 👋'" >> /etc/zsh/zshrc
echo "echo 'Hello! Welcome to your dev container 👋'" >> /etc/bash.bashrc