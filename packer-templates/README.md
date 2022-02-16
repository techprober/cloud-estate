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
    <a href="https://t.me/joinchat/7AG3aEQ5I00wY2Q5">
        <img src="https://img.shields.io/badge/join-us%20on%20telegram-gray.svg?longCache=true&logo=telegram&colorB=blue" alt="join-us-on-telegram"/>
    </a>
    <a href="https://github.com/TechProber/cloud-estate">
        <img src="https://img.shields.io/github/last-commit/TechProber/cloud-estate" alt="lastcommit"/>
    </a>
</p>

## Introduction

Maunally creating and managing VM Templates in Proxmox can become a challenge with how time-consuming and manual it can be. This repo will walk you through how you can make this process more standardized and automated with the use of packer to allow you to declare your `Proxmox Templates as Code`.

## Table of Contents

- [What is Packer](#what-is-packer)
- [Create a Proxmox user for Packer](#create-proxmox-user-for-packer)
- [Prepare your packer template](#prepare-your-packer-template)
- [Build your Proxmox Template with Packer](#build-your-proxmox-template-with-packer)

## What is Packer

Packer is a utility that allows you to build virtual machine images so that you can define a golden image as code. Packer can be used to create images for almost all of the big cloud providers such as AWS, GCE, Azure and Digital Ocean, or can be used with locally installed hypervisors such as VMWare, Proxmox and a few others.

To build an image with packer we need to define our image through a template file. The file uses the JSON format and comprises of 3 main sections that are used to define and prepare your image.

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

</br>

By using packer we can define our golden VM image as code so that we can easily build identically configured images on demand so that all your machines are running the same image and can also be easily updated to a new image when needed.

## Create a Proxmox user for Packer

Packer requires a user account to perform actions on the Proxmox API. The following commands will create a new user account `packer@pve` with restricted permissions.

```
$ pveum useradd packer@pve
$ pveum passwd packer@pve
Enter new password: ****************
Retype new password: ****************
$ pveum roleadd Packer -privs "VM.Config.Disk VM.Config.CPU VM.Config.Memory Datastore.AllocateSpace Sys.Modify VM.Config.Options VM.Allocate VM.Audit VM.Console VM.Config.CDROM VM.Config.Network VM.PowerMgmt VM.Config.HWType VM.Monitor"
$ pveum aclmod / -user packer@pve -role Packer
```

## Prepare your packer template

To create the template we will use the [ proxmox builder ](https://packer.io/docs/builders/proxmox.html) which connects through the proxmox `web API` to provision and configure the VM for us and then turn it into a template. To configure our template we will use a [variables file](https://github.com/TechProber/cloud-estate/blob/packer-templates/packer-templates/example.vars.json), to import this variables file we will use the `-var-file` flag to pass in our variables to packer. These variables will be used in our template file with the following syntax within a string like so `passwd/username={{ user 'ssh_username'}}`.

The builder block below will outline the basic properties of our desired proxmox template such as its name, the allocated resources and the devices attached to the VM. To achieve this the [ boot_command ](https://packer.io/docs/builders/qemu.html#boot-configuration) option will be used to boot the OS and tell it to look for the `http/user-data` file to automate the OS installation process. Packer will start a HTTP server from the content of the `http` directory (with the `http_directory` parameter). This will allow `Subiquity` to fetch the cloud-init files remotely.

**Notes:** The live installer `Subiquity` uses more memory than debian-installer. The default value from Packer (512M) is not enough and will lead to weird kernel panic. Use `1G` as a minimum.

The `boot_command` tells cloud-init to start and uses the `nocloud-net` data source to be able to load the `user-data` and `meta-data` files from a remote HTTP endpoint. The additional `autoinstall` parameter will force Subiquity to perform destructive actions without asking confirmation from the user.

```json
{
  ...
  "boot_command": [
    "<esc><wait><esc><wait><f6><wait><esc><wait>",
    "<bs><bs><bs><bs><bs>",
    "autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ",
    "--- <enter>"
  ],
  ...
}
```

Finally, we will use the post processors to run some commands locally. This will make an SSH connection to the PVE host and run some commands manually to set up the virtual devices necessary for [ cloud init ](https://pve.proxmox.com/wiki/Cloud-Init_Support#_preparing_cloud_init_templates). This post-processor is using the [ shell-local ](https://packer.io/docs/provisioners/shell-local.html) post processor to run the commands on the local machine running packer but you could always move this configuration to something like an ansible playbook to make the configuration more readable and portable.

```json
{
  "post-processors": [
    {
      "type": "shell-local",
      "inline": [
        "ssh root@{{user `proxmox_host`}} qm set {{user `vmid`}} --scsihw virtio-scsi-pci",
        "ssh root@{{user `proxmox_host`}} qm set {{user `vmid`}} --ide2 {{user `datastore`}}:cloudinit",
        "ssh root@{{user `proxmox_host`}} qm set {{user `vmid`}} --boot c --bootdisk scsi0",
        "ssh root@{{user `proxmox_host`}} qm set {{user `vmid`}} --ciuser {{ user `ssh_username` }}",
        "ssh root@{{user `proxmox_host`}} qm set {{user `vmid`}} --cipassword {{ user `ssh_password` }}",
        "ssh root@{{user `proxmox_host`}} qm set {{user `vmid`}} --vga std"
      ]
    }
  ]
}
```

## Build your proxmox template with Packer

Now with your configuration complete, you will be ready to build your proxmox template with packer. Run the following command

To generate sha512 password execute the following command:

```bash
# generate through docker-container
docker run -it --rm --entrypoint "openssl" alpine/openssl passwd -6 --salt xyz packer
# generate through openssl-cli
openssl passwd -6 -salt xyz packer
# output: JJbmTJ7EzYLxcBOnv3bwWLhpQZ.WuX8yJkNaLKgtS747n2zUNPh8LZKhQPBnLAptBG429x5r0RJ.ZFIXiIMPw/
```

To create the template execute the following command:

```bash
packer build -var-file vars.json -force ubuntu-2004.json
```

You should see some output for each of the `builders`, `provisioners` and `post-processors`.

```bash
$ packer build -var-file vars.json -force ubuntu-2004.json
proxmox: output will be in this color.

==> proxmox: Creating VM
==> proxmox: Starting VM
==> proxmox: Starting HTTP server on port 8771

...

Build 'proxmox' finished.

==> Builds finished. The artifacts of successful builds are:
--> proxmox: A template was created: 9001
--> proxmox:
```

When the process is complete you should see your template ready in the proxmox interface and ready to be cloned into virtual machines.

![](https://raw.githubusercontent.com/TechProber/cloud-estate/packer-templates/packer-templates/assets/screenshot.png)

## References

- [Creating proxmox templates with packer - Aaron Berry](https://dev.to/aaronktberry/creating-proxmox-templates-with-packer-1b35)
- [Getting started with Packer](https://packer.io/intro/getting-started/install.html)
- [Ubuntu docs for the pre-seed file](https://help.ubuntu.com/16.04/installation-guide/i386/apbs04.html)
- [Proxmox Forum - Using Packer to deploy Ubuntu 20.04 to Proxmox](https://forum.proxmox.com/threads/using-packer-to-deploy-ubuntu-20-04-to-proxmox.104275/)
- [Cloud-init - Documentation](https://cloudinit.readthedocs.io/en/0.7.7/index.html)
- [Cloud images in Proxmox](https://gist.github.com/chriswayg/b6421dcc69cb3b7e41f2998f1150e1df)
- [Packer - Ansible Local Provisioner](https://www.packer.io/plugins/provisioners/ansible/ansible-local)
