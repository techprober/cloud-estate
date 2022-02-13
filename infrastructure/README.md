# Infrastructure

Use terragrunt to explictly manage the state of Infrastructure

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

#### Before-Deployment

- Please ensure you have the basic undestanding of how Terraform works in terms of managing the state of Infrastructure. Terragrunt is just an extension of Terraform to allow the end-user to manage multiple `stage` against the same resource module.

- Please take a look at the target module definition before doing the actual deployment
- Please always run the `plan` command to see how the state of the resources will change before running the `apply` command

## Deployment

#### Creating the Proxmox User and role for Terraform

Log into the Proxmox cluster or host using ssh (or mimic these in the GUI) then:

- Create the user `terraform-prov@pve`
- Add the `Administrator` role to the `terraform-prov` user

```bash
# Create the user
pveum user add terraform-prov@pve --password $PASSWORDG

# Assign the user the correct role
pveum aclmod / -user terraform-prov@pve -role Administrator
```

#### Creating the connection via Username and API token | PASSWORD

```bash
export PM_API_TOKEN_ID="[user]@pve![token_id]"
export PM_API_TOKEN_SECRET="token"

# alternative: use PM_PASSWORD
export PM_USER="terraform-prov@pve"
export PM_PASSWORD="password"
```

#### Navigate to the resources sub-dir

**Notes:** ONLY applying the state against the target `sub-dir` can secure not to break any other resources during the execution

```
# sub-dir tree
.
├── kubernetes-cluster
│   ├── prod
│   │   └── empty
│   └── staging
│       └── empty
├── proxmox-lxc
│   └── empty
├── proxmox-vm
│   └── ubuntu-server-test
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
