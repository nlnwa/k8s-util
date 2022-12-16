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

FROM alpine:3.17

LABEL maintainer="Marius André Elsfjordstrand Beck <marius.beck@nb.no>"

COPY --from=build /usr/local/bin/kubectl /usr/local/bin/kubectl
COPY --from=build /usr/local/bin/helm /usr/local/bin/helm
