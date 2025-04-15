#!/bin/bash
# Self-destruct VMs after 1hr of inactivity
qm list | awk '/dispvm/ {print $1}' | xargs -I{} qm set {} --delete after=3600
qvm-features dispvm auto-remove true

# Clean Qubes dispvms older than 1hr
find /var/lib/qubes/dvmdata/ -mmin +60 -exec rm -rf {} \;
#!/bin/bash
# Self-destruct VMs after 1hr of inactivity
qm list | awk '/dispvm/ {print $1}' | xargs -I{} qm set {} --delete after=3600
qvm-features dispvm auto-remove true

# Clean Qubes dispvms older than 1hr
find /var/lib/qubes/dvmdata/ -mmin +60 -exec rm -rf {} \;
