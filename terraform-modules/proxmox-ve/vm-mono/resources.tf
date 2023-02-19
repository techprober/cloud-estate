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
  balloon  = var.vm_mem_balloon
  scsihw   = "virtio-scsi-pci"
  bootdisk = var.vm_boot_disk

  disk {
    slot     = var.vm_boot_disk_slot
    size     = var.vm_boot_disk_size
    type     = var.vm_boot_disk_type
    format   = var.vm_boot_disk_format
    storage  = var.vm_boot_disk_storage_pool
    iothread = 0
  }

  # if you want two NICs, just copy this whole network section and duplicate it
  network {
    model    = var.vm_network_model
    bridge   = var.vm_network_bridge
    tag      = var.vm_network_tag
    firewall = var.vm_network_firewall
  }

  # ignore network changes during the life of the VM
  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0  = "ip=${var.vm_network_ip}/${var.vm_network_netmask},gw=${var.vm_network_gateway}"
  nameserver = var.vm_network_dns

  sshkeys = <<EOF
  ${var.vm_ssh_key}
  EOF
}
