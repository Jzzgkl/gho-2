#!/bin/bash
# LokiNet Onion Routing Setup
apt install -y lokinet

cat > /etc/lokinet/lokinet.ini <<EOF
[network]
exit-node=auto
exit-auth=proxy-sale:${API_KEY}
upstream-resolver=127.0.0.1:5300

[router]
public-address=$(hostname -I | awk '{print $1}')
public-port=2202

[system]
user=lokinet
group=lokinet
EOF

systemctl enable --now lokinet
