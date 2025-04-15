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

