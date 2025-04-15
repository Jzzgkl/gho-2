#!/bin/bash
# Ramdisk logging for all components
mkdir /var/log/ghost
echo "tmpfs /var/log/ghost tmpfs rw,size=512M,nr_inodes=1k,noexec,nodev,nosuid 0 0" >> /etc/fstab

cat > /etc/rsyslog.d/ghos#!/bin/bash
# Ramdisk logging for all components
mkdir /var/log/ghost
echo "tmpfs /var/log/ghost tmpfs rw,size=512M,nr_inodes=1k,noexec,nodev,nosuid 0 0" >> /etc/fstab

cat > /etc/rsyslog.d/ghost.conf <<EOF
:programname, isequal, "ghost-stack" -/var/log/ghost/operations.log
& stop
EOF

systemctl restart rsyslogt.conf <<EOF
:programname, isequal, "ghost-stack" -/var/log/ghost/operations.log
& stop
EOF

systemctl restart rsyslog
