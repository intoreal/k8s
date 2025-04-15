#!/bin/bash

echo "Configuring UFW for Kubernetes worker node..."

# kubelet API
sudo ufw allow 10250/tcp   # kubelet API

# NodePort 서비스용 포트 범위
sudo ufw allow 30000:32767/tcp  # NodePort 서비스

echo "UFW rules for Kubernetes worker node have been added."


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
