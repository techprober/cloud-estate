# Containerd + CNI-Plugin + Nerdctl (Baremetal Installation)

The installation guide below ONLY works for Archlinux User for now. Ubuntu installation guide will be comming up soon, so stay tuned!

## Purge Docker

```bash
sudo pacman -R dive
sudo pacman -Rns docker
sudo rm -rf /var/lib/docker
```
## Install Dependencies

```bash
sudo pacman -Sy runc bridge-utils
```

## Install CNI-Plugin

```bash
mkdir -p /opt/cni/bin
curl -sSL https://github.com/containernetworking/plugins/releases/download/v1.0.1/cni-plugins-linux-amd64-v1.0.1.tgz | sudo tar -xvz -C /opt/cni/bin
```

## Install Containerd

```bash
sudo pacman -S containerd
sudo systemctl daemon-reload
sudo systemctl enable containerd --now
```

## Install Nerdctl

```bash
brew install nerdctl
```

## Install Buildkit

```bash
sudo pacman -S buildkit
sudo cat /etc/systemd/system/buildkit.service > <Enter>
[Unit]
Description=BuildKit
Documentation=https://github.com/moby/buildkit

[Service]
ExecStart=/usr/bin/buildkitd --oci-worker=false --containerd-worker=true

[Install]
WantedBy=multi-user.target
<Ctrl-D>

sudo systemctl daemon-reload
sudo systemctl enable buildkit --now
sudo systemctl status buildkit
```

## Enable port-fowarding

```bash
sudo /sbin/sysctl -w net.ipv4.conf.all.forwarding=1
echo "net.ipv4.conf.all.forwarding=1" | $SUDO tee -a /etc/sysctl.conf
reboot
```
