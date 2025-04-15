#!/bin/bash

# 🎯 원본 YAML 경로
YAML_FILE="6-install-ingress-nginx-controller-baremetal.yaml"
TMP_FILE="tmp-nginx-ingress.yaml"

# 🌐 사용자 입력 받기
read -p "🔢 80 포트 접근 시 포워딩할 NodePort 번호 (기본값: 30080): " HTTP_PORT
HTTP_PORT=${HTTP_PORT:-30080}

read -p "🔒 443 포트 접근 시 포워딩할 NodePort 번호 (기본값: 30443): " HTTPS_PORT
HTTPS_PORT=${HTTPS_PORT:-30443}

# 📄 YAML 복사
cp "$YAML_FILE" "$TMP_FILE"

# 🔧 nodePort 숫자만 변경 (주석은 그대로 유지)
# http 포트 변경
sed -i '/# nodePort will be here(http)/!b;n;s/^ *nodePort: [0-9]\+/    nodePort: '"$HTTP_PORT"'/' "$TMP_FILE"

# https 포트 변경
sed -i '/# nodePort will be here(https)/!b;n;s/^ *nodePort: [0-9]\+/    nodePort: '"$HTTPS_PORT"'/' "$TMP_FILE"

# 🚀 적용
echo "📦 ingress-nginx 컨트롤러를 설치 중입니다..."
kubectl apply -f "$TMP_FILE"

# 🧹 정리
rm "$TMP_FILE"

echo "✅ 설치 완료! (80 → $HTTP_PORT / 443 → $HTTPS_PORT)"
