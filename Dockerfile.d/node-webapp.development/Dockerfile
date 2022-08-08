FROM ubuntu:22.04 as builder

LABEL maintainer="docker@mazgi.com"
LABEL org.opencontainers.image.source="https://github.com/mazgi/dockerfiles/blob/main/Dockerfile.d/node-webapp.development/Dockerfile"

ARG NODE_VERSION=18
ENV NODE_VERSION=${NODE_VERSION:-18}

# Set in non-interactive mode.
ENV DEBIAN_FRONTEND=noninteractive

RUN :\
  && echo 'apt::install-recommends "false";' > /etc/apt/apt.conf.d/no-install-recommends\
  && apt-get update\
  && :

RUN : Set up locales\
  && apt-get install --assume-yes locales procps dialog\
  && echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen\
  && locale-gen\
  && :

RUN : Install basic packages\
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
  && :

RUN : Install middleware clients\
  && apt-get install --assume-yes default-mysql-client redis-tools\
  && :

RUN : Install Node.js ${NODE_VERSION}\
  && curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash -\
  && apt-get install -y nodejs\
  && :

RUN : Install development NPM packages\
  && npm install --global\
  npm-check-updates\
  sort-package-json\
  && :

RUN : Install starship\
  && curl "https://starship.rs/install.sh" -o "/tmp/install.sh"\
  && sh /tmp/install.sh --yes\
  && rm -rf /tmp/install.sh\
  && :

COPY rootfs /

# It reduced the image size by more than 30MB in my environment.
RUN : Clean up\
  && apt-get clean autoclean\
  && apt-get autoremove --yes\
  && rm -rf /var/lib/{apt,dpkg,cache,log}/\
  && :

# Reset DEBIAN_FRONTEND to default(`dialog`).
# If you no need `dialog`, you can set `DEBIAN_FRONTEND=readline`.
# see also: man 7 debconf
ENV DEBIAN_FRONTEND=

# Compress layers
FROM scratch
CMD ["/bin/zsh"]
COPY --from=builder / /
