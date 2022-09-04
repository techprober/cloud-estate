## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 2.9.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 2.9.11 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_vm_qemu.master_node](https://registry.terraform.io/providers/telmate/proxmox/2.9.11/docs/resources/vm_qemu) | resource |
| [proxmox_vm_qemu.worker_node](https://registry.terraform.io/providers/telmate/proxmox/2.9.11/docs/resources/vm_qemu) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_master_vm_boot_disk"></a> [master\_vm\_boot\_disk](#input\_master\_vm\_boot\_disk) | default vm boot disk | `string` | `"scsi0"` | no |
| <a name="input_master_vm_boot_disk_format"></a> [master\_vm\_boot\_disk\_format](#input\_master\_vm\_boot\_disk\_format) | default vm boot disk format | `string` | `"raw"` | no |
| <a name="input_master_vm_boot_disk_size"></a> [master\_vm\_boot\_disk\_size](#input\_master\_vm\_boot\_disk\_size) | default vm boot disk capacity | `string` | `"10G"` | no |
| <a name="input_master_vm_boot_disk_slot"></a> [master\_vm\_boot\_disk\_slot](#input\_master\_vm\_boot\_disk\_slot) | default vm boot disk id | `number` | `0` | no |
| <a name="input_master_vm_boot_disk_storage_pool"></a> [master\_vm\_boot\_disk\_storage\_pool](#input\_master\_vm\_boot\_disk\_storage\_pool) | default vm boot disk storage pool | `string` | `"local-lvm"` | no |
| <a name="input_master_vm_boot_disk_type"></a> [master\_vm\_boot\_disk\_type](#input\_master\_vm\_boot\_disk\_type) | default vm boot disk type | `string` | `"scsi"` | no |
| <a name="input_master_vm_count"></a> [master\_vm\_count](#input\_master\_vm\_count) | number of master-node to be deployed | `number` | `1` | no |
| <a name="input_master_vm_cpu_core"></a> [master\_vm\_cpu\_core](#input\_master\_vm\_cpu\_core) | total cpu cores | `number` | `2` | no |
| <a name="input_master_vm_cpu_type"></a> [master\_vm\_cpu\_type](#input\_master\_vm\_cpu\_type) | cpu type | `string` | `"host"` | no |
| <a name="input_master_vm_id"></a> [master\_vm\_id](#input\_master\_vm\_id) | master node vm id (e.g 20x, where x is vm\_count) | `number` | `20` | no |
| <a name="input_master_vm_mem"></a> [master\_vm\_mem](#input\_master\_vm\_mem) | total memory | `number` | `2048` | no |
| <a name="input_master_vm_mem_balloon"></a> [master\_vm\_mem\_balloon](#input\_master\_vm\_mem\_balloon) | whether to enable balloon service on memory allocation, default set to disable | `number` | `0` | no |
| <a name="input_master_vm_name"></a> [master\_vm\_name](#input\_master\_vm\_name) | master node name | `string` | `"ubuntu-server"` | no |
| <a name="input_master_vm_network_bridge"></a> [master\_vm\_network\_bridge](#input\_master\_vm\_network\_bridge) | default vm network nic bridge | `string` | `"vmbr0"` | no |
| <a name="input_master_vm_network_dns"></a> [master\_vm\_network\_dns](#input\_master\_vm\_network\_dns) | default vm domain name server (DNS) ip e.g 8.8.8.8 | `string` | `"8.8.8.8"` | no |
| <a name="input_master_vm_network_gateway"></a> [master\_vm\_network\_gateway](#input\_master\_vm\_network\_gateway) | default vm network gateway | `string` | `"192.168.1.1"` | no |
| <a name="input_master_vm_network_ip_range"></a> [master\_vm\_network\_ip\_range](#input\_master\_vm\_network\_ip\_range) | default vm network ip range e.g 192.168.10x | `string` | `"192.168.10"` | no |
| <a name="input_master_vm_network_model"></a> [master\_vm\_network\_model](#input\_master\_vm\_network\_model) | default vm network nic model | `string` | `"virtio"` | no |
| <a name="input_master_vm_network_netmask"></a> [master\_vm\_network\_netmask](#input\_master\_vm\_network\_netmask) | default vm network mask e.g 24(255.255.255.0) | `string` | `24` | no |
| <a name="input_master_vm_network_tag"></a> [master\_vm\_network\_tag](#input\_master\_vm\_network\_tag) | the VLAN tag to apply to packets on this device. By default -1 disables VLAN tagging. | `number` | `-1` | no |
| <a name="input_master_vm_os_type"></a> [master\_vm\_os\_type](#input\_master\_vm\_os\_type) | master node os type | `string` | `"cloud-init"` | no |
| <a name="input_master_vm_ssh_key"></a> [master\_vm\_ssh\_key](#input\_master\_vm\_ssh\_key) | default ssh\_key to authenticate | `string` | `""` | no |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | name of the proxmox server node | `string` | `"pve"` | no |
| <a name="input_pm_user"></a> [pm\_user](#input\_pm\_user) | pm user that proxmox uses to interact with the remote server | `string` | `"terraform-prov"` | no |
| <a name="input_proxmox_host"></a> [proxmox\_host](#input\_proxmox\_host) | host ip of the proxmox server | `string` | `"10.10.10.10"` | no |
| <a name="input_template_name"></a> [template\_name](#input\_template\_name) | template name used to deploy the vm | `string` | `"ubuntu-2204-cloudinit-template"` | no |
| <a name="input_worker_vm_boot_disk"></a> [worker\_vm\_boot\_disk](#input\_worker\_vm\_boot\_disk) | default vm boot disk | `string` | `"scsi0"` | no |
| <a name="input_worker_vm_boot_disk_format"></a> [worker\_vm\_boot\_disk\_format](#input\_worker\_vm\_boot\_disk\_format) | default vm boot disk format | `string` | `"raw"` | no |
| <a name="input_worker_vm_boot_disk_size"></a> [worker\_vm\_boot\_disk\_size](#input\_worker\_vm\_boot\_disk\_size) | default vm boot disk capacity | `string` | `"10G"` | no |
| <a name="input_worker_vm_boot_disk_slot"></a> [worker\_vm\_boot\_disk\_slot](#input\_worker\_vm\_boot\_disk\_slot) | default vm boot disk id | `number` | `0` | no |
| <a name="input_worker_vm_boot_disk_storage_pool"></a> [worker\_vm\_boot\_disk\_storage\_pool](#input\_worker\_vm\_boot\_disk\_storage\_pool) | default vm boot disk storage pool | `string` | `"local-lvm"` | no |
| <a name="input_worker_vm_boot_disk_type"></a> [worker\_vm\_boot\_disk\_type](#input\_worker\_vm\_boot\_disk\_type) | default vm boot disk type | `string` | `"scsi"` | no |
| <a name="input_worker_vm_count"></a> [worker\_vm\_count](#input\_worker\_vm\_count) | number of master-node to be deployed | `number` | `1` | no |
| <a name="input_worker_vm_cpu_core"></a> [worker\_vm\_cpu\_core](#input\_worker\_vm\_cpu\_core) | total cpu cores | `number` | `2` | no |
| <a name="input_worker_vm_cpu_type"></a> [worker\_vm\_cpu\_type](#input\_worker\_vm\_cpu\_type) | cpu type | `string` | `"host"` | no |
| <a name="input_worker_vm_id"></a> [worker\_vm\_id](#input\_worker\_vm\_id) | worker node vm id (e.g 21x, where x is vm\_count) | `number` | `21` | no |
| <a name="input_worker_vm_mem"></a> [worker\_vm\_mem](#input\_worker\_vm\_mem) | total memory | `number` | `2048` | no |
| <a name="input_worker_vm_mem_balloon"></a> [worker\_vm\_mem\_balloon](#input\_worker\_vm\_mem\_balloon) | whether to enable balloon service on memory allocation, default set to disable | `number` | `0` | no |
| <a name="input_worker_vm_name"></a> [worker\_vm\_name](#input\_worker\_vm\_name) | worker node name | `string` | `"ubuntu-server"` | no |
| <a name="input_worker_vm_network_bridge"></a> [worker\_vm\_network\_bridge](#input\_worker\_vm\_network\_bridge) | default vm network nic bridge | `string` | `"vmbr0"` | no |
| <a name="input_worker_vm_network_dns"></a> [worker\_vm\_network\_dns](#input\_worker\_vm\_network\_dns) | default vm domain name server (DNS) ip e.g 8.8.8.8 | `string` | `"8.8.8.8"` | no |
| <a name="input_worker_vm_network_gateway"></a> [worker\_vm\_network\_gateway](#input\_worker\_vm\_network\_gateway) | default vm network gateway | `string` | `"192.168.1.1"` | no |
| <a name="input_worker_vm_network_ip_range"></a> [worker\_vm\_network\_ip\_range](#input\_worker\_vm\_network\_ip\_range) | default vm network ip range e.g 192.168.10x | `string` | `"192.168.10"` | no |
| <a name="input_worker_vm_network_model"></a> [worker\_vm\_network\_model](#input\_worker\_vm\_network\_model) | default vm network nic model | `string` | `"virtio"` | no |
| <a name="input_worker_vm_network_netmask"></a> [worker\_vm\_network\_netmask](#input\_worker\_vm\_network\_netmask) | default vm network mask e.g 24(255.255.255.0) | `string` | `24` | no |
| <a name="input_worker_vm_network_tag"></a> [worker\_vm\_network\_tag](#input\_worker\_vm\_network\_tag) | the VLAN tag to apply to packets on this device. By default -1 disables VLAN tagging. | `number` | `-1` | no |
| <a name="input_worker_vm_os_type"></a> [worker\_vm\_os\_type](#input\_worker\_vm\_os\_type) | worker node os type | `string` | `"cloud-init"` | no |
| <a name="input_worker_vm_ssh_key"></a> [worker\_vm\_ssh\_key](#input\_worker\_vm\_ssh\_key) | default ssh\_key to authenticate | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_master_nodes"></a> [master\_nodes](#output\_master\_nodes) | n/a |
| <a name="output_worker_nodes"></a> [worker\_nodes](#output\_worker\_nodes) | n/a |
