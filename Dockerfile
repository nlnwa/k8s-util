FROM alpine:3.17 as build

# Release info is found at: https://github.com/kubernetes/kubectl/releases
ARG KUBECTL_VERSION="v1.22.17"
ENV KUBECTL="https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"

# Install kubectl, see https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
RUN wget ${KUBECTL} \
    && install kubectl /usr/local/bin

# Release info is found at: https://github.com/helm/helm/releases
ARG HELM_VERSION="v3.10.3"
ENV HELM="https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz"


# Install helm
RUN wget ${HELM} \
    && tar xvzf helm-${HELM_VERSION}-linux-amd64.tar.gz \
    && install linux-amd64/helm /usr/local/bin

ARG VEIDEMANNCTL_VERSION=0.4.1
ENV VEIDEMANNCTL="https://github.com/nlnwa/veidemannctl/releases/download/v${VEIDEMANNCTL_VERSION}/veidemannctl_${VEIDEMANNCTL_VERSION}_linux_amd64"

# Install veidemannctl
RUN wget -o veidemannctl ${VEIDEMANNCTL} \
    && install veidemannctl /usr/local/bin/veidemannctl

FROM alpine:3.17

LABEL maintainer="Marius André Elsfjordstrand Beck <marius.beck@nb.no>"

COPY --from=build /usr/local/bin/kubectl /usr/local/bin/kubectl
COPY --from=build /usr/local/bin/helm /usr/local/bin/helm
COPY --from=build /usr/local/bin/veidemannctl /usr/local/bin/veidemannctl
