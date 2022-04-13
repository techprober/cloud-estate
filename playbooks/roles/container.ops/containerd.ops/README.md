# Containerd Installation

## Rootless Container (Nerdctl)

### Notes

For LXC Container, it is recommended to install Containerd in `rootful mode`; for VM, it is recommended to install Containerd in `rootless mode`

#### rootful mode

```yaml
# rootful-containerd-install.yml
---
- name: Perform Containerd Installation
  hosts: all
  become: yes

  vars_files:
    - ./roles/container.ops/containerd.ops/vars/main.yml
  roles:
    - role: ./roles/container.ops/containerd.ops
      vars:
        - rootless_containerd: false
```

#### rootless mode

```yaml
# rootless-containerd-install.yml
---
- name: Perform Containerd Installation
  hosts: all
  become: yes

  vars_files:
    - ./roles/container.ops/containerd.ops/vars/main.yml
  roles:
    - role: ./roles/container.ops/containerd.ops
      vars:
        - rootless_containerd: true
        - rootless_user: "packer" # target rootless user to run containerd with rootless previledge
```

### References:

- [Rootless Container](https://github.com/containerd/nerdctl/blob/master/docs/rootless.md)
- [Nerdctl - Rootless Mode](https://github.com/containerd/nerdctl/blob/master/docs/rootless.md)
