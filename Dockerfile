FROM debian:bullseye-slim as build

WORKDIR /tmp

# Install kubectl, see https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
# Release info is found at: https://github.com/kubernetes/kubectl/releases
ARG KUBECTL_VERSION="v1.25.8"
ENV KUBECTL="https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
ADD ${KUBECTL} .
RUN install kubectl /usr/local/bin

# Install helm
# Release info is found at: https://github.com/helm/helm/releases
ARG HELM_VERSION="v3.11.2"
ENV HELM="https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz"
ADD ${HELM} .
RUN tar xvzf helm-${HELM_VERSION}-linux-amd64.tar.gz \
    && install linux-amd64/helm /usr/local/bin

# Install veidemannctl

ARG VEIDEMANNCTL_VERSION=0.4.1
ENV VEIDEMANNCTL="https://github.com/nlnwa/veidemannctl/releases/download/v${VEIDEMANNCTL_VERSION}/veidemannctl_${VEIDEMANNCTL_VERSION}_linux_amd64"
ADD ${VEIDEMANNCTL} veidemannctl
RUN install veidemannctl /usr/local/bin/veidemannctl

FROM debian:bullseye-slim

LABEL maintainer="Marius André Elsfjordstrand Beck <marius.beck@nb.no>"

# Install ca-certificates
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y --no-install-recommends ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /usr/local/bin/kubectl /usr/local/bin/kubectl
COPY --from=build /usr/local/bin/helm /usr/local/bin/helm
COPY --from=build /usr/local/bin/veidemannctl /usr/local/bin/veidemannctl
