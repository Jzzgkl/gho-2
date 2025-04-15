#!/bin/bash
# Proxy-Sale.com rotation script

API_ENDPOINT="https://api.proxy-sale.com/v2/rotate"
API_KEY=$(grep PROXY_SALE_API_KEY proxy-sale.conf | cut -d= -f2)

rotate_proxy() {
  RESPONSE=$(curl -s -H "Authorization: Bearer $API_KEY" $API_ENDPOINT)
  NEW_PROXY=$(echo $RESPONSE | jq -r '.proxy')
  
  # Update all services
  sed -i "s/exit-node=.*/exit-node=$NEW_PROXY/" /etc/lokinet/lokinet.ini
  systemctl restart lokinet
  
  echo "$(date) - Rotated to: $NEW_PROXY" >> logs/proxy-rotation.log
}

# Run rotation every 5 minutes
while true; do
  rotate_proxy
  sleep 300
done