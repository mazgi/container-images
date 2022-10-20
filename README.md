# dockerfiles

[![start-stop-containers](https://github.com/mazgi/dockerfiles/workflows/start-stop-containers/badge.svg)](https://github.com/mazgi/dockerfiles/actions?query=workflow%3Astart-stop-containers)
[![publish-docker-images](https://github.com/mazgi/dockerfiles/workflows/publish-docker-images/badge.svg)](https://github.com/mazgi/dockerfiles/actions?query=workflow%3Apublish-docker-images)
[![publish-docker-images-each-node-version](https://github.com/mazgi/dockerfiles/workflows/publish-docker-images-each-node-version/badge.svg)](https://github.com/mazgi/dockerfiles/actions?query=workflow%3Apublish-docker-images-each-node-version)

My Dockerfile and related resources.

## How to Use

### Write out your IDs and information in the .env file

If you have an old `.env` file, you are able to reset it by removing it.

```console
rm -f .env
```

:information_source: If you are using Linux, write out UID, GID, and GID for the `docker` group, into the `.env` file to let that as exported on Docker Compose as environment variables.

```console
test $(uname -s) = 'Linux' && {
  echo -e "DOCKER_GID=$(getent group docker | cut -d : -f 3)"
  echo -e "GID=$(id -g)"
  echo -e "UID=$(id -u)"
} >> .env || :
```

## Supplementary Information

### Environment Variable Names

Environment variable names and uses are as follows.

| Name       | Required on Linux | Value                                                                                                                                   |
| ---------- | ----------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| UID        | **Yes**           | This ID number is used as UID for your Docker user, so this ID becomes the owner of all files and directories created by the container. |
| GID        | **Yes**           | The same as the above UID.                                                                                                              |
| DOCKER_GID | **Yes**           | This ID number is used to provide permission to read and write your docker socket on your local machine from your container.            |
