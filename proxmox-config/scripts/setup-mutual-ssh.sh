#!/bin/bash
# SSH Tunnel Setup
ssh-keygen -t ed25519 -f /ghost-stack/vault/identities/ssh-key -N ""
qm set 9000 --sshkey /ghost-stack/vault/identities/ssh-key.pub

cat > /etc/ssh/sshd_config.d/ghost.conf <<EOF
Match User operator
    AllowTcpForwarding yes
    PermitOpen 10.10.10.0/24:*
    AllowAgentForwarding no
EOF

systemctl restart ssh
