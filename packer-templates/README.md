<h1 align="center">Packer Templates</h1>
<p align="center">
    <em>Declare Proxmox Template as Code</em>
</p>
<p align="center">
    <a href="https://t.me/pve_zh">
        <img src="https://img.shields.io/badge/join-us%20on%20proxmox%20group-gray.svg?longCache=true&logo=proxmox&colorB=orange" alt="join-us-on-proxmox-group"/>
    </a>
    <a href="https://www.packer.io/plugins/builders/proxmox/">
        <img src="https://img.shields.io/badge/provider-proxmox%20builder-gray.svg?longCache=true&logo=packer&colorB=blueviolet" alt="proxmox-builder-packer"/>
    </a>
    <a href="https://github.com/TechProber/cloud-estate">
        <img src="https://img.shields.io/github/last-commit/TechProber/cloud-estate" alt="lastcommit"/>
    </a>
</p>

## Introduction

Maunally creating and managing VM Templates in Proxmox can become a challenge with how time-consuming and manual it can be. This repo will walk you through how you can make this process more standardized and automated with the use of packer to allow you to declare your `Proxmox Templates as Code`.

## Table of Contents

- [Prerequisite](#prerequisite)
- [What is Packer](#what-is-packer)
- [Create a Proxmox user for Packer](#create-proxmox-user-for-packer)
- [How to use](#how-to-use)

## Prerequisite

Install `packer` locally on your machine

```bash
# archlinux
sudo pacman -S packer

# debian/ubuntu
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install packer

# homebrew
brew tap hashicorp/tap
brew install hashicorp/tap/packer

# verify installation
packer
```

Install necessary plugins

```bash
packer init ./proxmox-packer-template.pkr.hcl
```

For detailed instructions on how to install Packer on other platforms or Linux distributions, please head to this [ Getting Started ](https://learn.hashicorp.com/tutorials/packer/get-started-install-cli) guide.

## What is Packer

Packer is a utility that allows you to build virtual machine images so that you can define a golden image as code. Packer can be used to create images for almost all of the big cloud providers such as AWS, GCE, Azure, and Digital Ocean, or can be used with locally installed hypervisors such as VMWare, Proxmox, and a few others.

To build an image with packer we need to define our image through a template file. The file uses the JSON format and comprises 3 main sections that are used to define and prepare your image.

<details><summary>Builders</summary>

</br>

> Builders: Components of Packer that are able to create a machine image for a single platform. A builder is invoked as part of a build in order to create the actual resulting images.

</details>

<details><summary>Provisioners</summary>

</br>

> Provisioners: Install and configure software within a running machine prior to that machine being turned into a static image. Example provisioners include shell scripts, Chef, Puppet, etc.

</details>

<details><summary>Post Processors</summary>

</br>

> Provisioners: Install and configure software within a running machine prior to that machine being turned into a static image. Example provisioners include shell scripts, Chef, Puppet, etc.

</details>

By using packer we can define our golden VM image as code so that we can easily build identically configured images on demand so that all your machines are running the same image and can also be easily updated to a new image when needed.

## Create a Proxmox user for Packer

Packer requires a user account to perform actions on the Proxmox API. The following commands will create a new user account `packer@pve` with restricted permissions.

```bash
pveum useradd packer@pve
pveum passwd packer@pve
# Enter new password: ****************
# Retype new password: ****************
pveum aclmod / -user packer@pve -role PVEAdmin
```

## How to Use

![](https://github.com/TechProber/cloud-estate/blob/master/packer-templates/assets/screenshot.png?raw=true)

### Prerequisites to bake Debian VM

> [!NOTE]
> Baking VM tempalte based on cloudimg is NOT a straightforward process, we need to first bake a `base-cloudimg-vm-template` as a foundation image to add customization on top of it. The full automation is achieved with Ansible, see [bake.yml](./playbooks/bake.yml).

#### Ansible inventory

> [!IMPORTANT]
> You must update the inventory to point to your Proxmox host. See [hosts](./inventory/hosts).

#### Vars

> [!IMPORTANT]
> You must update the `packer-specific` vars in[host.pkvars.hcl](./vars/host.pkvars.hcl) and [debian-12.pkvars.hcl](./vars/debian-12.pkvars.hcl) with your desired settings. For `playbook-related` vars, they are located at [playbooks/group_vars/all.yml](./playbooks/group_vars/all.yml) and [playbooks/vars/](./playbooks/vars/).

#### Playbook

> [!IMPORTANT]
> You must check out the default settings in the [bake.yml](./playbooks/bake.yml) and update any settings that fit your need.

### Bake Proxmox VM image

Export `PM_PASS` (password of the `root` user of your Proxmox server)

```bash
export PM_PASS=
```

Run the playbook

```bash
ansible-playbook -K -i inventory/hosts playbooks/bake.yml --tags=all
```

Also, check out the `build.log` while running the bake playbook

```bash
tail -f build.log
```

## References

- [Creating proxmox templates with packer - Aaron Berry](https://dev.to/aaronktberry/creating-proxmox-templates-with-packer-1b35)
- [Packer - Proxmox ISO Builder](https://developer.hashicorp.com/packer/integrations/hashicorp/proxmox/latest/components/builder/iso)
- [Packer - Ansible Local Provisioner](https://www.packer.io/plugins/provisioners/ansible/ansible-local)
- [Getting started with Packer](https://packer.io/intro/getting-started/install.html)
- [Ubuntu docs for the pre-seed file](https://help.ubuntu.com/16.04/installation-guide/i386/apbs04.html)
- [Proxmox Forum - Using Packer to deploy Ubuntu 20.04 to Proxmox](https://forum.proxmox.com/threads/using-packer-to-deploy-ubuntu-20-04-to-proxmox.104275/)
- [Cloud-Init Documentation](https://cloudinit.readthedocs.io/en/0.7.7/index.html)
- [Cloud-Init Module References](https://cloudinit.readthedocs.io/en/latest/reference/modules.html)
- [Cloud images in Proxmox](https://gist.github.com/chriswayg/b6421dcc69cb3b7e41f2998f1150e1df)
- [justin-p/packer-proxmox-ubuntu2004](https://github.com/justin-p/packer-proxmox-ubuntu2004/blob/main/playbooks/tasks/enable_cloud-init.yml)
- [Packer on CICD](https://www.packer.io/guides/packer-on-cicd/pipelineing-builds)
- [Packer SSH Communicator](https://developer.hashicorp.com/packer/docs/communicators/ssh)
- [Proxmox Ubuntu CloudInit Example](https://github.com/UntouchedWagons/Ubuntu-CloudInit-Docs)
- [Linux VM Templates in Proxmox on EASY MODE using Prebuilt Cloud Init Images!](https://www.apalrd.net/posts/2023/pve_cloud/)
- [Packer with proxmox-clone](https://aaronsplace.co.uk/blog/2021-08-07-packer-proxmox-clone.html)
