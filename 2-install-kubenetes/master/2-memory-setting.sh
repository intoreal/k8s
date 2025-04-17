#!/bin/bash

echo "🛠  Disabling memory swap..."

# 메모리 swap 비활성화
sudo free -h
sudo swapoff -a 
sudo sed -i '/ swap / s/^/#/' /etc/fstab

echo "✅ Swap has been disabled."

