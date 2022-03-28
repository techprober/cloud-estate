## Proxmox Maintenance

[ community.general.proxmox_kvm ](https://docs.ansible.com/ansible/latest/collections/community/general/proxmox_kvm_module.html) - management of Qemu(KVM) Virtual Machines in Proxmox VE cluster

[ community.general.proxmox ](https://docs.ansible.com/ansible/latest/collections/community/general/proxmox_module.html) - management of LXC instances in Proxmox VE cluster

## Pre-requisite

Install `community.general` modules

```bash
ansible-galaxy collection isntall community.general
```

Install Proxmoxer on Proxmox Node

```bash
apt install python3-pip
pip3 install proxmoxer
```

## References

https://docs.ansible.com/ansible/latest/collections/community/general/proxmox_kvm_module.html
