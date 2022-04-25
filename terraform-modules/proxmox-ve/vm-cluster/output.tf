output "master_nodes" {
  value = {
    for vm in proxmox_vm_qemu.master_node :
    vm.name => {
      vm_id     = vm.vmid
      template  = vm.clone
      cpu_cores = vm.cores
      memory    = vm.memory
      bootdisk  = vm.bootdisk
      network = { for k in vm.network : attr => {
        vlan_tag       = k.tag
        model          = k.model
        bridge         = k.bridge
        ipv4_static_ip = vm.default_ipv4_address
      } }
      disk = { for k in vm.disk : attr => {
        slot    = k.slot
        size    = k.size
        type    = k.type
        format  = k.format
        storage = k.storage
      } }
    }
  }
}

output "worker_nodes" {
  value = {
    for vm in proxmox_vm_qemu.worker_node :
    vm.name => {
      vm_id     = vm.vmid
      template  = vm.clone
      cpu_cores = vm.cores
      memory    = vm.memory
      bootdisk  = vm.bootdisk
      network = { for k in vm.network : k => {
        vlan_tag       = k.tag
        model          = k.model
        bridge         = k.bridge
        ipv4_static_ip = vm.default_ipv4_address
      } }
      disk = { for k in vm.disk : k => {
        slot    = k.slot
        size    = k.size
        type    = k.type
        format  = k.format
        storage = k.storage
      } }
    }
  }
}
