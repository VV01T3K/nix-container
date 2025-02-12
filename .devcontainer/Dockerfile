FROM mcr.microsoft.com/devcontainers/base:alpine-3.20

# Update and upgrade
RUN apk update && apk upgrade

# Setup direnv
RUN apk add direnv
RUN echo 'eval "$(direnv hook zsh)"' >> /etc/zsh/zshrc && \
    echo 'export DIRENV_LOG_FORMAT=""' >> /etc/zsh/zshrc && \
    echo 'eval "$(direnv hook bash)"' >> /etc/bash.bashrc && \
    echo 'export DIRENV_LOG_FORMAT=""' >> /etc/bash.bashrc

# Useless message
RUN echo "echo 'Hello! Welcome to your dev container 👋'" >> /etc/zsh/zshrc