#!/bin/bash

source "$(dirname "$0")/../utils/colors.sh"
source "$(dirname "$0")/../utils/menu.sh"
source "$(dirname "$0")/../utils/detect-system.sh"

network_latency_test() {
    print_title "互联网延迟测试"

    local os=$(detect_os)

    case $os in
        ubuntu|debian)
            print_info "正在执行网络延迟测试..."
            echo ""
            bash <(wget -qO- https://raw.githubusercontent.com/danger-dream/network-latency-tester/main/latency.sh)
            ;;
        macos)
            print_info "正在执行网络延迟测试..."
            echo ""
            bash <(curl -sL https://raw.githubusercontent.com/danger-dream/network-latency-tester/main/latency.sh)
            ;;
        *)
            print_error "不支持的系统"
            ;;
    esac

    pause_prompt
}

network_latency_test
