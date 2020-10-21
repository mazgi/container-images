FROM node:12 as base

LABEL org.opencontainers.image.source="https://github.com/mazgi/dockerfiles/blob/main/Dockerfile.d/node-firebase.development/Dockerfile"

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
  && apt-get install --assume-yes sudo dnsutils netcat git tmux zsh jq\
  # 
  # Todo: Why did I install OpenJDK???
  && apt-get install --assume-yes openjdk-8-jdk-headless\
  # 
  # Place empty .zshrc
  && touch /etc/skel/.zshrc

# Reset DEBIAN_FRONTEND to default(`dialog`).
# If you no need `dialog`, you can set `DEBIAN_FRONTEND=readline`.
# see also: man 7 debconf
ENV DEBIAN_FRONTEND=
