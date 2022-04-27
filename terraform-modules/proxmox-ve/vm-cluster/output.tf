output "master_nodes" {
  value = {
    for vm in proxmox_vm_qemu.master_node :
    vm.name => {
      vm_id    = vm.vmid
      template = vm.clone
      bootdisk = vm.bootdisk
      network = { for k in vm.network : k.bridge => {
        vlan_tag       = k.tag
        model          = k.model
        bridge         = k.bridge
        static_ipv4_ip = vm.default_ipv4_address
      } }
    }
  }
}

output "worker_nodes" {
  value = {
    for vm in proxmox_vm_qemu.worker_node :
    vm.name => {
      vm_id    = vm.vmid
      template = vm.clone
      bootdisk = vm.bootdisk
      network = { for k in vm.network : k.bridge => {
        vlan_tag       = k.tag
        model          = k.model
        bridge         = k.bridge
        static_ipv4_ip = vm.default_ipv4_address
      } }
    }
  }
}
