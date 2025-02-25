FROM mcr.microsoft.com/devcontainers/base:alpine-3.20

# Use "external" volume to store Nix store
VOLUME /nix

# Update and upgrade
RUN apk update && apk upgrade

# Install required packages for Nix
RUN apk add --no-cache curl xz
    
USER vscode

# Install Nix
RUN echo "Alpine" && curl -L https://nixos.org/nix/install -o /tmp/nix-install.sh && \
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
    echo 'export DIRENV_LOG_FORMAT=""' >> ~/.bashrc && \
    echo 'echo "Hello! Welcome to your dev container 👋"' >> ~/.zshrc && \
    echo 'echo "Hello! Welcome to your dev container 👋"' >> ~/.bashrc

USER vscode