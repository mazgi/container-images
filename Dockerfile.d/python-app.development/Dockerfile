FROM python:3.6.9-buster

LABEL maintainer="docker@mazgi.com"
LABEL org.opencontainers.image.source="https://github.com/mazgi/container-images/blob/main/Dockerfile.d/python-app.development/Dockerfile"

# Set in non-interactive mode.
ARG DEBIAN_FRONTEND=noninteractive

RUN echo 'apt::install-recommends "false";' > /etc/apt/apt.conf.d/no-install-recommends\
  && apt-get update\
  && apt-get install --assume-yes locales procps dialog\
  && echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen\
  && locale-gen\
  && apt-get install --assume-yes dnsutils git jq netcat sudo tmux unzip zsh\
  && python3 -m pip install --upgrade pip\
  # 
  # Place empty .zshrc
  && touch /etc/skel/.zshrc
