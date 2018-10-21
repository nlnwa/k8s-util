default: docker_build

DOCKER_IMAGE ?= norsknettarkiv/k8s-util
DOCKER_TAG ?= `git rev-parse --abbrev-ref HEAD`
VCS_REF ?= `git rev-parse --short HEAD`
BUILD_DATE ?= `date -u +"%Y-%m-%dT%H:%M:%SZ"`
DEPENDENCIES ?= ca-certificates git openssl curl jq

docker_build:
	@docker build \
--build-arg DEPENDENCIES="$(DEPENDENCIES)" \
--build-arg VCS_REF="$(VCS_REF)" \
--build-arg BUILD_DATE="$(BUILD_DATE)" \
-t $(DOCKER_IMAGE):$(DOCKER_TAG) .

docker_push:
	@docker push $(DOCKER_IMAGE):$(DOCKER_TAG)
