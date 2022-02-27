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
| [proxmox_lxc.container](https://registry.terraform.io/providers/telmate/proxmox/2.9.5/docs/resources/lxc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_boot_disk_size"></a> [container\_boot\_disk\_size](#input\_container\_boot\_disk\_size) | size of the underlying volume. Must end in G, M, or K (e.g. '1G', '1024M' , '1048576K'). Note that this is a read only value. | `string` | `"10G"` | no |
| <a name="input_container_boot_disk_storage_pool"></a> [container\_boot\_disk\_storage\_pool](#input\_container\_boot\_disk\_storage\_pool) | a string containing the volume , directory, or device to be mounted into the container (at the path specified by mp). E.g. local-lvm, local-zfs, local etc | `string` | `"local-lvm"` | no |
| <a name="input_container_cpu_cores"></a> [container\_cpu\_cores](#input\_container\_cpu\_cores) | the number of cores assigned to the container. A container can use all available cores by default | `number` | `4` | no |
| <a name="input_container_hostname"></a> [container\_hostname](#input\_container\_hostname) | the host name of the container. | `string` | n/a | yes |
| <a name="input_container_id"></a> [container\_id](#input\_container\_id) | a number that sets the VMID of the container. If set to 0, the next available VMID is used. Default is 0 | `number` | `0` | no |
| <a name="input_container_memory"></a> [container\_memory](#input\_container\_memory) | a number containing the amount of RAM to assign to the container (in MB) | `number` | `1024` | no |
| <a name="input_container_network_bridge"></a> [container\_network\_bridge](#input\_container\_network\_bridge) | the bridge to attach the network interface to (e.g. 'vmbr0'). | `string` | `"vmbr0"` | no |
| <a name="input_container_network_dns"></a> [container\_network\_dns](#input\_container\_network\_dns) | The DNS server IP address used by the container. | `string` | `"8.8.8.8"` | no |
| <a name="input_container_network_gateway"></a> [container\_network\_gateway](#input\_container\_network\_gateway) | the IPv4 address belonging to the network interface's default gateway. | `string` | n/a | yes |
| <a name="input_container_network_interface"></a> [container\_network\_interface](#input\_container\_network\_interface) | the name of the network interface as seen from inside the container (e.g. 'eth0'). | `string` | `"eth0"` | no |
| <a name="input_container_network_ip"></a> [container\_network\_ip](#input\_container\_network\_ip) | the IPv4 address of the network interface. Can be a static IPv4 address (in CIDR notation), 'dhcp', or 'static: 10.10.10.1/24' | `string` | `"dhcp"` | no |
| <a name="input_container_os_template"></a> [container\_os\_template](#input\_container\_os\_template) | the volume identifier that points to the OS template or backup file | `string` | n/a | yes |
| <a name="input_container_password"></a> [container\_password](#input\_container\_password) | the root password inside the container | `string` | n/a | yes |
| <a name="input_container_start_after_creation"></a> [container\_start\_after\_creation](#input\_container\_start\_after\_creation) | a boolean that determines if the container is started after creation. Default is false | `bool` | `false` | no |
| <a name="input_container_swap"></a> [container\_swap](#input\_container\_swap) | A number that sets the amount of swap memory available to the container. Default is 512 | `number` | `512` | no |
| <a name="input_container_unprivileged"></a> [container\_unprivileged](#input\_container\_unprivileged) | a boolean that makes the container run as an unprivileged user. Default is false | `bool` | `false` | no |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | name of the proxmox server node | `string` | `"pve"` | no |
| <a name="input_pm_user"></a> [pm\_user](#input\_pm\_user) | pm user that proxmox uses to interact with the remote server | `string` | `"terraform-prov"` | no |
| <a name="input_proxmox_host"></a> [proxmox\_host](#input\_proxmox\_host) | host ip of the proxmox server | `string` | `"10.10.10.10"` | no |
| <a name="input_ssh_public_keys"></a> [ssh\_public\_keys](#input\_ssh\_public\_keys) | multi-line string of SSH public keys that will be added to the container. Can be defined using heredoc syntax. | `string` | n/a | yes |

## Outputs

No outputs.
