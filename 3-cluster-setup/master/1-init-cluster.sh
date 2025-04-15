#!/bin/bash

echo "🧠 Available IP addresses on this machine:"
hostname -I

echo ""
read -p "👉 Enter the IP address to advertise as the Kubernetes API server (master node IP): " MASTER_IP

# 기본값 제안
read -p "👉 Enter Pod network CIDR [default: 10.0.0.0/16, just press Enter to accept]: " POD_CIDR
POD_CIDR=${POD_CIDR:-10.0.0.0/16}


echo ""
echo "🚀 Initializing Kubernetes cluster with the following settings:"
echo "   🖥️  API Server Advertise Address: $MASTER_IP"
echo "   🕸️  Pod Network CIDR: $POD_CIDR"
echo ""

# 확인 후 실행
read -p "Proceed with kubeadm init? [y/N]: " CONFIRM
if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
    echo "❌ Aborted by user."
    exit 1
fi

# kubeadm init 명령 실행
sudo kubeadm init \
  --apiserver-advertise-address="$MASTER_IP" \
  --pod-network-cidr="$POD_CIDR" \
  --cri-socket=unix:///run/containerd/containerd.sock

echo ""
echo "✅ kubeadm init completed."

echo ""
echo "📁 Setting up kubeconfig for the current user..."

# 설정 디렉토리 생성
echo "📂 Creating Kubernetes config directory at ~/.kube"
mkdir -p $HOME/.kube

# 마스터 인증 정보 복사
echo "🔐 Copying admin kubeconfig to ~/.kube/config"
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

# 일반 사용자에게 권한 부여
echo "🔧 Adjusting ownership so current user can access the config"
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "✅ kubeconfig has been set up. You can now use kubectl as a regular user."
