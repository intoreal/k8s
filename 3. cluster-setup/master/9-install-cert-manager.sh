#!/bin/bash

echo "🔐 cert-manager 설치를 시작합니다..."
echo "📥 최신 cert-manager 매니페스트를 다운로드하여 적용 중입니다."

kubectl apply -f https://github.com/cert-manager/cert-manager/releases/latest/download/cert-manager.yaml

if [ $? -eq 0 ]; then
    echo "✅ cert-manager 설치가 완료되었습니다!"
else
    echo "❌ cert-manager 설치 중 오류가 발생했습니다. 로그를 확인해 주세요."
    exit 1
fi

# 📨 사용자 이메일 입력
read -p "📧 인증서 관련 알림을 받을 이메일 주소를 입력하세요: " USER_EMAIL

if [ -z "$USER_EMAIL" ]; then
  echo "❌ 이메일 주소가 입력되지 않았습니다. 종료합니다."
  exit 1
fi

# 📄 cluster-issuer YAML 파일
ISSUER_FILE="8-cluster-issuer.yaml"
TMP_FILE="tmp-cluster-issuer.yaml"

# 📦 이메일 주소 교체
cp "$ISSUER_FILE" "$TMP_FILE"
sed -i "s/email: .*/email: $USER_EMAIL/" "$TMP_FILE"

# 🚀 ClusterIssuer 적용
echo "📄 ClusterIssuer 리소스를 클러스터에 적용 중입니다..."
kubectl apply -f "$TMP_FILE"

# 🧹 임시 파일 삭제
rm "$TMP_FILE"

echo "✅ ClusterIssuer 적용이 완료되었습니다! (이메일: $USER_EMAIL)"

echo "🔧 아래 어노테이션을 **Ingress 리소스**에 추가하세요:"
echo ""
echo "apiVersion: networking.k8s.io/v1"
echo "kind: Ingress"
echo "metadata:"
echo "  name: your-ingress-name"
echo "  annotations:"
echo "    cert-manager.io/cluster-issuer: letsencrypt-cluster-issuer"
echo ""
