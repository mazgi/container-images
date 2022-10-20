FROM ghcr.io/mazgi/node-webapp.development

LABEL org.opencontainers.image.source="https://github.com/mazgi/dockerfiles/blob/main/Dockerfile.d/node-webapp.development/customize-example.Dockerfile"

ARG GID=0
ARG UID=0
ARG HEALTHCHECK_URL="http://localhost/status"
ENV GID=${GID:-0}
ENV UID=${UID:-0}
ENV HEALTHCHECK_URL=${HEALTHCHECK_URL:-"http://localhost/status"}

HEALTHCHECK --interval=2s --timeout=1s --start-period=4s --retries=2\
 CMD curl --fail --output /dev/null --silent ${HEALTHCHECK_URL}

RUN :\
  # Create a user for development who has the same UID and GID as you.
  && useradd --comment '' --create-home --gid users --uid ${UID} developer\
  && groupadd --gid ${GID} developer\
  && usermod --append --groups developer developer || true\
  # It will be duplicate UID or GID with "node" user when your UID==1000 or GID==100.
  && echo '%users ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/grant-all-without-password-to-users\
  && echo '%developer ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/grant-all-without-password-to-developer\
  && :
