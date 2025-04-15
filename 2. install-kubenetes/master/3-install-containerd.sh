#!/bin/bash

echo "🛠  Installing containerd..."

# containerd 설치
sudo apt install -y containerd

# containerd 기본 설정 파일 생성
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml > /dev/null
sudo cp /etc/containerd/config.toml /etc/containerd/config.toml.bak

# containerd systemd cgroup 사용 설정
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
sudo sed -i 's|\(sandbox_image *= *\).*|\1"registry.k8s.io/pause:3.10"|' /etc/containerd/config.toml

# containerd 재시작
sudo systemctl restart containerd
sudo systemctl enable containerd

echo "✅ Containerd has been installed and configured."

