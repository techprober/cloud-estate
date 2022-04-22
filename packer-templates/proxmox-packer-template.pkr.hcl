# Variable Definitions
variable "proxmox_host" {
  type = string
}

variable "proxmox_api_user" {
  type = string
}

variable "proxmox_api_password" {
  type = string
}

variable "template_name" {
  type = string
}

variable "vm_id" {
  type = string
}

variable "proxmox_node_name" {
  type = string
}

variable "cores" {
  type = string
}

variable "sockets" {
  type = string
}

variable "memory" {
  type = string
}

variable "bridge" {
  type = string
}

variable "disk_type" {
  type = string
}

variable "disk_format" {
  type = string
}

variable "disk_size" {
  type = string
}

variable "datastore" {
  type = string
}

variable "datastore_type" {
  type = string
}

variable "disk_cache_mode" {
  type = string
}

variable "cloud_init_storage_pool" {
  type = string
}

variable "ssh_timeout" {
  type = string
}

variable "ssh_username" {
  type = string
}

variable "ssh_password" {
  type = string
}

variable "iso" {
  type = string
}

variable "template_description" {
  type = string
}

variable "http_directory" {
  type = string
}

variable "http_bind_address" {
  type = string
}

variable "boot_command" {
  type = list(string)
}

variable "playbook_file" {
  type = string
}

source "proxmox" "backey-template" {

  # Proxmox Connection Settings
  proxmox_url              = "https://${var.proxmox_host}:8006/api2/json"
  insecure_skip_tls_verify = true
  username                 = var.proxmox_api_user
  password                 = var.proxmox_api_password

  # VM Configurations
  vm_name    = var.template_name
  vm_id      = var.vm_id
  node       = var.proxmox_node_name
  cores      = var.cores
  sockets    = var.sockets
  memory     = var.memory
  os         = l26
  qemu_agent = true

  network_adapters = [
    {
      "model" : "virtio",
      "bridge" : "${var.bridge}",
      "firewall" : true
    }
  ]

  disks = [
    {
      type              = "${var.disk_type}",
      format            = "${var.disk_format}",
      disk_size         = "${var.disk_size}",
      storage_pool      = "${var.datastore}",
      storage_pool_type = "${var.datastore_type}",
      cache_mode        = "${var.disk_cache_mode}"
    }
  ]

  # Cloud-init Configurations
  cloud_init              = true
  cloud_init_storage_pool = var.cloud_init_storage_pool

  # SSH Configurations
  ssh_port     = 22
  ssh_timeout  = var.ssh_timeout
  ssh_username = var.ssh_username
  ssh_password = var.ssh_password

  # Template Configurations
  iso_file             = var.iso
  unmount_iso          = true
  template_name        = var.template_name
  template_description = var.template_description
  http_directory       = var.http_directory
  http_bind_address    = var.http_bind_address
  http_port_min        = 8802
  http_port_max        = 8802

  # Boot Configurations
  boot_wait    = "5s"
  boot_command = var.boot_command
}

build {
  sources = ["source.proxmox.backery-template"]

  # Provisioner Configurations - Use ansible-playbooks to handle all the automation
  provisioner "ansible-local" {
    pause_before  = "5s"
    playbook_dir  = "./playbooks"
    playbook_file = var.playbook_file
  }

  # Convert to proxmox vm template
  post-processors "shell" {
    inline = [
      "ssh root@{{user `proxmox_host`}} qm set {{user `vm_id`}} --boot c --bootdisk scsi0",
      "ssh root@{{user `proxmox_host`}} qm set {{user `vm_id`}} --ciuser {{ user `ssh_username` }}",
      "ssh root@{{user `proxmox_host`}} qm set {{user `vm_id`}} --cipassword {{ user `ssh_password` }}",
      "ssh root@{{user `proxmox_host`}} qm set {{user `vm_id`}} --serial0 socket --vga serial0"
    ]
  }
}
