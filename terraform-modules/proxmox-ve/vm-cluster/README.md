## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 2.9.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 2.9.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_vm_qemu.vm](https://registry.terraform.io/providers/telmate/proxmox/2.9.5/docs/resources/vm_qemu) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | name of the proxmox server node | `string` | `"pve"` | no |
| <a name="input_pm_user"></a> [pm\_user](#input\_pm\_user) | pm user that proxmox uses to interact with the remote server | `string` | `"terraform-prov"` | no |
| <a name="input_proxmox_host"></a> [proxmox\_host](#input\_proxmox\_host) | host ip of the proxmox server | `string` | `"10.10.10.10"` | no |
| <a name="input_template_name"></a> [template\_name](#input\_template\_name) | template name used to deploy the vm | `string` | `"ubuntu-2204-cloudinit-template"` | no |
| <a name="input_vm_boot_disk"></a> [vm\_boot\_disk](#input\_vm\_boot\_disk) | default vm boot disk | `string` | `"scsi0"` | no |
| <a name="input_vm_boot_disk_format"></a> [vm\_boot\_disk\_format](#input\_vm\_boot\_disk\_format) | default vm boot disk format | `string` | `"raw"` | no |
| <a name="input_vm_boot_disk_size"></a> [vm\_boot\_disk\_size](#input\_vm\_boot\_disk\_size) | default vm boot disk capacity | `string` | `"10G"` | no |
| <a name="input_vm_boot_disk_slot"></a> [vm\_boot\_disk\_slot](#input\_vm\_boot\_disk\_slot) | default vm boot disk id | `number` | `0` | no |
| <a name="input_vm_boot_disk_storage_pool"></a> [vm\_boot\_disk\_storage\_pool](#input\_vm\_boot\_disk\_storage\_pool) | default vm boot disk storage pool | `string` | `"local-lvm"` | no |
| <a name="input_vm_boot_disk_type"></a> [vm\_boot\_disk\_type](#input\_vm\_boot\_disk\_type) | default vm boot disk type | `string` | `"scsi"` | no |
| <a name="input_vm_count"></a> [vm\_count](#input\_vm\_count) | number of vm to be deployed | `number` | `1` | no |
| <a name="input_vm_cpu_core"></a> [vm\_cpu\_core](#input\_vm\_cpu\_core) | total cpu cores | `number` | `2` | no |
| <a name="input_vm_cpu_type"></a> [vm\_cpu\_type](#input\_vm\_cpu\_type) | cpu type | `string` | `"host"` | no |
| <a name="input_vm_id"></a> [vm\_id](#input\_vm\_id) | vm id | `number` | `20` | no |
| <a name="input_vm_mem"></a> [vm\_mem](#input\_vm\_mem) | total memory | `number` | `2048` | no |
| <a name="input_vm_mem_balloon"></a> [vm\_mem\_balloon](#input\_vm\_mem\_balloon) | whether to enable balloon service on memory allocation, default set to disable | `number` | `0` | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | vm name | `string` | `"ubuntu-server"` | no |
| <a name="input_vm_network_bridge"></a> [vm\_network\_bridge](#input\_vm\_network\_bridge) | the VLAN tag to apply to packets on this device. By default -1 disables VLAN tagging. | `number` | `-1` | no |
| <a name="input_vm_network_dns"></a> [vm\_network\_dns](#input\_vm\_network\_dns) | default vm domain name server (DNS) ip e.g 8.8.8.8 | `string` | `"8.8.8.8"` | no |
| <a name="input_vm_network_gateway"></a> [vm\_network\_gateway](#input\_vm\_network\_gateway) | default vm network gateway | `string` | `"192.168.1.1"` | no |
| <a name="input_vm_network_ip_range"></a> [vm\_network\_ip\_range](#input\_vm\_network\_ip\_range) | default vm network ip range e.g 192.168.10x | `string` | `"192.168.10"` | no |
| <a name="input_vm_network_model"></a> [vm\_network\_model](#input\_vm\_network\_model) | default vm network nic model | `string` | `"virtio"` | no |
| <a name="input_vm_network_netmask"></a> [vm\_network\_netmask](#input\_vm\_network\_netmask) | default vm network mask e.g 24(255.255.255.0) | `string` | `24` | no |
| <a name="input_vm_os_type"></a> [vm\_os\_type](#input\_vm\_os\_type) | vm os type | `string` | `"cloud-init"` | no |
| <a name="input_vm_ssh_key"></a> [vm\_ssh\_key](#input\_vm\_ssh\_key) | default ssh\_key to authenticate | `string` | `""` | no |

## Outputs

No outputs.
