#!/bin/bash
# GHOST STACK BOOTSTRAP FOR PROXMOX
echo "🧩 Initializing Proxmox/Qubes Ghost Stack..."

# Proxmox API Check
if ! command -v pvesh &> /dev/null; then
    echo "❌ Proxmox environment not detected!"
    exit 1
fi

# Network Setup for proxmox
#!/bin/bash
# GHOST STACK BOOTSTRAP - NETWORK SETUP

echo "🌐 Configuring Proxmox Network Bridges..."

# Create bridge configuration files
cat > /etc/network/interfaces.d/vmbr10.cfg <<EOF
auto vmbr10
iface vmbr10 inet static
    address 192.168.100.1/24
    bridge-ports none
    bridge-stp off
    bridge-fd 0
    post-up iptables -t nat -A POSTROUTING -s '192.168.100.0/24' -j MASQUERADE
    post-up ip link set dev vmbr10 mtu 1500
EOF

cat > /etc/network/interfaces.d/vmbr20.cfg <<EOF
auto vmbr20
iface vmbr20 inet manual
    bridge-ports none
    bridge-stp off
    bridge-fd 0
    post-up iptables -A FORWARD -i vmbr20 -o vmbr10 -j DROP
    post-up ip route add 10.20.30.0/24 via 192.168.100.2 dev vmbr20
    post-up ip link set dev vmbr20 mtu 9000
EOF

# Apply network configuration
echo "🔧 Applying network settings..."
systemctl restart networking.service

# Verify bridge creation
echo "🔍 Network Status:"
ip -br link show vmbr10
ip -br link show vmbr20

# Configure persistent firewall rules
echo "🔥 Setting up firewall rules..."
iptables -A FORWARD -i vmbr10 -o vmbr20 -j DROP
iptables -A FORWARD -i vmbr20 -o vmbr10 -j DROP
iptables-save > /etc/iptables/rules.v4

# Enable IP forwarding
echo "📡 Enabling IP forwarding..."
sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf


echo "🛡️ Deploying Privacy Stack..."
bash scripts/network/setup-lokinet.sh
cp conf/dnscrypt-proxy.toml /etc/dnscrypt-proxy/
systemctl restart dnscrypt-proxy


# Create Template VMs
echo "📦 Deploying Proxmox templates..."
for TEMPLATE in proxmox-config/vm-templates/*.conf; do
    qm create $(basename $TEMPLATE .conf) --import $TEMPLATE
done

# Qubes Integration
echo "🛡️ Initializing Qubes policies..."
cp qubes-config/policy/30-ghost-stack.policy /etc/qubes/policy.d/

echo "✅ Proxmox/Qubes bootstrap complete"
