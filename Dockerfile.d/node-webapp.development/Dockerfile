ARG GENTOO_ARCH='amd64'
ARG NODE_VERSION=14

FROM ghcr.io/mazgi/gentoo as builder

ENV GENTOO_ARCH=${GENTOO_ARCH:-amd64}
ENV NODE_VERSION=${NODE_VERSION:-14}

COPY rootfs/${GENTOO_ARCH} .

# Clone portage repository from GitHub
RUN :\
  && mkdir -p /var/db/repos/\
  && rm -rf /var/db/repos/gentoo\
  && git clone --depth=1 git://github.com/gentoo-mirror/gentoo.git /var/db/repos/gentoo\
  && rm -rf /var/db/repos/gentoo/.git

# Build packages
RUN : emerge packages\
  && emerge -uNDvq --buildpkg --usepkg\
  app-misc/jq\
  dev-db/mysql\
  dev-db/redis\
  =net-libs/nodejs-${NODE_VERSION}*\
  && :

# ================================
FROM scratch as reducer

ENV GENTOO_ARCH=${GENTOO_ARCH:-amd64}

# Copy extracted files
COPY --from=builder / /
RUN cp -Rp /var/db/repos/gentoo/profiles /tmp/
# Clean up
RUN rm -rf\
  /var/cache/binpkgs/*\
  /var/db/repos/*\
  /var/lib/portage\
  /var/log/*
RUN mkdir -p /var/db/repos/gentoo/\
  && mv /tmp/profiles /var/db/repos/gentoo/

# ================================
FROM scratch
LABEL maintainer="docker@mazgi.com"
LABEL org.opencontainers.image.source="https://github.com/mazgi/dockerfiles/blob/main/Dockerfile.d/node-webapp.development/Dockerfile"
COPY --from=reducer / /
