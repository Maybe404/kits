#!/bin/bash

source "$(dirname "$0")/../utils/colors.sh"
source "$(dirname "$0")/../utils/menu.sh"
source "$(dirname "$0")/../utils/detect-system.sh"

check_outgoing_ip() {
    print_title "检查网络优先出口 IP"

    if ! command -v curl &> /dev/null; then
        print_error "curl 未安装"
        pause_prompt
        return 1
    fi

    print_info "获取出口 IP..."
    echo ""
    curl ip.p3terx.com
    echo ""

    pause_prompt
}

check_outgoing_ip
