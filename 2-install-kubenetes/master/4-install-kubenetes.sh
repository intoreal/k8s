#!/bin/bash

echo "🛠  Installing Kubernetes v1.32 components..."

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg 

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubectl kubeadm kubelet

echo "✅ Kubernetes components have been installed."

sudo apt-mark hold kubelet kubeadm kubectl

echo "✅ Kubernetes components have been marked as held."

# 현재 사용 중인 쉘 확인
CURRENT_SHELL=$(basename "$SHELL")

if [ "$CURRENT_SHELL" = "zsh" ]; then
    if ! grep -q "alias k=kubectl" ~/.zshrc; then
        echo "alias k=kubectl" >> ~/.zshrc
        echo "✅ kubectl alias has been added to ~/.zshrc"
    else
        echo "ℹ️ alias k=kubectl already exists in ~/.zshrc"
    fi
    
    source ~/.zshrc
else
    if ! grep -q "alias k=kubectl" ~/.bashrc; then
        echo "alias k=kubectl" >> ~/.bashrc
        echo "✅ kubectl alias has been added to ~/.bashrc"
    else
        echo "ℹ️ alias k=kubectl already exists in ~/.bashrc"
    fi
    
    source ~/.bashrc
fi

