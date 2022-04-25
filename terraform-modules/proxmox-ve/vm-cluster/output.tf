output "master_ipv4_static_ip" {
  value = {
    for vm in proxmox_vm_qemu.master_node :
    vm.name => vm.default_ipv4_address
  }
}

output "worker_ipv4_static_ip" {
  value = {
    for vm in proxmox_vm_qemu.worker_node :
    vm.name => vm.default_ipv4_address
  }
}
