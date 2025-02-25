FROM mcr.microsoft.com/devcontainers/base:jammy

# Use "external" volume to store Nix store
VOLUME /nix

# Update and upgrade
RUN apt update -y && apt upgrade -y

# Install required packages for Nix
RUN apt install -y curl xz-utils
    
USER vscode

# Install Nix
RUN echo "Ubuntu" && curl -L https://nixos.org/nix/install -o /tmp/nix-install.sh && \
    sh /tmp/nix-install.sh --no-daemon && \
    rm /tmp/nix-install.sh

USER root

RUN mkdir -p /etc/nix && \
    echo 'sandbox = false' >> /etc/nix/nix.conf && \
    echo 'experimental-features = nix-command flakes' >> /etc/nix/nix.conf

USER vscode

# Add Nix to the PATH
# for docker to pick up the nix command
ENV PATH="/home/vscode/.nix-profile/bin:${PATH}"

RUN nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs && \
    nix-channel --update

# Install direnv
RUN nix profile install nixpkgs#direnv

# Setup direnv and welcome message for zsh and bash
RUN echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc && \
    echo 'export DIRENV_LOG_FORMAT=""' >> ~/.zshrc && \
    echo 'eval "$(direnv hook bash)"' >> ~/.bashrc && \
    echo 'export DIRENV_LOG_FORMAT=""' >> ~/.bashrc

USER vscode