FROM ghcr.io/mazgi/node-webapp.development

LABEL org.opencontainers.image.source="https://github.com/mazgi/container-images/blob/main/Dockerfile.d/node-webapp.development/customize-example.Dockerfile"

ARG GID=0
ARG UID=0
ARG HEALTHCHECK_URL="http://localhost/status"
ENV HEALTHCHECK_URL=${HEALTHCHECK_URL}

HEALTHCHECK --interval=2s --timeout=1s --start-period=4s --retries=2\
 CMD curl --fail --output /dev/null --silent ${HEALTHCHECK_URL}

RUN :\
  # Create a user for development who has the same UID and GID as you.
  && useradd --comment '' --create-home --gid users --uid ${UID} developer\
  && groupadd --gid ${GID} developer\
  # Append docker group
  && bash -c "test -n \"${DOCKER_GID}\" && groupadd --gid ${DOCKER_GID} docker"\
  && usermod --append --groups docker developer 2> /dev/null || true\
  && echo 'developer ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/grant-all-without-password-to-developer\
  && :
