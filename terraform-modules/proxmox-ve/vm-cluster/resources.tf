locals {
  master_last_ipv4_octet = element(split(".", var.master_vm_network_ip_range), 3)
  worker_last_ipv4_octet = element(split(".", var.worker_vm_network_ip_range), 3)
}

resource "proxmox_vm_qemu" "master_node" {

  target_node = var.node_name

  count = var.master_vm_count

  name = "${var.master_vm_name}-${count.index + 1}"
  vmid = var.master_vm_id + count.index + 1

  clone = var.template_name

  agent    = 1
  os_type  = var.master_vm_os_type
  cores    = var.master_vm_cpu_core
  sockets  = 1
  cpu      = var.master_vm_cpu_type
  memory   = var.master_vm_mem
  balloon  = var.master_vm_mem_balloon
  scsihw   = "virtio-scsi-pci"
  bootdisk = var.master_vm_boot_disk

  disk {
    slot     = var.master_vm_boot_disk_slot
    size     = var.master_vm_boot_disk_size
    type     = var.master_vm_boot_disk_type
    format   = var.master_vm_boot_disk_format
    storage  = var.master_vm_boot_disk_storage_pool
    iothread = 0
  }

  # if you want two NICs, just copy this whole network section and duplicate it
  network {
    model    = var.master_vm_network_model
    bridge   = var.master_vm_network_bridge
    tag      = var.master_vm_network_tag
    firewall = var.master_vm_network_firewall
  }

  # ignore network changes during the life of the VM
  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0  = "ip=${join(".", concat(slice(split(".", var.master_vm_network_ip_range), 0, 3), formatlist(local.master_last_ipv4_octet + count.index + 1)))}/${var.master_vm_network_netmask},gw=${var.master_vm_network_gateway}"
  nameserver = var.master_vm_network_dns

  sshkeys = <<EOF
  ${var.master_vm_ssh_key}
  EOF
}

resource "proxmox_vm_qemu" "worker_node" {

  depends_on = [
    proxmox_vm_qemu.master_node
  ]

  target_node = var.node_name

  count = var.worker_vm_count
  name  = "${var.worker_vm_name}-${count.index + 1}"
  vmid  = var.worker_vm_id + count.index + 1

  clone = var.template_name

  agent    = 1
  os_type  = var.worker_vm_os_type
  cores    = var.worker_vm_cpu_core
  sockets  = 1
  cpu      = var.worker_vm_cpu_type
  memory   = var.worker_vm_mem
  balloon  = var.worker_vm_mem_balloon
  scsihw   = "virtio-scsi-pci"
  bootdisk = var.worker_vm_boot_disk

  disk {
    slot     = var.worker_vm_boot_disk_slot
    size     = var.worker_vm_boot_disk_size
    type     = var.worker_vm_boot_disk_type
    format   = var.worker_vm_boot_disk_format
    storage  = var.worker_vm_boot_disk_storage_pool
    iothread = 0
  }

  # if you want two NICs, just copy this whole network section and duplicate it
  network {
    model    = var.worker_vm_network_model
    bridge   = var.worker_vm_network_bridge
    tag      = var.worker_vm_network_tag
    firewall = var.worker_vm_network_firewall
  }

  # ignore network changes during the life of the VM
  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0  = "ip=${join(".", concat(slice(split(".", var.worker_vm_network_ip_range), 0, 3), formatlist(local.worker_last_ipv4_octet + count.index + 1)))}/${var.worker_vm_network_netmask},gw=${var.worker_vm_network_gateway}"
  nameserver = var.worker_vm_network_dns

  sshkeys = <<EOF
  ${var.worker_vm_ssh_key}
  EOF
}
