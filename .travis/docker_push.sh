#!/usr/bin/env sh

echo "${DOCKER_PASSWORD}" | docker login -u="${DOCKER_USERNAME}" --password-stdin
docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
