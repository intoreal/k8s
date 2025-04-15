#!/bin/bash

echo "Configuring UFW for Kubernetes control plane components..."

# Kubernetes API Server
sudo ufw allow 6443/tcp    # Kubernetes API Server

# etcd (클러스터 데이터 저장소)
sudo ufw allow 2379:2380/tcp  # etcd

# kubelet API
sudo ufw allow 10250/tcp   # kubelet API

# kube-scheduler
sudo ufw allow 10259/tcp   # kube-scheduler

# kube-controller-manager
sudo ufw allow 10257/tcp   # kube-controller-manager

echo "UFW rules for Kubernetes control plane have been added."


echo ""
echo "🛠  Enabling required kernel modules..."

# 커널 모듈 설정
cat << EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

# 커널 파라미터 설정
cat << EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# 모듈 즉시 로드
sudo modprobe overlay
sudo modprobe br_netfilter

# 커널 파라미터 즉시 적용
sudo sysctl --system

echo "✅ Kernel modules and sysctl settings for Kubernetes have been configured."