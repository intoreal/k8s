#!/bin/bash

echo "🔑 Creating a new token for joining the cluster..."

# 토큰 생성 및 결과를 변수에 저장
JOIN_COMMAND=$(sudo kubeadm token create --print-join-command)

echo ""
echo "sudo $JOIN_COMMAND"

echo "🔑 Please run the join command on the worker nodes."
