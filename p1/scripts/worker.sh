#!/bin/env bash
set -euo pipefail

apt-get update
apt-get install -y curl ca-certificates

install -d -m 700 /etc/rancher/k3s

install -m 600 /home/vagrant/k3s-node-token \
    /etc/rancher/k3s/join-token

rm -f /home/vagrant/k3s-node-token

curl -fsSL https://get.k3s.io -o /tmp/install-k3s.sh

INSTALL_K3S_VERSION="v1.36.4+k3s1" \
sh /tmp/install-k3s.sh agent \
    --server https://192.168.56.110:6443 \
    --token-file /etc/rancher/k3s/join-token \
    --node-name ayelasefsw \
    --node-ip 192.168.56.111 \
    --flannel-iface ens6
