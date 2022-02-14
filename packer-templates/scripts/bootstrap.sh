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

# Clean apt-get.
echo 'Cleaning apt cache ...'
sudo apt-get autoclean

# Modifying ssh configuration
echo '==> Modifying ssh configuration ...'
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config
sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo service sshd restart

# Cleans the machine-id.
echo 'Cleaning the machine-id ...'
sudo truncate -s 0 /etc/machine-id
sudo rm /var/lib/dbus/machine-id
sudo ln -s /etc/machine-id /var/lib/dbus/machine-id

echo 'Provisioning finished, enjoyed!'
