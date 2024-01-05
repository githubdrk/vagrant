#!/bin/bash

# Update package lists and install dependencies
apt-get update && apt-get install -y apt-transport-https curl

# Add Kubernetes apt repository
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

# Update package lists and install Kubernetes components
apt-get update && apt-get install -y kubelet kubectl

# Join the Kubernetes cluster using the provided join command
# Replace this with the actual join command displayed by 'kubeadm token create' on the master node
kubeadm join <join_command>

# Enable kubelet service and auto-start on reboot
systemctl enable kubelet && systemctl start kubelet
