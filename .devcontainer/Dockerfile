FROM mcr.microsoft.com/devcontainers/base:alpine-3.20

VOLUME /nix

# Update and upgrade
RUN apk update && apk upgrade

# Install required packages for Nix
RUN apk add --no-cache curl xz
    
USER vscode

# Install Nix
RUN curl -L https://nixos.org/nix/install -o /tmp/nix-install.sh && \
    sh /tmp/nix-install.sh --no-daemon && \
    rm /tmp/nix-install.sh

USER root

RUN mkdir -p /etc/nix
RUN echo 'sandbox = false' >> /etc/nix/nix.conf \
    && echo 'experimental-features = nix-command flakes' >> /etc/nix/nix.conf

USER vscode

# Add Nix to the PATH
ENV PATH="/home/vscode/.nix-profile/bin:${PATH}"

RUN nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs && \
    nix-channel --update

# Install direnv
RUN nix profile install nixpkgs#direnv

USER root

# Setup direnv
RUN echo 'eval "$(direnv hook zsh)"' >> /etc/zsh/zshrc && \
    echo 'export DIRENV_LOG_FORMAT=""' >> /etc/zsh/zshrc && \
    echo 'eval "$(direnv hook bash)"' >> /etc/bash.bashrc && \
    echo 'export DIRENV_LOG_FORMAT=""' >> /etc/bash.bashrc

# Welcome message
RUN echo "echo 'Hello! Welcome to your dev container 👋'" >> /etc/zsh/zshrc