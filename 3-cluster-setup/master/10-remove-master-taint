#!/bin/bash

# 노드 이름 자동 추출
NODE_NAME=$(kubectl get nodes --no-headers -o custom-columns=":metadata.name")

echo "Taint 제거 중: $NODE_NAME"

# 마스터 노드의 taint 제거
kubectl taint nodes "$NODE_NAME" node-role.kubernetes.io/control-plane- 

echo "완료되었습니다. 이제 마스터 노드에도 Pod이 스케줄될 수 있습니다."

