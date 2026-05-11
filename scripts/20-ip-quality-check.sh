#!/bin/bash

source "$(dirname "$0")/../utils/colors.sh"
source "$(dirname "$0")/../utils/menu.sh"
source "$(dirname "$0")/../utils/detect-system.sh"

ip_quality_check() {
    print_title "IP 质量检测"

    local os=$(detect_os)

    case $os in
        ubuntu|debian|macos)
            print_info "正在执行 IP 质量检测..."
            echo ""
            bash <(curl -Ls IP.Check.Place)
            ;;
        *)
            print_error "不支持的系统"
            ;;
    esac

    pause_prompt
}

ip_quality_check
