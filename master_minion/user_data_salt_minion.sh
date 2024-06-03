#!/bin/bash
apt-get update
apt-get install -y curl lsb-release gnupg
curl -fsSL https://repo.saltproject.io/salt/py3/ubuntu/$(lsb_release -rs)/amd64/latest/salt-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/salt-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg] https://repo.saltproject.io/salt/py3/ubuntu/$(lsb_release -rs)/amd64/latest $(lsb_release -cs) main" > /etc/apt/sources.list.d/salt.list
apt-get update
apt-get install -y salt-minion
echo "master: ${aws_instance.salt_master.private_ip}" > /etc/salt/minion
systemctl enable salt-minion
systemctl start salt-minion
