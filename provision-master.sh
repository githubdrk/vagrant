#!/bin/bash

# Update package lists and install dependencies
apt-get update && apt-get install -y apt-transport-https curl

# Add Kubernetes apt repository
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

# Update package lists and install Kubernetes components
apt-get update && apt-get install -y kubelet kubeadm kubectl

# Disable swap (required for kubeadm)
swapoff -a
sed -i '/swap/d' /etc/fstab

# Initialize the master node with recommended settings
kubeadm init \
    --pod-network-cidr=10.244.0.0/16 \
    --apiserver-advertise-address=192.168.56.10  # Replace with master node's IP

# Make kubectl work for non-root users
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

# Install a pod network (e.g., Calico)
kubectl apply -f https://docs.projectcalico.org/v3.23/manifests/calico.yaml

# Display join command for worker nodes
kubeadm token create --print-join-command
