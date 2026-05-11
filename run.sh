#!/bin/bash

REPO_OWNER="Maybe404"
REPO_NAME="kits"
INSTALL_DIR="$HOME/.kits"

GREEN='\033[0;32m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m'

# 如果直接在项目目录里执行，跳过下载
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd)"
if [ -f "$SCRIPT_DIR/install.sh" ] && [ -d "$SCRIPT_DIR/utils" ]; then
    bash "$SCRIPT_DIR/install.sh"
    exit $?
fi

echo -e "${CYAN}准备脚本环境...${NC}"

# 优先用 git（增量更新），回退到 zip
if command -v git &> /dev/null; then
    if [ -d "$INSTALL_DIR/.git" ]; then
        echo -e "${CYAN}更新到最新版本...${NC}"
        git -C "$INSTALL_DIR" pull --quiet
    else
        echo -e "${CYAN}下载脚本...${NC}"
        git clone --depth=1 --quiet "https://github.com/$REPO_OWNER/$REPO_NAME.git" "$INSTALL_DIR"
    fi
elif command -v curl &> /dev/null; then
    echo -e "${CYAN}下载脚本...${NC}"
    curl -sSL "https://github.com/$REPO_OWNER/$REPO_NAME/archive/refs/heads/main.zip" -o /tmp/kits.zip
    mkdir -p "$INSTALL_DIR"
    unzip -q -o /tmp/kits.zip -d /tmp/
    cp -rf /tmp/${REPO_NAME}-main/. "$INSTALL_DIR/"
    rm -f /tmp/kits.zip && rm -rf /tmp/${REPO_NAME}-main
elif command -v wget &> /dev/null; then
    echo -e "${CYAN}下载脚本...${NC}"
    wget -q "https://github.com/$REPO_OWNER/$REPO_NAME/archive/refs/heads/main.zip" -O /tmp/kits.zip
    mkdir -p "$INSTALL_DIR"
    unzip -q -o /tmp/kits.zip -d /tmp/
    cp -rf /tmp/${REPO_NAME}-main/. "$INSTALL_DIR/"
    rm -f /tmp/kits.zip && rm -rf /tmp/${REPO_NAME}-main
else
    echo -e "${RED}错误：需要 git、curl 或 wget 之一${NC}"
    exit 1
fi

if [ ! -f "$INSTALL_DIR/install.sh" ]; then
    echo -e "${RED}下载失败，请检查网络${NC}"
    exit 1
fi

chmod +x "$INSTALL_DIR/install.sh"
chmod +x "$INSTALL_DIR/scripts/"*.sh 2>/dev/null

echo -e "${GREEN}就绪${NC}"
echo ""

bash "$INSTALL_DIR/install.sh"
