FROM debian:bullseye-slim as build

WORKDIR /tmp

# Install kubectl, see https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
# Release info is found at: https://github.com/kubernetes/kubectl/releases
ARG KUBECTL_VERSION="v1.25.9"
ENV KUBECTL="https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
ADD ${KUBECTL} .
RUN install kubectl /usr/local/bin

# Install helm
# Release info is found at: https://github.com/helm/helm/releases
ARG HELM_VERSION="v3.11.3"
ENV HELM="https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz"
ADD ${HELM} .
RUN tar xvzf helm-${HELM_VERSION}-linux-amd64.tar.gz \
    && install linux-amd64/helm /usr/local/bin

# Install veidemannctl
ARG VEIDEMANNCTL_VERSION=0.4.1
ENV VEIDEMANNCTL="https://github.com/nlnwa/veidemannctl/releases/download/v${VEIDEMANNCTL_VERSION}/veidemannctl_${VEIDEMANNCTL_VERSION}_linux_amd64"
ADD ${VEIDEMANNCTL} veidemannctl
RUN install veidemannctl /usr/local/bin/veidemannctl

# Install yq
ARG YQ_VERSION="v4.33.3"
ENV YQ="https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64"
ADD ${YQ} yq
RUN install yq /usr/local/bin/yq

# Install kustomize
ARG KUSTOMIZE_VERSION="v5.0.1"
ENV KUSTOMIZE="https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz"
ADD ${KUSTOMIZE} .
RUN tar xvzf kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz \
    && install kustomize /usr/local/bin

# Install kubeconform
ARG KUBECONFORM_VERSION="v0.6.1"
ENV KUBECONFORM="https://github.com/yannh/kubeconform/releases/download/${KUBECONFORM_VERSION}/kubeconform-linux-amd64.tar.gz"
ADD ${KUBECONFORM} .
RUN tar xvzf kubeconform-linux-amd64.tar.gz \
    && install kubeconform /usr/local/bin


FROM debian:bullseye-slim

LABEL maintainer="Marius André Elsfjordstrand Beck <marius.beck@nb.no>"

# Install ca-certificates
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /usr/local/bin/* /usr/local/bin/
