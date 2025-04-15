#!/bin/bash
# Mutual TLS setup
openssl req -x509 -newkey ed25519 -days 365 -nodes \
  -keyout /ghost-stack/vault/certs/mtls.key \
  -out /ghost-stack/vault/certs/mtls.crt \
  -subj "/CN=Ghost Stack Mutual TLS"

qm set 9000 --sshkey /ghost-stack/vault/certs/mtls.crt
qvm-run --pass-io sys-firewall "mkdir -p /etc/qubes/pki && cat > /etc/qubes/pki/ghost-mtls.crt" < /ghost-stack/vault/certs/mtls.crt
