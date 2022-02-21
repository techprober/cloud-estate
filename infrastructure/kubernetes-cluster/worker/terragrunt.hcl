terraform {
  source = "git::https://github.com/TechProber/cloud-estate.git//terraform-modules/proxmox-ve/vm-cluster?ref=HEAD"
}

inputs = {
  proxmox_host = "10.10.10.10"
  pm_user      = "terraform-prov"
  node_name    = "pve"

  vm_count   = 5
  vm_name    = "k8s-agent"
  vm_id      = 60
  vm_os_type = "cloud-init"

  template_name = "ubuntu-server-20-04-packer-template"

  vm_cpu_core    = 4
  vm_cpu_type    = "host"
  vm_mem         = 4096
  vm_mem_balloon = 0

  vm_boot_disk              = "scsi0"
  vm_boot_disk_slot         = 0
  vm_boot_disk_size         = "50G"
  vm_boot_disk_type         = "scsi"
  vm_boot_disk_storage_pool = "local-lvm"

  vm_network_model    = "virtio"
  vm_network_bridge   = "vmbr0"
  vm_network_ip_range = "10.10.10.21"
  vm_network_dns      = "8.8.8.8"
  vm_network_gateway  = "10.10.10.7"

  vm_ssh_key = ""
}
