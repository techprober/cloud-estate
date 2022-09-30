resource "proxmox_lxc" "container" {
  target_node = var.node_name

  hostname = var.container_hostname
  vmid     = var.container_id

  ostemplate   = var.container_os_template
  password     = var.container_password
  unprivileged = false
  start        = var.container_start_after_creation

  cores  = var.container_cpu_cores
  memory = var.container_memory
  swap   = var.container_swap

  features {
    fuse    = true
    nesting = true
    mount   = "cifs;nfs"
  }

  rootfs {
    size    = var.container_boot_disk_size
    storage = var.container_boot_disk_storage_pool
  }

  # if you want two NICs, just copy this whole network section and duplicate it
  network {
    name     = var.container_network_interface
    bridge   = var.container_network_bridge
    ip       = var.container_network_ip
    gw       = var.container_network_gateway
    tag      = var.container_network_tag
    firewall = var.container_network_firewall
  }

  nameserver = var.container_network_dns

  ssh_public_keys = <<EOF
  ${var.ssh_public_keys}
  EOF
}
