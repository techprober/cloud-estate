terraform {
  source = "git::https://github.com/TechProber/cloud-estate.git//terraform-modules/proxmox-ve/vm-cluster?ref=HEAD"
}

inputs = {
  proxmox_host = "10.178.0.10"
  pm_user      = "terraform-prov"
  node_name    = "pve"

  template_name = "ubuntu-2204-server"

  ### Master Node ###

  master_vm_count   = 1
  master_vm_name    = "master" # vm node will be named master-x, where x is the count.index
  master_vm_id      = 600      # vm id will be assigned as 600 + count.index
  master_vm_os_type = "cloud-init"


  master_vm_cpu_core    = 4
  master_vm_cpu_type    = "host"
  master_vm_mem         = 2048
  master_vm_mem_balloon = 0

  master_vm_boot_disk              = "scsi0"
  master_vm_boot_disk_slot         = 0
  master_vm_boot_disk_size         = "40G"
  master_vm_boot_disk_type         = "scsi"
  master_vm_boot_disk_storage_pool = "sata-pool"

  master_vm_network_model    = "virtio"
  master_vm_network_bridge   = "vmbr2"
  master_vm_network_tag      = -1              # "default is set to -1, which means no vlan-tag is assigned"
  master_vm_network_ip_range = "10.140.40.200" # "static_ipv4_ip = ip_range + count.index"
  master_vm_network_netmask  = 24
  master_vm_network_gateway  = "10.140.40.5"
  master_vm_network_dns      = "10.140.40.5"

  master_vm_ssh_key = ""

  ### Worker Node ###

  worker_vm_count   = 3
  worker_vm_name    = "worker" # vm node will be named worker-x, where x is the count.index
  worker_vm_id      = 610      # vm id will be assigned as 610 + count.index
  worker_vm_os_type = "cloud-init"

  worker_vm_cpu_core    = 4
  worker_vm_cpu_type    = "host"
  worker_vm_mem         = 4096
  worker_vm_mem_balloon = 0

  worker_vm_boot_disk              = "scsi0"
  worker_vm_boot_disk_slot         = 0
  worker_vm_boot_disk_size         = "80G"
  worker_vm_boot_disk_type         = "scsi"
  worker_vm_boot_disk_storage_pool = "sata-pool"

  worker_vm_network_model    = "virtio"
  worker_vm_network_bridge   = "vmbr2"
  worker_vm_network_tag      = -1              # "default is set to -1, which means no vlan-tag is assigned"
  worker_vm_network_ip_range = "10.140.40.210" # "static_ipv4_ip = ip_range + count.index"
  worker_vm_network_netmask  = 24
  worker_vm_network_gateway  = "10.140.40.5"
  worker_vm_network_dns      = "10.140.40.5"

  worker_vm_ssh_key = ""
}
