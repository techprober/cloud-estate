output "master_nodes" {
  value = {
    for vm in proxmox_vm_qemu.master_node :
    vm.name => {
      vm_id          = vm.vmid
      ipv4_static_ip = vm.default_ipv4_address
      vlan_tag       = vm.network.tag
      cpu_cores      = vm.cores
      memory         = vm.memory
      disk_size      = vm.disk.size
    }
  }
}

output "worker_nodes" {
  value = {
    for vm in proxmox_vm_qemu.worker_node :
    vm.name => {
      vm_id          = vm.vmid
      ipv4_static_ip = vm.default_ipv4_address
      vlan_tag       = vm.network.tag
      cpu_cores      = vm.cores
      memory         = vm.memory
      disk_size      = vm.disk.size
    }
  }
}
