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
| [proxmox_lxc.container](https://registry.terraform.io/providers/telmate/proxmox/2.9.11/docs/resources/lxc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_clone_id"></a> [container\_clone\_id](#input\_container\_clone\_id) | the lxc vmid to clone | `string` | n/a | yes |
| <a name="input_container_clone_storage"></a> [container\_clone\_storage](#input\_container\_clone\_storage) | target storage for full clone. | `string` | n/a | yes |
| <a name="input_container_hostname"></a> [container\_hostname](#input\_container\_hostname) | the host name of the container. | `string` | n/a | yes |
| <a name="input_container_id"></a> [container\_id](#input\_container\_id) | a number that sets the VMID of the container. If set to 0, the next available VMID is used. Default is 0 | `number` | `0` | no |
| <a name="input_container_start_after_creation"></a> [container\_start\_after\_creation](#input\_container\_start\_after\_creation) | a boolean that determines if the container is started after creation. Default is false | `bool` | `false` | no |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | name of the proxmox server node | `string` | `"pve"` | no |
| <a name="input_pm_user"></a> [pm\_user](#input\_pm\_user) | pm user that proxmox uses to interact with the remote server | `string` | `"terraform-prov"` | no |
| <a name="input_proxmox_host"></a> [proxmox\_host](#input\_proxmox\_host) | host ip of the proxmox server | `string` | n/a | yes |

## Outputs

No outputs.
