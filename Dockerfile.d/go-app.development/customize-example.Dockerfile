FROM ghcr.io/mazgi/go-app.development

LABEL org.opencontainers.image.source="https://github.com/mazgi/container-images/blob/main/Dockerfile.d/go-app.development/customize-example.Dockerfile"

ARG GID=0
ARG UID=0

HEALTHCHECK --interval=2s --timeout=1s --retries=2 --start-period=5s\
 CMD true

RUN :\
  # Create the development user with the same UID and GID as you.
  && useradd --comment '' --create-home --gid users --uid ${UID} developer || true\
  && groupadd --gid ${GID} developer || true\
  && usermod --append --groups ${GID} developer || true\
  && echo '%users ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/grant-all-without-password-to-users\
  && echo '%developer ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/grant-all-without-password-to-developer\
  && :
