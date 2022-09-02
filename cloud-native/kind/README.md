# Kind

[ kind ](https://kind.sigs.k8s.io/) is a tool for running local Kubernetes clusters using `Docker` container “nodes”.

kind was primarily designed for testing Kubernetes itself, but may be used for local development or CI.

## Prerequisites

Install and Set Up kubectl on Linux

```bash
# Download the latest release
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
# Install kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm -rf ./kubectl
# Verify installation
kuebctl version
```

(Optional) Install Helm

```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

## Installation

From Release Binaries

Pre-built binaries are available on the [releases page](https://github.com/kubernetes-sigs/kind/releases).

```bash
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.14.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
```

From Package Manager

```bash
brew install kind
```

## Create a kubernetes cluster

```bash
kind create cluster --name <cluster-name> --image kindest/node:v1.23.6
```

Alternatively, you may also provision a multi-node cluster using kind.yml

```bash
kind create cluster --name <cluster-name> --image kindest/node:v1.23.6 --config kind.yaml
```

## Check cluster info

```bash
# set default context
kubectl config use kind-<cluster-name>

# check cluster info
kubectl cluster-info

# see cluster up and running
kubectl get nodes
NAME STATUS ROLES AGE VERSION
<cluster-name>-control-plane Ready control-plane,master 2m12s v1.23.5

# (optional) label worker nodes
kubectl label node dmz-cluster-worker node-role.kubernetes.io/worker=worker
```

## Delete the cluster

```bash
# To delete your cluster
kind delete cluster
```

## Export kubeconfig

```bash
sudo mkdir -p /etc/kubernetes
kind export kubeconfig --name <cluster-name>
cat ~/.k8s/config
```

## Deploy Ingress Controller

Deploy the Kubernetes supported [ Ingress NGINX Controller ](https://git.k8s.io/ingress-nginx/README.md#readme) to work as a reverse proxy and load balancer

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
```

## Deploy Sample App

```bash
kubectl apply -f app.yaml
```
