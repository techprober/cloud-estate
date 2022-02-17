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

### VM Configurations ###

variable "vm_name" {
  default     = "ubuntu-server"
  description = "vm name"
  type        = string
}

variable "vm_id" {
  description = "vm id"
  type        = number
}

variable "vm_os_type" {
  default     = "cloud-init"
  description = "vm os type"
  type        = string
}

variable "template_name" {
  default     = "ubuntu-2204-cloudinit-template"
  description = "template name used to deploy the vm"
  type        = string
}


variable "vm_cpu_core" {
  default     = 2
  description = "total cpu cores"
  type        = number
}

variable "vm_cpu_type" {
  default     = "host"
  description = "cpu type"
  type        = string
}

variable "vm_mem" {
  default     = 2048
  description = "total memory"
  type        = number
}

variable "vm_mem_balloon" {
  default     = 0
  description = "whether to enable balloon service on memory allocation, default set to disable"
  type        = number
}

variable "vm_boot_disk" {
  default     = "scsi0"
  description = "default vm boot disk"
  type        = string
}

variable "vm_boot_disk_slot" {
  default     = 0
  description = "default vm boot disk id"
  type        = number
}

variable "vm_boot_disk_size" {
  default     = "10G"
  description = "default vm boot disk capacity"
  type        = string
}

variable "vm_boot_disk_type" {
  default     = "scsi"
  description = "default vm boot disk type"
  type        = string
}

variable "vm_boot_disk_format" {
  default     = "raw"
  description = "default vm boot disk format"
  type        = string
}

variable "vm_boot_disk_storage_pool" {
  default     = "local-lvm"
  description = "default vm boot disk storage pool"
  type        = string
}

variable "vm_network_model" {
  default     = "virtio"
  description = "default vm network nic model"
  type        = string
}

variable "vm_network_bridge" {
  default     = "vmbr0"
  description = "default vm network nic bridge"
  type        = string
}

variable "vm_network_ip" {
  description = "default vm network ip e.g 192.168.100"
  type        = string
}

variable "vm_network_gateway" {
  default     = "192.168.1.1"
  description = "default vm network gateway"
  type        = string
}

variable "vm_ssh_key" {
  default     = ""
  description = "default ssh_key to authenticate"
  type        = string
}
