#!/bin/bash
# Rotate LokiNet exit nodes via Proxy-Sale API
NEW_EXIT=$(curl -s -H "Authorization: Bearer ${API_KEY}" \
  "https://api.proxy-sale.com/v2/lokinet-exits" | jq -r '.exit_node')

sed -i "s/exit-node=.*/exit-node=${NEW_EXIT}/" /etc/lokinet/lokinet.ini
systemctl restart lokinet

echo "[$(date)] Rotated to exit node: ${NEW_EXIT}" >> /var/log/exit-rotation.log
