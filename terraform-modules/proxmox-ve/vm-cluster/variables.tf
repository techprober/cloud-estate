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

variable "master_vm_count" {
  default     = 1
  description = "number of master-node to be deployed"
  type        = number
}

variable "worker_vm_count" {
  default     = 1
  description = "number of master-node to be deployed"
  type        = number
}

### VM Configurations ###

variable "master_vm_name" {
  default     = "ubuntu-server"
  description = "master node name"
  type        = string
}

variable "worker_vm_name" {
  default     = "ubuntu-server"
  description = "worker node name"
  type        = string
}

variable "master_vm_id" {
  default     = 20
  description = "master node vm id (e.g 20x, where x is vm_count)"
  type        = number
}

variable "worker_vm_id" {
  default     = 21
  description = "worker node vm id (e.g 21x, where x is vm_count)"
  type        = number
}

variable "master_vm_os_type" {
  default     = "cloud-init"
  description = "master node os type"
  type        = string
}

variable "worker_vm_os_type" {
  default     = "cloud-init"
  description = "worker node os type"
  type        = string
}

variable "template_name" {
  default     = "ubuntu-2204-cloudinit-template"
  description = "template name used to deploy the vm"
  type        = string
}


variable "master_vm_cpu_core" {
  default     = 2
  description = "total cpu cores"
  type        = number
}

variable "worker_vm_cpu_core" {
  default     = 2
  description = "total cpu cores"
  type        = number
}

variable "master_vm_cpu_type" {
  default     = "host"
  description = "cpu type"
  type        = string
}

variable "worker_vm_cpu_type" {
  default     = "host"
  description = "cpu type"
  type        = string
}

variable "master_vm_mem" {
  default     = 2048
  description = "total memory"
  type        = number
}

variable "worker_vm_mem" {
  default     = 2048
  description = "total memory"
  type        = number
}

variable "master_vm_mem_balloon" {
  default     = 0
  description = "whether to enable balloon service on memory allocation, default set to disable"
  type        = number
}

variable "worker_vm_mem_balloon" {
  default     = 0
  description = "whether to enable balloon service on memory allocation, default set to disable"
  type        = number
}

variable "master_vm_boot_disk" {
  default     = "scsi0"
  description = "default vm boot disk"
  type        = string
}

variable "worker_vm_boot_disk" {
  default     = "scsi0"
  description = "default vm boot disk"
  type        = string
}

variable "master_vm_boot_disk_slot" {
  default     = 0
  description = "default vm boot disk id"
  type        = number
}

variable "worker_vm_boot_disk_slot" {
  default     = 0
  description = "default vm boot disk id"
  type        = number
}

variable "master_vm_boot_disk_size" {
  default     = "10G"
  description = "default vm boot disk capacity"
  type        = string
}

variable "worker_vm_boot_disk_size" {
  default     = "10G"
  description = "default vm boot disk capacity"
  type        = string
}

variable "master_vm_boot_disk_type" {
  default     = "scsi"
  description = "default vm boot disk type"
  type        = string
}

variable "worker_vm_boot_disk_type" {
  default     = "scsi"
  description = "default vm boot disk type"
  type        = string
}

variable "master_vm_boot_disk_format" {
  default     = "raw"
  description = "default vm boot disk format"
  type        = string
}

variable "worker_vm_boot_disk_format" {
  default     = "raw"
  description = "default vm boot disk format"
  type        = string
}

variable "master_vm_boot_disk_storage_pool" {
  default     = "local-lvm"
  description = "default vm boot disk storage pool"
  type        = string
}

variable "worker_vm_boot_disk_storage_pool" {
  default     = "local-lvm"
  description = "default vm boot disk storage pool"
  type        = string
}

variable "master_vm_network_model" {
  default     = "virtio"
  description = "default vm network nic model"
  type        = string
}

variable "worker_vm_network_model" {
  default     = "virtio"
  description = "default vm network nic model"
  type        = string
}

variable "master_vm_network_bridge" {
  default     = "vmbr0"
  description = "default vm network nic bridge"
  type        = string
}

variable "worker_vm_network_bridge" {
  default     = "vmbr0"
  description = "default vm network nic bridge"
  type        = string
}

variable "master_vm_network_tag" {
  default     = -1
  description = "the VLAN tag to apply to packets on this device. By default -1 disables VLAN tagging."
  type        = number
}

variable "worker_vm_network_tag" {
  default     = -1
  description = "the VLAN tag to apply to packets on this device. By default -1 disables VLAN tagging."
  type        = number
}

variable "master_vm_network_ip_range" {
  default     = "192.168.10"
  description = "default vm network ip range e.g 192.168.10x"
  type        = string
}

variable "worker_vm_network_ip_range" {
  default     = "192.168.10"
  description = "default vm network ip range e.g 192.168.10x"
  type        = string
}

variable "master_vm_network_netmask" {
  default     = 24
  description = "default vm network mask e.g 24(255.255.255.0)"
  type        = string
}

variable "worker_vm_network_netmask" {
  default     = 24
  description = "default vm network mask e.g 24(255.255.255.0)"
  type        = string
}

variable "master_vm_network_dns" {
  default     = "8.8.8.8"
  description = "default vm domain name server (DNS) ip e.g 8.8.8.8"
  type        = string
}

variable "worker_vm_network_dns" {
  default     = "8.8.8.8"
  description = "default vm domain name server (DNS) ip e.g 8.8.8.8"
  type        = string
}

variable "master_vm_network_gateway" {
  default     = "192.168.1.1"
  description = "default vm network gateway"
  type        = string
}

variable "worker_vm_network_gateway" {
  default     = "192.168.1.1"
  description = "default vm network gateway"
  type        = string
}

variable "master_vm_ssh_key" {
  default     = ""
  description = "default ssh_key to authenticate"
  type        = string
}

variable "worker_vm_ssh_key" {
  default     = ""
  description = "default ssh_key to authenticate"
  type        = string
}
