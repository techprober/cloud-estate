terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.12"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://${var.proxmox_host}:8006/api2/json"
  pm_user         = var.pm_user
  pm_tls_insecure = true
}
