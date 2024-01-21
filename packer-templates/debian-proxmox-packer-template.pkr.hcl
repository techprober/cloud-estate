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
variable "proxmox_host" { type = string }
variable "proxmox_node" { type = string }
variable "proxmox_api_user" { type = string }
variable "proxmox_api_password" { type = string }

variable "clone_vm_id" { type = number }
variable "vm_id" { type = number }
variable "vm_name" { type = string }
variable "template_name" { type = string }
variable "template_description" { type = string }

variable "os" { type = string }
variable "cores" { type = string }
variable "cpu_type" { type = string }
variable "memory" { type = string }
variable "sockets" { type = string }

variable "scsi_controller" { type = string }
variable "disk_size" { type = string }
variable "boot" { type = string }

variable "vga_type" { type = string }

variable "cloud_init_storage_pool" { type = string }

variable "network_adapters_model" { type = string }
variable "network_adapters_bridge" { type = string }

variable "ip" { type = string }
variable "gateway" { type = string }
variable "nameserver" { type = string }

variable "ssh_port" { type = number }
variable "ssh_username" { type = string }
variable "ssh_password" { type = string }
variable "ssh_timeout" { type = string }

variable "playbook_file" { type = string }

source "proxmox-clone" "bakery-template" {
  # Proxmox Connection Settings
  proxmox_url              = "https://${var.proxmox_host}:8006/api2/json"
  insecure_skip_tls_verify = true
  node                     = var.proxmox_node
  username                 = var.proxmox_api_user
  password                 = var.proxmox_api_password

  # VM Configurations
  clone_vm_id          = var.clone_vm_id
  vm_id                = var.vm_id
  vm_name              = var.vm_name
  template_name        = var.template_name
  template_description = var.template_description

  os       = var.os
  cores    = var.cores
  cpu_type = var.cpu_type
  memory   = var.memory
  sockets  = var.sockets

  scsi_controller = var.scsi_controller
  boot            = var.boot
  full_clone      = true
  task_timeout    = "30m"

  # Console Configurations
  vga {
    type = var.vga_type
  }

  # Cloud-Init Configurations
  cloud_init              = true
  cloud_init_storage_pool = var.cloud_init_storage_pool

  # Network Configurations
  network_adapters {
    model    = var.network_adapters_model
    bridge   = var.network_adapters_bridge
    firewall = true
  }

  ipconfig {
    ip      = var.ip
    gateway = var.gateway
  }

  nameserver = var.nameserver

  # SSH Configurations
  ssh_port                  = var.ssh_port
  ssh_timeout               = var.ssh_timeout
  ssh_username              = var.ssh_username
  ssh_password              = var.ssh_password
  ssh_clear_authorized_keys = true
}

# Builder
build {
  sources = ["source.proxmox-clone.bakery-template"]

  # Provisioner Configurations

  # Resize disk
  provisioner "shell-local" {
    inline = [
      "ssh root@${var.proxmox_host} qm disk resize ${var.vm_id} scsi0 ${var.disk_size}"
    ]
  }

  # SSH public key
  provisioner "file" {
    source      = "id_rsa.pub"
    destination = "/tmp/"
  }

  provisioner "file" {
    source      = "id_rsa_cloud.pub"
    destination = "/tmp/"
  }

  # Main playbook depends on vm_type
  provisioner "ansible-local" {
    pause_before            = "10s"
    playbook_dir            = "./playbooks"
    playbook_file           = var.playbook_file
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
      "ssh root@${var.proxmox_host} qm set ${var.vm_id} --ipconfig0 ip=dhcp,ip6=dhcp",     # set cloud-init net0 config (dhcp by default)
      "ssh root@${var.proxmox_host} qm set ${var.vm_id} --ciupgrade 1",                    # enable upgrade
      "ssh root@${var.proxmox_host} qm set ${var.vm_id} --tags prod,debian",               # set default tags
    ]
  }
}
