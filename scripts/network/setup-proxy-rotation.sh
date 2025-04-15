#!/bin/bash
# Proxy Rotation Core
source ../proxy-rotator/proxy-sale.conf

curl -s -H "Authorization: Bearer $API_KEY" \
  "$API_ENDPOINT/proxy/list?type=$EXIT_NODES" > proxies.txt

while read -r proxy; do
  sed -i "s/exit-node=.*/exit-node=$proxy/" /etc/lokinet/lokinet.ini
  systemctl restart lokinet
  sleep $ROTATION_INTERVAL
done < proxies.txt
