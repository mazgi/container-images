# dockerfiles

[![start-stop-containers](https://github.com/mazgi/dockerfiles/workflows/start-stop-containers/badge.svg)](https://github.com/mazgi/dockerfiles/actions?query=workflow%3Astart-stop-containers)
[![publish-docker-images](https://github.com/mazgi/dockerfiles/workflows/publish-docker-images/badge.svg)](https://github.com/mazgi/dockerfiles/actions?query=workflow%3Apublish-docker-images)
[![publish-docker-images-each-node-version](https://github.com/mazgi/dockerfiles/workflows/publish-docker-images-each-node-version/badge.svg)](https://github.com/mazgi/dockerfiles/actions?query=workflow%3Apublish-docker-images-each-node-version)

My Dockerfile and related resources.

You need create the `.env` file as follows.

```shellsession
rm -f .env
test $(uname -s) = 'Linux' && echo "UID=$(id -u)\nGID=$(id -g)" >> .env
cat<<EOE >> .env
DOCKER_GID=$(getent group docker | cut -d : -f 3)
EOE
```
