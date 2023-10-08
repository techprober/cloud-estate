packer {
  required_plugins {
    proxmox = {
      version = ">= 1.1.5"
      source  = "github.com/hashicorp/proxmox"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
  }
}

# Variable Definitions
variable "proxmox_host" {
  type    = string
  default = "10.178.0.12"
}
# variable "proxmox_api_user" { type = string }
# variable "proxmox_api_password" { type = string }

variable "proxmox_api_username" {
  type    = string
  default = "packer@pve"
}

variable "proxmox_api_password" {
  type    = string
  default = env("PM_PASS")
}

variable "clone_vm_id" {
  type    = number
  default = 900
}

variable "vm_id" {
  type    = number
  default = 9001
}

variable "ssh_username" {
  type    = string
  default = "packer"
}

variable "ssh_password" {
  type    = string
  default = "packer"
}

source "proxmox-clone" "debian" {
  proxmox_url              = "https://pve03.homelab.sh:8006/api2/json"
  insecure_skip_tls_verify = true
  clone_vm_id              = var.clone_vm_id
  vm_name                  = "prod-debian-12-server-packer-template"
  vm_id                    = var.vm_id
  node                     = "pve-03"
  cores                    = 4
  cpu_type                 = "host"
  os                       = "l26"
  memory                   = 2048
  sockets                  = 1
  template_description     = "image made from cloud-init image"
  template_name            = "prod-debian-12-server-packer-template"
  scsi_controller          = "virtio-scsi-single"
  boot                     = "order=scsi0"
  full_clone               = true
  task_timeout             = "30m"

  # Console Configurations
  vga {
    type = "std"
  }

  # Cloud-Init Configurations
  cloud_init              = true
  cloud_init_storage_pool = "local-zfs"
  username                = var.proxmox_api_username
  password                = var.proxmox_api_password

  network_adapters {
    model    = "virtio"
    bridge   = "vmbr2"
    firewall = true
  }

  ipconfig {
    ip      = "10.178.0.211/24"
    gateway = "10.178.0.4"
  }

  nameserver = "10.178.0.4"

  # SSH Configurations
  ssh_port                  = 22
  ssh_timeout               = "20m"
  ssh_username              = "packer"
  ssh_password              = "packer"
  ssh_clear_authorized_keys = true
}

build {
  sources = ["source.proxmox-clone.debian"]

  # Provisioner Configurations

  provisioner "shell-local" {
    inline = [
      "ssh root@${var.proxmox_host} qm disk resize ${var.vm_id} scsi0 20G"
    ]
  }

  # SSH public key
  provisioner "file" {
    source      = "./id_rsa.pub"
    destination = "/tmp/id_rsa.pub"
  }

  # Main playbook depends of vm_type
  provisioner "ansible-local" {
    pause_before            = "5s"
    playbook_dir            = "./playbooks"
    playbook_file           = "./playbooks/debian-12-server.yml"
    role_paths              = ["../ansible-playbooks/roles/"]
    clean_staging_directory = true
    extra_arguments = [
      "--extra-vars", "\"ansible_user=packer ansible_become_password=packer\""
    ]
  }

  # Add default cloud-init configuration
  post-processor "shell-local" {
    inline = [
      "ssh root@${var.proxmox_host} qm set ${var.vm_id} --ciuser ${var.ssh_username}",     # set cloud-init default user
      "ssh root@${var.proxmox_host} qm set ${var.vm_id} --cipassword ${var.ssh_password}", # set cloud-init default password
      "ssh root@${var.proxmox_host} qm set ${var.vm_id} --ipconfig0 ip=dhcp"               # set cloud-init net0 config (dhcp by default)
    ]
  }
}
