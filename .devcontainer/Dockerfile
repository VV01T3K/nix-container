FROM mcr.microsoft.com/devcontainers/base:alpine-3.20

RUN apk update && apk upgrade

RUN apk add direnv

RUN echo 'eval "$(direnv hook zsh)"' >> /etc/zsh/zshrc && \
    echo 'export DIRENV_LOG_FORMAT=""' >> /etc/zsh/zshrc

RUN echo "echo 'Hello! Welcome to your dev container 👋'" >> /etc/zsh/zshrc