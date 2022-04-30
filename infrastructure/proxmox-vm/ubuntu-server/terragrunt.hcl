terraform {
  source = "git::https://github.com/TechProber/cloud-estate.git//terraform-modules/proxmox-ve/vm-mono?ref=HEAD"
}

inputs = {
  proxmox_host = "10.10.10.10"
  pm_user      = "terraform-prov"
  node_name    = "pve"

  vm_name    = "ubuntu-server-2204"
  vm_id      = 201
  vm_os_type = "cloud-init"

  template_name = "ubuntu-2204-cloudinit-template"

  vm_cpu_core    = 2
  vm_cpu_type    = "host"
  vm_mem         = 1024
  vm_mem_balloon = 0

  vm_boot_disk              = "scsi0"
  vm_boot_disk_slot         = 0
  vm_boot_disk_size         = "10G"
  vm_boot_disk_type         = "scsi"
  vm_boot_disk_storage_pool = "pool-cache"

  vm_network_model   = "virtio"
  vm_network_bridge  = "vmbr0"
  vm_network_tag     = -1 # novlan tag by default
  vm_network_ip      = ""
  vm_network_netmask = 24
  vm_network_gateway = ""
  vm_network_dns     = ""

  vm_ssh_key = ""

}
