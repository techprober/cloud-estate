#!/bin/sh

export vm_id=$1
export vm_name=$2
export cloudimg_name=$3

#Username to create on VM template
export username=packer
export password=packer

#Name of your storage
export storage=local-lvm

#Print all of the configuration
echo "Creating template $2 ($1)"

# Create new VM
# Feel free to change any of these to your liking
qm create $1 --name $2 --ostype l26
# Set networking to default bridge
qm set $1 --net0 virtio,bridge=vmbr0
# Set display to serial
qm set $1 --serial0 socket --vga serial0
# Set memory, cpu, type defaults
# If you are in a cluster, you might need to change cpu type
qm set $1 --memory 1024 --cores 4 --cpu host
# Set boot device to new file
qm set $1 --scsi0 ${storage}:0,import-from="$(pwd)/$3",discard=on
# Set scsi hardware as default boot disk using virtio scsi single
qm set $1 --boot order=scsi0 --scsihw virtio-scsi-single
# Enable Qemu guest agent in case the guest has it available
qm set $1 --agent enabled=1,fstrim_cloned_disks=1
# Add cloud-init device
qm set $1 --ide2 ${storage}:cloudinit
# Set CI ip config
# IP6 = auto means SLAAC (a reliable default with no bad effects on non-IPv6 networks)
# IP = DHCP means what it says, so leave that out entirely on non-IPv4 networks to avoid DHCP delays
qm set $1 --ipconfig0 "ip6=auto,ip=dhcp"
# If you want to do password-based auth instaed
# Then use this option and comment out the line above
# Add the user
qm set $1 --ciuser ${username}
qm set $1 --cipassword ${password}
# Disable upgrade
qm set $1 --ciupgrade 0
# Upload custom cloud-init configuration
qm set $1 --cicustom "vendor=local:snippets/vendor.yaml"
# Resize the disk to 8G, a reasonable minimum. You can expand it more later.
# If the disk is already bigger than 8G, this will fail, and that is okay.
qm disk resize $1 scsi0 8G
# Assign tags
qm set $1 --tags debian,cloudinit
# Make it a template
qm template $1

echo "Finished creating template $2 ($1)"
