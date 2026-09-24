#!/usr/bin/env bash
set -euo pipefail

# Move to p1, regardless of where the script was launched.
cd "$(dirname "${BASH_SOURCE[0]}")/.."

# Restrict newly created files to the current user.
umask 077

# Start and provision the server first.
vagrant up ayelasefS --provider=libvirt --provision

# Retrieve the token without displaying it.
vagrant ssh ayelasefS -c \
    "sudo cat /var/lib/rancher/k3s/server/node-token" \
    > .vagrant/k3s-node-token.tmp

# Stop if the downloaded file is empty.
test -s .vagrant/k3s-node-token.tmp

# Replace the local token only after retrieval succeeds.
mv .vagrant/k3s-node-token.tmp .vagrant/k3s-node-token

# Upload the token and provision the worker.
vagrant up ayelasefSW --provider=libvirt --provision

# Display the resulting cluster.
vagrant ssh ayelasefS -c "sudo kubectl get nodes -o wide"
