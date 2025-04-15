#!/bin/bash

echo "🖥️ Ghost Stack Operator Status Panel"

echo ""
echo "🌐 Active VMs:"
virsh list --all

echo ""
echo "🧩 Proxy Rotation Status:"
echo "Current Proxy: 3e021f396ca760a1:RNW78Fm5@res.proxy-sale.com:10000"

echo ""
echo "🔍 Last Leak Test:"
if [ -f logs/leaktest.log ]; then
  cat logs/leaktest.log
else
  echo "No leak test results yet."
fi

echo ""
echo "🧹 Last Cleanup:"
if [ -f logs/cleanup.log ]; then
  cat logs/cleanup.log
else
  echo "No cleanup actions logged yet."
fi

echo -e "\n🔐 LokiNet Exit:"
lokinet-vpn --status | grep Exit | awk '{print $NF}'

echo -e "\n🌫️ Noise Injection:"
pgrep noise-generator.sh >/dev/null && echo "Active" || echo "Inactive"

echo ""
echo "✅ System status check completed."
