FROM mcr.microsoft.com/devcontainers/base:alpine-3.20

# Update and upgrade
RUN apk update && apk upgrade

# Install required packages for Nix
RUN apk add --no-cache curl xz

# Install unstable Nix
ENV NIX_INSTALLER_NO_MODIFY_PROFILE=1

USER vscode
RUN curl -L https://nixos.org/nix/install -o /tmp/nix-install.sh && \
    sh /tmp/nix-install.sh --no-daemon && \
    rm /tmp/nix-install.sh
USER root

# RUN mkdir -p /etc/nix
# RUN echo 'sandbox = false' >> /etc/nix/nix.conf \
#     && echo 'experimental-features = nix-command flakes' >> /etc/nix/nix.conf
#     #  \
#     # && nix-channel --add https://nixos.org/channels/nixpkgs-unstable \
#     # && nix-channel --update

# Add Nix to shell environments
RUN echo '. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' >> /etc/zsh/zshrc && \
    echo '. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' >> /etc/bash.bashrc

# # Install direnv
# RUN nix profile install nixpkgs#direnv

# # Setup direnv
# RUN echo 'eval "$(direnv hook zsh)"' >> /etc/zsh/zshrc && \
#     echo 'export DIRENV_LOG_FORMAT=""' >> /etc/zsh/zshrc && \
#     echo 'eval "$(direnv hook bash)"' >> /etc/bash.bashrc && \
#     echo 'export DIRENV_LOG_FORMAT=""' >> /etc/bash.bashrc

# Welcome message
RUN echo "echo 'Hello! Welcome to your dev container 👋'" >> /etc/zsh/zshrc