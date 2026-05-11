#!/bin/bash

source "$(dirname "$0")/../utils/colors.sh"
source "$(dirname "$0")/../utils/menu.sh"
source "$(dirname "$0")/../utils/detect-system.sh"

check_ports() {
    print_title "检查端口占用"

    local os=$(detect_os)

    case $os in
        ubuntu|debian)
            print_info "显示所有监听中的端口..."
            echo ""
            netstat -nultp
            ;;
        macos)
            print_info "显示所有监听中的端口..."
            echo ""
            netstat -an | grep LISTEN
            ;;
        *)
            print_error "不支持的系统"
            return 1
            ;;
    esac

    pause_prompt
}

check_ports
