#!/bin/bash
# GHOST STACK BOOTSTRAP FOR PROXMOX
echo "🧩 Initializing Proxmox/Qubes Ghost Stack..."

# Proxmox API Check
if ! command -v pvesh &> /dev/null; then
    echo "❌ Proxmox environment not detected!"
    exit 1
fi

# Network Setup for Proxmox
echo "🔧 Configuring Proxmox bridges..."
cp proxmox-config/network/vmbr10.cfg /etc/network/interfaces.d/
systemctl restart networking

# Create Template VMs
echo "📦 Deploying Proxmox templates..."
for TEMPLATE in proxmox-config/vm-templates/*.conf; do
    qm create $(basename $TEMPLATE .conf) --import $TEMPLATE
done

# Qubes Integration
echo "🛡️ Initializing Qubes policies..."
cp qubes-config/policy/30-ghost-stack.policy /etc/qubes/policy.d/

echo "✅ Proxmox/Qubes bootstrap complete"
