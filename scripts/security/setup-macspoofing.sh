#!/bin/bash
# MAC Spoofing
for iface in eth0 eth1; do
  echo "pre-up macchanger -r $iface" >> /etc/network/interfaces
done

apt install -y macchanger
