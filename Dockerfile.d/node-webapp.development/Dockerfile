FROM ubuntu:22.04

LABEL maintainer="docker@mazgi.com"
LABEL org.opencontainers.image.source="https://github.com/mazgi/dockerfiles/blob/main/Dockerfile.d/node-webapp.development/Dockerfile"

ARG NODE_VERSION=18
ENV NODE_VERSION=${NODE_VERSION:-18}

# Set in non-interactive mode.
ENV DEBIAN_FRONTEND=noninteractive

RUN :\
  && echo 'apt::install-recommends "false";' > /etc/apt/apt.conf.d/no-install-recommends\
  && apt-get update\
#   && :
# RUN :\
  && : Set up locales\
  && apt-get install --assume-yes locales procps dialog\
  && echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen\
  && locale-gen\
#   && :
# RUN :\
  && : Install basic packages\
  && apt-get install --assume-yes\
  apt-transport-https\
  apt-utils\
  ca-certificates\
  curl\
  dnsutils\
  git\
  gnupg\
  gnupg2\
  jq\
  openssh-client\
  software-properties-common\
  sudo\
  unzip\
  zsh\
#   && :
# RUN :\
  && : Install middleware clients\
  && apt-get install --assume-yes default-mysql-client redis-tools\
#   && :
# RUN :\
  && : Install Node.js ${NODE_VERSION}\
  && curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash -\
  && apt-get install -y nodejs\
#   && :
# RUN :\
  && : Install development NPM packages\
  && npm install --global\
  concurrently\
  # see https://github.com/npm/cli/issues/3438
  npm\
  npm-check-updates\
  pnpm\
  sort-package-json\
  && npm cache clean -force\
#   && :
# RUN :\
  && : Install starship\
  && curl "https://starship.rs/install.sh" -o "/tmp/install.sh"\
  && sh /tmp/install.sh --yes\
  && rm -rf /tmp/install.sh\
#   && :
# RUN :\
  && : Clean up\
  && apt-get clean autoclean\
  && apt-get autoremove --yes\
  && rm -rf /tmp/*\
  && rm -rf /var/lib/apt/\
  && rm -rf /var/log/*\
  && :

COPY rootfs /

# Set in non-interactive mode.
ENV DEBIAN_FRONTEND=noninteractive
