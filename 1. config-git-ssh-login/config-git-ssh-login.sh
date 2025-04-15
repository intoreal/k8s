#!/bin/bash

SSH_DIR="$HOME/.ssh"
CONFIG_FILE="$SSH_DIR/config"
KEY_FILE="$SSH_DIR/default"
KNOWN_HOSTS_FILE="$SSH_DIR/known_hosts"

# ~/.ssh 디렉토리 생성
if [ ! -d "$SSH_DIR" ]; then
    echo "Creating ~/.ssh directory..."
    mkdir -p "$SSH_DIR"
    chmod 700 "$SSH_DIR"
fi

# config 파일 생성 (없을 경우)
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Creating SSH config file..."
    touch "$CONFIG_FILE"
    chmod 600 "$CONFIG_FILE"
fi

# 사용자로부터 키 입력 받기
echo "Paste your private key (Press Ctrl+D when done):"
key_content=$(cat)
echo "$key_content" > "$KEY_FILE"
chmod 600 "$KEY_FILE"

# config 파일에 항목 추가 (기존에 동일 Host가 없을 경우)
if ! grep -q "Host github.com" "$CONFIG_FILE"; then
    echo -e "\nHost github.com" >> "$CONFIG_FILE"
    echo -e "\tHostName github.com" >> "$CONFIG_FILE"
    echo -e "\tUser git" >> "$CONFIG_FILE"
    echo -e "\tIdentityFile ~/.ssh/default" >> "$CONFIG_FILE"
    echo -e "\tIdentitiesOnly yes" >> "$CONFIG_FILE"
fi

# known_hosts에 github.com 추가
if ! ssh-keygen -F github.com > /dev/null; then
    echo "Adding github.com to known_hosts..."
    ssh-keyscan github.com >> "$KNOWN_HOSTS_FILE"
    chmod 644 "$KNOWN_HOSTS_FILE"
fi

# 최종 권한 설정 재확인
chmod 700 "$SSH_DIR"
chmod 600 "$KEY_FILE"
chmod 600 "$CONFIG_FILE"
[ -f "$KNOWN_HOSTS_FILE" ] && chmod 644 "$KNOWN_HOSTS_FILE"

echo "SSH setup for github.com is complete."
