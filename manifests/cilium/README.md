# Cilium with K0S

## Reference

https://docs.cilium.io/en/stable/installation/k0s/

## Bootstrap Cluster

```bash
curl -sSLf https://get.k0s.sh | sudo sh
# with ghproxy
curl -sSLf https://fetch.hikariai.net/api/v1/script/k0s-bootstrap.sh | sudo sh
sudo k0s config create > k0s.yaml
sudo k0s install controller --single -c k0s.yaml
sudo k0s start
sudo k0s status
sudo k0s kubectl get nodes -o wide
```

## Update config

```yaml
# replace the followings in k0s.yaml
 ...
 network:
   provider: kube-router
   kubeProxy:
     disabled: false
 ...
# with
 ...
 network:
   provider: custom
   kubeProxy:
     disabled: false
 ...
```

##  Extras (helm, kubectl)

```bash
sudo k0s kubeconfig admin > $HOME/.kube/config
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
echo 'alias k="kubectl"' >> $HOME/.bashrc
source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```

## Check cluster status

```bash
k get nodes -o wide
```

## Install Cilium

Install Cilium with CLI

```bash
CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/master/stable.txt)
CLI_ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then CLI_ARCH=arm64; fi
curl -L --fail --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
sha256sum --check cilium-linux-${CLI_ARCH}.tar.gz.sha256sum
sudo tar xzvfC cilium-linux-${CLI_ARCH}.tar.gz /usr/local/bin

cilium install

rm -rf cilium-*
```

Check status

```bash
cilium status
k get pods -n kube-system
```
