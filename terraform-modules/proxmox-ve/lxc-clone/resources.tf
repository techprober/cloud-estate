terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.6"
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

  vmid     = var.container_id
  clone    = var.container_clone_id
  hostname = var.container_hostname

  clone_storage = var.container_clone_storage

  start = var.container_start_after_creation
  full  = true
}
