FROM mcr.microsoft.com/devcontainers/base:alpine-3.20

RUN apk update && apk upgrade

# Install direnv
RUN apk add direnv

# Add direnv hook to zshrc
RUN echo 'eval "$(direnv hook zsh)"' >> /home/vscode/.zshrc && \
    echo 'export DIRENV_LOG_FORMAT=""' >> /home/vscode/.zshrc

# Configure direnv with global and whitelist settings
RUN mkdir -p /home/vscode/.config/direnv && \
    echo '[global]' > /home/vscode/.config/direnv/config.toml && \
    echo 'hide_env_diff = true' >> /home/vscode/.config/direnv/config.toml && \
    chown -R vscode:vscode /home/vscode/.config

# Add hello message to vscode user's .zshrc
RUN echo "echo 'Hello! Welcome to your dev container 👋'" >> /home/vscode/.zshrc