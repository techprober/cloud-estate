# VM specific vars

clone_vm_id          = 900
vm_id                = 9001
vm_name              = "prod-debian-12-server-packer-template"
template_name        = "prod-debian-12-server-packer-template"
template_description = "image made from debian cloud image"

os       = "l26"
cores    = "4"
cpu_type = "host"
memory   = "1024"
sockets  = "1"
boot     = "order=scsi0"
vga_type = "std"

cloud_init_storage_pool = "local-zfs"
scsi_controller         = "virtio-scsi-single"
disk_size               = "10G"

network_adapters_model  = "virtio"
network_adapters_bridge = "vmbr2"
ip                      = "10.178.0.211/24"
gateway                 = "10.178.0.4"
nameserver              = "10.178.0.4"

ssh_port     = 22
ssh_username = "packer"
ssh_password = "packer"
ssh_timeout  = "20m"

playbook_file = "debian_12_server.yml"
