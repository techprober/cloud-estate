### Server Configurations ###

variable "proxmox_host" {
  default     = "10.10.10.10"
  description = "host ip of the proxmox server"
  type        = string
}

variable "pm_user" {
  default     = "terraform-prov"
  description = "pm user that proxmox uses to interact with the remote server"
  type        = string
}

variable "node_name" {
  default     = "pve"
  description = "name of the proxmox server node"
  type        = string
}

### LXC Container Configurations ###

variable "container_hostname" {
  description = "the host name of the container."
  type        = string
}

variable "container_id" {
  default     = 0
  description = "a number that sets the VMID of the container. If set to 0, the next available VMID is used. Default is 0"
  type        = number
}

variable "container_os_template" {
  default     = "ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
  description = "the volume identifier that points to the OS template or backup file"
  type        = string
}

variable "container_password" {
  description = "the root password inside the container"
  type        = string
}

variable "container_unprivileged" {
  default     = false
  description = "a boolean that makes the container run as an unprivileged user. Default is false"
  type        = bool
}

variable "container_cpu_cores" {
  default     = 4
  description = "the number of cores assigned to the container. A container can use all available cores by default"
  type        = number
}

variable "container_memory" {
  default     = 1024
  description = "a number containing the amount of RAM to assign to the container (in MB)"
  type        = number
}

variable "container_swap" {
  default     = 512
  description = "A number that sets the amount of swap memory available to the container. Default is 512"
  type        = number
}

variable "container_boot_disk_size" {
  default     = "10G"
  description = "size of the underlying volume. Must end in G, M, or K (e.g. '1G', '1024M' , '1048576K'). Note that this is a read only value."
  type        = string
}

variable "container_boot_disk_storage_pool" {
  default     = "local-lvm"
  description = "a string containing the volume , directory, or device to be mounted into the container (at the path specified by mp). E.g. local-lvm, local-zfs, local etc"
  type        = string
}

variable "container_network_interface" {
  default     = "eth0"
  description = "the name of the network interface as seen from inside the container (e.g. 'eth0')."
  type        = string
}

variable "container_network_ip" {
  default     = "dhcp"
  description = "the IPv4 address of the network interface. Can be a static IPv4 address (in CIDR notation), 'dhcp', or 'static: 10.10.10.1/24'"
  type        = string
}

variable "container_network_bridge" {
  default     = "vmbr0"
  description = "the bridge to attach the network interface to (e.g. 'vmbr0')."
  type        = string
}

variable "container_network_mtu" {
  default     = 1500
  description = "a number to set the MTU on the network interface."
  type        = number
}

variable "container_network_gateway" {
  description = "the IPv4 address belonging to the network interface's default gateway."
  type        = string
}

variable "container_network_dns" {
  default     = "8.8.8.8"
  description = "The DNS server IP address used by the container."
  type        = string
}

variable "ssh_public_keys" {
  description = "multi-line string of SSH public keys that will be added to the container. Can be defined using heredoc syntax."
  type        = string
}
