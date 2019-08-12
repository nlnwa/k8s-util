FROM alpine

LABEL maintainer="Marius André Elsfjordstrand Beck <marius.beck@nb.no>" \
      org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.vcs-ref=${VCS_REF} \
      org.label-schema.vcs-url="https://github.com/nlnwa/k8s-util" \
      org.label-schema.url="https://hub.docker.com/r/norsknettarkiv/k8s-util/"

ARG VCS_REF
ARG BUILD_DATE

ARG DEPENDENCIES="ca-certificates git openssh curl jq"

# Note: Latest version of kubectl may be found at:
# https://github.com/kubernetes/kubectl/releases
ARG KUBECTL_VERSION="v1.15.2"

# Note: Latest version of helm may be found at:
# https://github.com/kubernetes/helm/releases
ARG HELM_VERSION="v2.14.3"

ENV HELM_HOST=localhost:44134

RUN apk add --update --no-cache ${DEPENDENCIES} \
    && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q http://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz \
    && tar -xvf helm-${HELM_VERSION}-linux-amd64.tar.gz \
    && mv linux-amd64/helm /usr/local/bin \
    && mv linux-amd64/tiller /usr/local/bin \
    && rm -rf linux-amd64 \
    && rm helm-${HELM_VERSION}-linux-amd64.tar.gz \
    && helm init --client-only --wait
