#!/bin/bash

echo ""
echo "🌐 Installing Calico as the Pod network add-on..."

# Calico 설치
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.0/manifests/calico.yaml

echo "✅ Calico has been successfully applied."
echo "⏳ It may take a few moments for all Calico pods to become ready."
