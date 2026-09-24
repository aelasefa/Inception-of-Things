#!/bin/env bash
set -euo pipefail

apt-get update
apt-get install -y curl ca-certificates

curl -fsSL https://get.k3s.io -o /tmp/install-k3s.sh

INSTALL_K3S_VERSION="v1.36.4+k3s1" \
sh /tmp/install-k3s.sh server \
    --node-name ayelasefs \
    --node-ip 192.168.56.110 \
    --advertise-address 192.168.56.110 \
    --flannel-iface ens6
