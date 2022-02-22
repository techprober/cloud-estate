terraform {
  source = "git::https://github.com/TechProber/cloud-estate.git//terraform-modules/proxmox-ve/lxc-mono?ref=HEAD"
}

inputs = {
  proxmox_host = "192.168.1.10"
  pm_user      = "root@pam"
  node_name    = "pve-01"

  container_hostname             = ""
  container_password             = ""
  container_id                   = 9999
  container_unprivileged         = true
  container_start_after_creation = true

  container_os_template = "local-lvm:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"

  container_cpu_cores = 4
  container_memory    = 1024
  container_swap      = 512

  container_boot_disk_size    = "10G"
  container_boot_storate_pool = "local-lvm"

  container_network_interface = "eth0"
  container_network_bridge    = "vmbr0"
  container_network_ip        = "192.168.1.1/24"
  container_network_gateway   = "192.168.1.1"
  container_network_dns       = "8.8.8.8"

  ssh_public_keys = ""
}
