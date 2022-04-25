output "ipv4_static_ip" {
  value = "${join(".", concat(slice(split(".", var.master_vm_network_ip_range), 0, 3), formatlist(local.master_last_ipv4_octet + count.index + 1)))}/${var.master_vm_network_netmask}"
}
