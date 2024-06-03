#!/bin/bash
apt-get update
apt-get install -y curl lsb-release gnupg
curl -fsSL https://repo.saltproject.io/salt/py3/ubuntu/$(lsb_release -rs)/amd64/latest/salt-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/salt-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg] https://repo.saltproject.io/salt/py3/ubuntu/$(lsb_release -rs)/amd64/latest $(lsb_release -cs) main" > /etc/apt/sources.list.d/salt.list
apt-get update
apt-get install -y salt-master

mkdir -p /srv/salt/files
echo "This is a test file from the Salt master." > /srv/salt/files/sent_file.txt

cat <<EOF > /srv/salt/top.sls
base:
  '*':
    - file_send
EOF

cat <<EOF > /srv/salt/file_send.sls
send_file_to_minions:
  file.managed:
    - name: /home/ubuntu/received_file.txt
    - source: salt://files/sent_file.txt
    - user: ubuntu
    - group: ubuntu
    - mode: '0644'
EOF

systemctl enable salt-master
systemctl start salt-master
