terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.9"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://${var.proxmox_host}:8006/api2/json"
  pm_user         = var.pm_user
  pm_tls_insecure = true
}

resource "proxmox_lxc" "container" {
  target_node = var.node_name

  hostname = var.container_hostname
  vmid     = var.container_id

  clone         = var.container_clone_id
  clone_storage = var.container_clone_storage
  full          = true

  start = var.container_start_after_creation
}
