FROM ghcr.io/mazgi/node-webapp.development

LABEL org.opencontainers.image.source="https://github.com/mazgi/container-images/blob/main/Dockerfile.d/node-webapp.development/customize-example.Dockerfile"

ARG GID=0
ARG UID=0
ARG HEALTHCHECK_URL="http://localhost/status"
ENV HEALTHCHECK_URL=${HEALTHCHECK_URL}

HEALTHCHECK --interval=2s --timeout=1s --start-period=4s --retries=2\
 CMD curl --fail --output /dev/null --silent ${HEALTHCHECK_URL}

RUN :\
  # Create the development user with the same UID and GID as you.
  && useradd --comment '' --create-home --gid users --uid ${UID} developer\
  && groupadd --gid ${GID} developer || true\
  && usermod --append --groups ${GID} developer || true\
  && echo '%users ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/grant-all-without-password-to-users\
  && echo '%developer ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/grant-all-without-password-to-developer\
  && :
