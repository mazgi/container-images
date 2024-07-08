FROM node:16 as base

LABEL maintainer="docker@mazgi.com"
LABEL org.opencontainers.image.source="https://github.com/mazgi/container-images/blob/main/Dockerfile.d/debian-node-webapp.development.development/Dockerfile"

# Set in non-interactive mode.
ENV DEBIAN_FRONTEND=noninteractive

RUN echo 'apt::install-recommends "false";' > /etc/apt/apt.conf.d/no-install-recommends\
  && apt-get update\
  # 
  # Set up locales
  && apt-get install --assume-yes locales procps dialog\
  && echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen\
  && locale-gen\
  #
  # Install basic packages
  && apt-get install --assume-yes sudo apt-utils curl dnsutils git jq openssh-client tmux unzip zsh\
  && apt-get install --assume-yes apt-transport-https ca-certificates gnupg gnupg2 software-properties-common\
  # 
  # Install middleware clients
  && apt-get install --assume-yes default-mysql-client redis-tools\
  # 
  # Install development packages
  && npm install --global npm-check-updates sort-package-json\
  # 
  # Place empty .zshrc
  && touch /home/node/.zshrc\
  && chown node:node /home/node/.zshrc\
  && touch /etc/skel/.zshrc

# Reset DEBIAN_FRONTEND to default(`dialog`).
# If you no need `dialog`, you can set `DEBIAN_FRONTEND=readline`.
# see also: man 7 debconf
ENV DEBIAN_FRONTEND=
