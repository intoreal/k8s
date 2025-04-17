#!/bin/bash

set -e

IMAGE_NAME="nginx-gateway"
CONTAINER_NAME="nginx-gateway"

echo "📦 Docker 이미지 빌드 시작: $IMAGE_NAME"
docker build -t $IMAGE_NAME .

# 기존 컨테이너가 있으면 삭제
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "🧹 기존 컨테이너 제거: $CONTAINER_NAME"
    docker rm -f $CONTAINER_NAME
fi

echo "🚀 컨테이너 실행: $CONTAINER_NAME"
docker run -d \
  --name $CONTAINER_NAME \
  -p 80:80 \
  -p 443:443 \
  --add-host=host.docker.internal:host-gateway \
  $IMAGE_NAME

echo "✅ 완료! Nginx Gateway 실행 중..."
echo "   ➤ http://localhost → 쿠버네티스 NodePort 30080"
echo "   ➤ https://localhost → 쿠버네티스 NodePort 30443"

