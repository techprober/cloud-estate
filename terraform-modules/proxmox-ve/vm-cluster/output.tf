output "master_nodes" {
  value = {
    for vm in proxmox_vm_qemu.master_node :
    vm.name => {
      vm_id          = vm.vmid
      ipv4_static_ip = vm.default_ipv4_address
      vlan_tag       = { for k in vm.network : vlan_tag => k.vlan_tag }
      cpu_cores      = vm.cores
      memory         = vm.memory
      disk_size      = { for k in vm.disk : disk_size => k.size }
    }
  }
}

output "worker_nodes" {
  value = {
    for vm in proxmox_vm_qemu.worker_node :
    vm.name => {
      vm_id          = vm.vmid
      ipv4_static_ip = vm.default_ipv4_address
      vlan_tag       = { for k in vm.network : vlan_tag => k.vlan_tag }
      cpu_cores      = vm.cores
      memory         = vm.memory
      disk_size      = { for k in vm.disk : disk_size => k.size }
    }
  }
}
