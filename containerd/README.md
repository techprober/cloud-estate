# Containerd + CNI-Plugin + Nerdctl (Baremetal Installation)

**Notes:** The installation guide below works for both Archlinux and Ubuntu.

## References

- [How a Container Runtime is using CNI](https://karampok.me/posts/container-networking-with-cni/)
- [BuildKit - Git](https://github.com/moby/buildkit)
- [CNI-Plugins - Git](https://github.com/containernetworking/plugins)
- [Containerd - Git](https://github.com/containerd/containerd)
- [Nerdctl - Git](https://github.com/containerd/nerdctl)
- [可以像 Docker 一样方便的使用 Containerd 吗？](https://www.51cto.com/article/679424.html)
- [nerdctl: Docker-compatible CLI for contaiNERD](https://medium.com/nttlabs/nerdctl-359311b32d0e)
- [Rootless Containers](https://rootlesscontaine.rs/getting-started/containerd/)

## Quick Install (Archlinux ONLY)

```bash
# Install dependencies
sudo pacman -Sy runc bridge-utils
sudo pacman -S contained
yay -S nerdctl-full-bin
sudo pacman -S buildkit

# Enable rootless-contained
$ touch /etc/subuid /etc/subgid
$ usermod --add-subuids 100000-165535 --add-subgids 100000-165535 <username>
$ containerd-rootless-setuptool.sh install
$ sudo systemctl enable containerd --now

# Enable port-fowarding
sudo /sbin/sysctl -w net.ipv4.conf.all.forwarding=1
echo "net.ipv4.conf.all.forwarding=1" | sudo tee -a /etc/sysctl.conf

reboot
```

## Normal Install

### Purge Docker

```bash
# archlinux
sudo pacman -R dive
sudo pacman -Rns docker
sudo rm -rf /var/lib/docker

# ubuntu
sudo dpkg -l | grep -i docker
sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli docker-ce-rootless-extras docker-scan-plugin
sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce
sudo umount /var/lib/docker/
sudo rm -rf /var/lib/docker /etc/docker
sudo rm /etc/apparmor.d/docker
sudo groupdel docker
sudo rm -rf /var/run/docker.sock
sudo rm -rf /usr/bin/docker-compose
sudo rm -rf /etc/docker
sudo rm -rf ~/.docker
```

### Install Dependencies

```bash
# archlinux
sudo pacman -Syy
sudo pacman -Sy runc bridge-utils

# ubuntu
sudo apt-get update -y
sudo apt-get install -y curl runc bridge-utils
```

### Install CNI-Plugin

source: https://github.com/containernetworking/plugins

```bash
# archlinux
mkdir -p /opt/cni/bin
sudo pacman -S cni-plugins

# ubuntu
cni_version=1.1.1 # <- find the version that fits your need in the project release page
curl -sSL https://github.com/containernetworking/plugins/releases/download/v{{ cni_version }}/cni-plugins-linux-amd64-v{{ cni_version }}.tgz | sudo tar -xvz -C /opt/cni/bin
```

### Install Containerd

source: https://github.com/containerd/containerd

```bash
# archlinux
sudo pacman -S containerd
sudo systemctl daemon-reload
sudo systemctl enable containerd --now

# ubuntu
sudo apt install -qq -y containerd apt-transport-https
sudo mkdir /etc/containerd
sudo containerd config default > /etc/containerd/config.toml
sudo systemctl enable containerd --now
```

### Install Nerdctl

source: https://github.com/containerd/nerdctl

```bash
# archlinux
sudo pacman -Sy install nerdctl

# ubuntu
nerdctl_version=0.18.0 # <- find the version that first your need in the project release page
curl -sSL https://github.com/containerd/nerdctl/releases/download/v{{ nerdctl_version }}/nerdctl-{{ nerdctl_version }}-linux-amd64.tar.gz | sudo tar -xvz -C /usr/local/bin
```

### Install Buildkit Daemon

source: https://github.com/moby/buildkit

```bash
# archlinux
sudo pacman -S buildkit

# ubuntu
buildkit_version=0.10.1 # <- find the version that first your need in the project release page
curl -sSL https://github.com/moby/buildkit/releases/download/v{{ buildkit_version }}/buildkit-v{{ buildkit_version }}.linux-amd64.tar.gz | sudo tar -xvz -C /usr/local/bin


# create daemon service
sudo cat > /etc/systemd/system/buildkitd.service <Enter>
[Unit]
Description=BuildKit
Documentation=https://github.com/moby/buildkit

[Service]
ExecStart=/usr/local/bin/buildkitd --oci-worker=false --containerd-worker=true

[Install]
WantedBy=multi-user.target
<Ctrl-D>

sudo systemctl daemon-reload
sudo systemctl enable buildkitd --now
sudo systemctl status buildkitd
```

### Enable port-forward

```bash
sudo /sbin/sysctl -w net.ipv4.conf.all.forwarding=1
echo "net.ipv4.conf.all.forwarding=1" | sudo tee -a /etc/sysctl.conf
reboot
```
