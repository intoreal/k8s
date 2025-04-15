#!/bin/bash

echo "🛠  Disabling swap..."

# 메모리 swap 비활성화
free -h
swapoff -a 
sudo sed -i '/ swap / s/^/#/' /etc/fstab

echo "✅ Swap has been disabled."

