FROM alpine

ARG VCS_REF
ARG BUILD_DATE

# Metadata
LABEL maintainer="marius.beck@nb.no" \
      org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.vcs-ref=${VCS_REF} \
      org.label-schema.vcs-url="https://github.com/nlnwa/k8s-util" \
      org.label-schema.name="k8s-util" \                                 
      org.label-schema.url="https://hub.docker.com/r/norsknettarkiv/k8s-util/"

ARG DEPENDENCIES="ca-certificates git openssh curl jq"

# Note: Latest version of kubectl may be found at:
# https://aur.archlinux.org/packages/kubectl-bin/
ARG KUBE_LATEST_VERSION="v1.12.0"

# Note: Latest version of helm may be found at:
# https://github.com/kubernetes/helm/releases
ARG HELM_VERSION="v2.12.2"

# Note: Latest version of namerctl may be found at:
# https://github.com/linkerd/namerctl/releases
ARG NAMERCTL_VERSION="0.8.6"

RUN apk add --update --no-cache ${DEPENDENCIES} \
    && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl \
    -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q http://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz \
    -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && wget -q https://github.com/linkerd/namerctl/releases/download/${NAMERCTL_VERSION}/namerctl_linux_amd64 \
    -O /usr/local/bin/namerctl \
    && chmod +x /usr/local/bin/namerctl

WORKDIR /config
