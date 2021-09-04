FROM ghcr.io/mazgi/gentoo

LABEL maintainer="docker@mazgi.com"
LABEL org.opencontainers.image.source="https://github.com/mazgi/dockerfiles/blob/main/Dockerfile.d/node-webapp.development/Dockerfile"

ARG GENTOO_ARCH='amd64'
ENV GENTOO_ARCH=${GENTOO_ARCH:-amd64}
ARG NODE_VERSION=16
ENV NODE_VERSION=${NODE_VERSION:-16}

COPY rootfs/${GENTOO_ARCH} .

# Clone portage repository from GitHub
RUN :\
  && mkdir -p /var/db/repos/\
  && rm -rf /var/db/repos/gentoo\
  && git clone --depth=1 git://github.com/gentoo-mirror/gentoo.git /var/db/repos/gentoo\
  && rm -rf /var/db/repos/gentoo/.git\
  # 
  # Build packages
  && emerge -uNDvq --buildpkg --usepkg\
  app-misc/jq\
  dev-db/mysql\
  dev-db/redis\
  =net-libs/nodejs-${NODE_VERSION}*\
  # 
  # Install development packages
  && npm install --global\
  npm-check-updates\
  sort-package-json\
  # 
  # Clean up
  && cp -Rp /var/db/repos/gentoo/profiles /tmp/\
  && rm -rf\
  /var/cache/binpkgs/*\
  /var/db/repos/*\
  /var/lib/portage\
  /var/log/*\
  && mkdir -p /var/db/repos/gentoo/\
  && mv /tmp/profiles /var/db/repos/gentoo/
