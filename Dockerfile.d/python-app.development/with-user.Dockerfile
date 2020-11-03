FROM ghcr.io/mazgi/python-app.development

LABEL org.opencontainers.image.source="https://github.com/mazgi/dockerfiles/blob/main/Dockerfile.d/python-app.development/with-user.Dockerfile"

# Set in non-interactive mode.
ENV DEBIAN_FRONTEND=noninteractive

ARG GID=0
ARG UID=0
ENV GID=${GID:-0}
ENV UID=${UID:-0}

RUN :\
  # Create a user for development who has the same UID and GID as you.
  && groupadd --gid ${GID} developer || true\
  && useradd --comment '' --create-home --gid users --groups developer --uid ${UID} developer\
  && echo '%users ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/grant-all-without-password-to-users\
  && echo '%developer ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/grant-all-without-password-to-developer

# Reset DEBIAN_FRONTEND to default(`dialog`).
# If you no need `dialog`, you can set `DEBIAN_FRONTEND=readline`.
# see also: man 7 debconf
ENV DEBIAN_FRONTEND=
