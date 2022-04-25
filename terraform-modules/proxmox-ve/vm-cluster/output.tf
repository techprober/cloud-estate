output "master_node(s)_ipv4_static_ip" {
  value = {
    for vm in prxmox_vm_qemu.master-node :
    vm.name => vm.default_ip_address
  }
}

output "worker_node(s)_ipv4_static_ip" {
  value = {
    for vm in prxmox_vm_qemu.worker-node :
    vm.name => vm.default_ip_address
  }
}
