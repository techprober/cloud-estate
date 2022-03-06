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
}

resource "proxmox_vm_qemu" "vm" {
  count       = var.vm_count
  name        = "${var.vm_name}-0${count.index + 1}"
  vmid        = "${var.vm_id}${count.index + 1}"
  target_node = var.node_name

  clone = var.template_name

  agent    = 1
  os_type  = var.vm_os_type
  cores    = var.vm_cpu_core
  sockets  = 1
  cpu      = var.vm_cpu_type
  memory   = var.vm_mem
  balloon  = var.vm_mem_balloon
  scsihw   = "virtio-scsi-pci"
  bootdisk = var.vm_boot_disk

  disk {
    slot     = var.vm_boot_disk_slot
    size     = var.vm_boot_disk_size
    type     = var.vm_boot_disk_type
    format   = var.vm_boot_disk_format
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

  ipconfig0  = "ip=${var.vm_network_ip_range}${count.index + 1}/${var.vm_network_netmask},gw=${var.vm_network_gateway}"
  nameserver = var.vm_network_dns

  sshkeys = <<EOF
  ${var.vm_ssh_key}
  EOF
}
