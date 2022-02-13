#!/bin/bash

# Install MC Client
echo '==> Installing MC Client ...'
wget -q https://dl.min.io/client/mc/release/linux-amd64/mc
chmod +x mc
sudo mv mc /usr/bin
mc --autocompletion

# Cleans Audit Log
echo '==> Cleaning all audit logs ...'
[[ -f /var/log/audit/audit.log ]] && sudo cat /dev/null | sudo tee /var/log/audit/audit.log
[[ -f /var/log/wtmp ]] && sudo cat /dev/null | sudo tee /var/log/wtmp
[[ -f /var/log/lastlog ]] && sudo cat /dev/null | sudo tee /var/log/lastlog

# Clean apt-get.
echo '==> Cleaning apt-get ...'
sudo apt-get clean

# Modifying ssh configuration
echo '==> Modifying ssh configuration ...'
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config
sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo service sshd restart

# Sets hostname to localhost.
echo '==> Setting hostname to localhost ...'
sudo cat /dev/null | sudo tee /etc/hostname
sudo hostnamectl set-hostname localhost

# Add dbus service
echo '==> Adding dbus service ...'
sudo awk -i inplace '1;/After=systemd-remount-fs.service/{print "After=dbus.service"}' /lib/systemd/system/open-vm-tools.service

# Cleans the machine-id.
echo '==> Cleaning the machine-id ...'
sudo truncate -s 0 /etc/machine-id
sudo rm /var/lib/dbus/machine-id
sudo ln -s /etc/machine-id /var/lib/dbus/machine-id

echo '==> Provisioning finished, enjoyed!'
