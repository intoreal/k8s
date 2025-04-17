#!/bin/bash

echo "🔧 Local Path Provisioner 설치를 시작합니다..."
echo "👉 Rancher의 Local Path Provisioner를 클러스터에 적용 중입니다."
echo ""
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
echo ""
if [ $? -eq 0 ]; then
    echo "✅ 설치가 완료되었습니다!"
    echo "📦 Local Path Provisioner가 성공적으로 클러스터에 적용되었습니다."
else
    echo "❌ 설치 중 오류가 발생했습니다. 로그를 확인해 주세요."
fi

echo ""
echo "🔑 이제 스토리지 클래스를 사용할 수 있습니다."

echo ""
echo "🔧 스토리지 클래스 목록을 확인합니다..."
kubectl get storageclass

