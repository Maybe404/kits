#!/bin/bash

source "$(dirname "$0")/../utils/colors.sh"
source "$(dirname "$0")/../utils/menu.sh"
source "$(dirname "$0")/../utils/detect-system.sh"

check_dns() {
    print_title "检查 DNS 配置"

    local os=$(detect_os)

    case $os in
        ubuntu|debian)
            print_info "显示 DNS 配置..."
            echo ""
            cat /etc/resolv.conf
            ;;
        macos)
            print_info "显示 DNS 配置..."
            echo ""
            scutil --dns
            ;;
        *)
            print_error "不支持的系统"
            return 1
            ;;
    esac

    pause_prompt
}

check_dns
