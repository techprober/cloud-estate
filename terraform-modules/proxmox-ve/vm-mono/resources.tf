terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.5"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://${var.proxmox_host}:8006/api2/json"
  pm_user         = "${var.pm_user}@pve"
  pm_tls_insecure = true

  # api token id is in the form of: <username>@pam!<tokenId>
  #pm_api_token_id = "terraform@pam!terraform-token"

  # this is the full secret wrapped in quotes. don't worry, I've already deleted this from my proxmox cluster by the time you read this post
  #pm_api_token_secret = "4e1e00f2-c353-4b46-a8a6-3cee38c3241e"
}

resource "proxmox_vm_qemu" "vm" {
  name        = var.vm_name
  vmid        = var.vm_id
  target_node = var.node_name

  clone = var.template_name

  agent    = 1
  os_type  = var.vm_os_type
  cores    = var.vm_cpu_core
  sockets  = 1
  cpu      = var.vm_cpu_type
  memory   = var.vm_mem
  scsihw   = "virtio-scsi-pci"
  bootdisk = var.vm_boot_disk

  disk {
    slot     = var.vm_boot_disk_slot
    size     = var.vm_boot_disk_size
    type     = var.vm_boot_disk_type
    storage  = var.vm_boot_disk_storage_pool
    iothread = 1
  }

  # if you want two NICs, just copy this whole network section and duplicate it
  network {
    model  = var.vm_network_model
    bridge = var.vm_network_bridge
  }

  # ignore network changes during the life of the VM
  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = "ip=${var.vm_network_ip}/24,gw=${var.vm_network_gateway}"

  sshkeys = <<EOF
  ${var.vm_ssh_key}
  EOF
}
