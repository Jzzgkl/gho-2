#!/bin/bash

echo "🧹 Running Ghost Stack cleanup..."

# Memory wipe (optional paranoid mode)
echo "🧩 Wiping memory swap and cache..."
sync; echo 3 > /proc/sys/vm/drop_caches
swapoff -a && swapon -a

# Clean temp logs
echo "🧩 Cleaning logs and temporary files..."
rm -rf /var/log/ghost-stack/*
rm -f /tmp/ghost-stack-* || true

pkill -f noise-generator.sh
iptables -t nat -F OUTPUT

echo "✅ Cleanup completed."
