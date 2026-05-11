#!/bin/bash

source "$(dirname "$0")/../utils/colors.sh"
source "$(dirname "$0")/../utils/menu.sh"
source "$(dirname "$0")/../utils/detect-system.sh"

check_containers() {
    print_title "检查容器"

    if ! command -v docker &> /dev/null; then
        print_error "Docker 未安装"
        pause_prompt
        return 1
    fi

    print_info "显示所有容器..."
    echo ""
    docker ps -a

    pause_prompt
}

check_containers
