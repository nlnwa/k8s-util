# Kubernetes utility docker image

[![Build Status](https://travis-ci.org/nlnwa/k8s-util.svg?branch=master)](https://travis-ci.org/nlnwa/k8s-util)

## Overview

This lightweight alpine based docker image provides binaries for working with a Kubernetes cluster:
- helm
- kubectl
- git
- openssl
- curl
- jq
- namerctl

## Run

By default kubectl will try to use `/root/.kube/config` file for connection to the kubernetes cluster, but it does not exist by default in the image.

Example use with volume mount using your local kubernetes configuration:\
```docker run -it -v ~/.kube:/root/.kube norsknettarkiv/k8s-util```

## Build

For doing a manual local build of the image:\
```make```

## Credits

[helm-kubernetes Docker hub image](https://github.com/dtzar/helm-kubectl/)
