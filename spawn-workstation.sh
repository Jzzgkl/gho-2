#!/bin/bash
# Spawn Qubes-based Workstations
TYPE=$1
LABEL="ghost-$(date +%s)"

case $TYPE in
  kali)
    qvm-create --label red --template kali-ghost --class DisposableVM $LABEL
    ;;
  whonix)
    qvm-create --label black --template whonix-ghost --class DispVM $LABEL
    ;;
  *)
    echo "Invalid type. Use 'kali' or 'whonix'"
    exit 1
    ;;
esac

qvm-start $LABEL && echo "🖥️ $LABEL spawned with self-destruct protocol"
