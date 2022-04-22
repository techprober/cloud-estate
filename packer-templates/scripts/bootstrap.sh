#!/bin/bash

# Install MC Client
echo 'Installing MC Client ...'
wget -q https://dl.min.io/client/mc/release/linux-amd64/mc
chmod +x mc
sudo mv mc /usr/bin
mc --autocompletion >/dev/null 2>&1

# Cleans Audit Log
echo 'Cleaning all audit logs ...'
[[ -f /var/log/audit/audit.log ]] && sudo cat /dev/null | sudo tee /var/log/audit/audit.log
[[ -f /var/log/wtmp ]] && sudo cat /dev/null | sudo tee /var/log/wtmp
[[ -f /var/log/lastlog ]] && sudo cat /dev/null | sudo tee /var/log/lastlog

# Set hostname to localhost
echo 'Setting hostname to localhost ...'
sudo cat /dev/null | sudo tee /etc/hostname
sudo hostnamectl set-hostname localhost

# Clean the machine-id
echo 'Cleaning the machine-id ...'
sudo truncate -s 0 /etc/machine-id
sudo rm /var/lib/dbus/machine-id
sudo ln -s /etc/machine-id /var/lib/dbus/machine-id

# Clean apt-get
echo 'Cleaning apt cache ...'
sudo apt-get clean

# Write down the birthdate
echo 'Writing birthdate information'
sudo date >/etc/birthdate_certificate
