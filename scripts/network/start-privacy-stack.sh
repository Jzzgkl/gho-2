#!/bin/bash
# Start all privacy services
systemctl start lokinet
systemctl start dnscrypt-proxy
nohup ./scripts/utilities/noise-generator.sh >> /var/log/ghost/noise.log 2>&1 &

# Configure proxy chaining
update-alternatives --set iptables /usr/sbin/iptables-legacy
iptables -t nat -A OUTPUT -p tcp --dport 53 -j REDIRECT --to-port 5300
iptables -t nat -A OUTPUT -p udp --dport 53 -j REDIRECT --to-port 5300
