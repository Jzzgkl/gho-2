#!/bin/bash
# Validate anonymity stack
echo "=== LokiNet Status ==="
lokinet-vpn --status | grep 'Exit Node'

echo -e "\n=== DNSCrypt Validation ==="
dig +short txt debug.dnscrypt.info @127.0.0.1 -p 5300

echo -e "\n=== Noise Injection Check ==="
tail -n 20 /var/log/ghost/noise.log | grep "decoy"
