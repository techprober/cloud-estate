<h1 align="center">Infrastructure as Code</h1>
<p align="center">
    <em>Use terragrunt to explictly manage the state of Infrastructure</em>
</p>
<p align="center">
    <a href="https://t.me/pve_zh">
        <img src="https://img.shields.io/badge/join-us%20on%20proxmox%20group-gray.svg?longCache=true&logo=proxmox&colorB=orange" alt="join-us-on-proxmox-group"/>
    </a>
    <a href="https://registry.terraform.io/providers/Telmate/proxmox/latest/docs">
        <img src="https://img.shields.io/badge/provider-telmate/proxmox-gray.svg?longCache=true&logo=terraform&colorB=purple" alt="terraform-proxmox-provider"/>
    </a>
    <a href="https://github.com/TechProber/cloud-estate">
        <img src="https://img.shields.io/github/last-commit/TechProber/cloud-estate" alt="lastcommit"/>
    </a>
</p>

## Table of Contents

- [Pre-requisites](#pre-requisites)
  - [Install Terragrunt](#install-terragrunt)
  - [Before Deployment](#before-deployment)
- [Deployment](#deployment)
  - [Create the Proxmox User and Role for Terraform](#create-the-proxmox-user-and-role-for-terraform)
  - [Create the connection via Username and API token | PASSWORD](#create-the-connection-via-username-and-api-token-password)
  - [Navigate to the resources sub-dir](#navigate-to-the-resources-sub-dir)
  - [Version Control](#version-control)
  - [Init (Install Plugins)](#init-install-plugins)
  - [Plan (Dry Run)](#plan-dry-run)
  - [Apply](#apply)
  - [Destroy](#destroy)
- [References](#references)

## Pre-requisites

#### Install Terragrunt

[ Terragrunt ](https://terragrunt.gruntwork.io/) is a thin wrapper that provides extra tools for keeping your configurations DRY, working with multiple Terraform modules, and managing remote state

```bash
# Archlinux
sudo pacman -S terragrunt

# Homebrew
brew install terragrunt
```

More installation options can be found in https://terragrunt.gruntwork.io/docs/getting-started/install/#install-terragrunt

#### Before Deployment

- Please ensure you have the basic undestanding of how Terraform works in terms of managing the state of Infrastructure. Terragrunt is just an extension of Terraform to allow the end-user to manage multiple `stage` against the same resource module.

- Please take a look at the target module definition before doing the actual deployment
- Please always run the `plan` command to see how the state of the resources will change before running the `apply` command

## Deployment

#### Creating the Proxmox User and role for Terraform

Log into the Proxmox cluster or host using ssh (or mimic these in the GUI) then:

- Create the user `terraform-prov@pve`
- Add the `TerraformProv` role to the `terraform-prov` user

```bash
# Create the user
pveum user add terraform-prov@pve --password $PASSWORD

# Assign the user the correct role
pveum aclmod / -user terraform-prov@pve -role Administrator
```

#### Create the connection via Username and API token | PASSWORD

Create a dedicated API Token from web console (Datacenter >> Permissions >> API Tokens >> Add)

```yaml
user_name: terraform-prov
token_name: mytoken
privilege_separation: No
```

![](https://nrmjjlvckvsb.compat.objectstorage.ap-tokyo-1.oraclecloud.com/picgo/2022/09-30-9913007804a3fea25f2fb87c5b211511.png)

Export secrets as environment variables

```bash
export PM_API_TOKEN_ID="[user]@pve![token_id]"
export PM_API_TOKEN_SECRET="token"

# alternative: use PM_PASS
export PM_USER="terraform-prov@pve"
export PM_PASS="password"
```

#### Navigate to the resources sub-dir

**Notes:** ONLY applying the state against the target `sub-dir` can secure not to break any other resources during the execution

```
# sub-dir tree
.
├── kubernetes-cluster
│   └── terragrunt.hcl
├── proxmox-lxc
│   ├── privileged
│   │   └── terragrunt.hcl
│   └── unprivileged
│       └── terragrunt.hcl
├── proxmox-vm
│   └── ubuntu-server
│       └── terragrunt.hcl
└── README.md
```

```bash
cd <resource-sub-dir>
# e.g cd proxmox-vm/ubuntu-server-test
```

#### Version Control

For each `terragrunt.hcl` you may add `?ref=[...]` to pin to a specific commit SHA against the resource module

```terraform
# e.g
terraform {
  source = "git::https://github.com/TechProber/cloud-estate.git//terraform-modules/proxmox-ve/vm-mono?ref=HEAD"
}
```

#### Init (Install Plugins)

```bash
terragrunt init
```

#### Plan (Dry Run)

```bash
terragrunt run-all plan
```

#### Apply

```bash
terragrunt run-all apply
```

#### Destroy

```bash
terragrunt run-all destroy
```

## References

- [Terraform Docs - Proxmox Provider](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs)
- [Terragrunt - Quick Start](https://terragrunt.gruntwork.io/docs/getting-started/quick-start/#example)
- [How to create a Proxmox Ubuntu cloud-init image](https://austinsnerdythings.com/2021/08/30/how-to-create-a-proxmox-ubuntu-cloud-init-image/)
- [How to deploy VMs in Proxmox with Terraform](https://austinsnerdythings.com/2021/09/01/how-to-deploy-vms-in-proxmox-with-terraform/)
- [Memory Usage not same as in VM](https://forum.proxmox.com/threads/memory-usage-not-same-as-in-vm.82640/)
- [Rootless Docker inside unprivileged LXC container](https://forum.proxmox.com/threads/rootless-docker-inside-unprivileged-lxc-container.91146/)
