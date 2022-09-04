resource "proxmox_lxc" "container" {
  target_node = var.node_name

  hostname = var.container_hostname
  vmid     = var.container_id

  clone         = var.container_clone_id
  clone_storage = var.container_clone_storage
  full          = true

  start = var.container_start_after_creation
}
