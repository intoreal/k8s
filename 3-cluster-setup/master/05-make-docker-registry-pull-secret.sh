#!/bin/bash

echo "🔐 Docker Registry용 시크릿을 생성합니다."

# 사용자 입력 받기
read -p "📂 네임스페이스 (기본값: default): " NAMESPACE
NAMESPACE=${NAMESPACE:-default}

read -p "📦 Docker 서버 주소 (예: https://index.docker.io/v1/): " DOCKER_SERVER
read -p "👤 Docker 사용자 이름: " DOCKER_USERNAME
read -s -p "🔑 Docker 비밀번호: " DOCKER_PASSWORD
echo
read -p "📧 Docker 이메일: " DOCKER_EMAIL
read -p "📛 사용할 시크릿 이름 (기본값: private-docker-registry-login-secret): " SECRET_NAME
SECRET_NAME=${SECRET_NAME:-private-docker-registry-login-secret}
echo ""

# 시크릿 생성
kubectl create secret docker-registry "$SECRET_NAME" \
  --docker-server="$DOCKER_SERVER" \
  --docker-username="$DOCKER_USERNAME" \
  --docker-password="$DOCKER_PASSWORD" \
  --docker-email="$DOCKER_EMAIL" \
  --namespace="$NAMESPACE"

# 현재 imagePullSecrets 리스트 가져오기
EXISTING=$(kubectl get serviceaccount default -n "$NAMESPACE" -o json | jq -r '.imagePullSecrets[].name' 2>/dev/null)
echo ""

# 없으면 추가
if ! echo "$EXISTING" | grep -q "^$SECRET_NAME$"; then
  kubectl patch serviceaccount default \
    -n "$NAMESPACE" \
    --type='json' \
    -p="[{'op': 'add', 'path': '/imagePullSecrets/-', 'value': {'name': '$SECRET_NAME'}}]"
  echo "✅ $SECRET_NAME 시크릿이 default 서비스 어카운트에 추가되었습니다."
else
  echo "ℹ️ $SECRET_NAME 시크릿은 이미 설정되어 있습니다. 변경 없음."
fi

# 결과 출력
echo ""
if [ $? -eq 0 ]; then
  echo "✅ 시크릿 생성 완료!"
  echo "🔐 시크릿 이름: $SECRET_NAME"
else
  echo "❌ 시크릿 생성 실패. 입력 정보를 다시 확인해주세요."
fi
