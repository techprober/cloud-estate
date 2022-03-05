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

variable "container_clone_id" {
  description = "the lxc vmid to clone"
  type        = string
}

variable "container_clone_storage" {
  default     = "local-lvm"
  description = "target storage for full clone"
  type        = string
}

variable "container_start_after_creation" {
  default     = false
  description = "a boolean that determines if the container is started after creation. Default is false"
  type        = bool
}
