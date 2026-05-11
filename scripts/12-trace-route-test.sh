#!/bin/bash

source "$(dirname "$0")/../utils/colors.sh"
source "$(dirname "$0")/../utils/menu.sh"
source "$(dirname "$0")/../utils/detect-system.sh"

trace_route_test() {
    print_title "回程路由检测"

    local os=$(detect_os)

    case $os in
        ubuntu|debian)
            print_info "正在执行回程路由检测..."
            echo ""
            wget https://raw.githubusercontent.com/vpsxb/testrace/main/testrace.sh -O testrace.sh && bash testrace.sh
            ;;
        macos)
            print_error "此脚本不支持 macOS（回程路由检测仅适用于服务器）"
            ;;
        *)
            print_error "不支持的系统"
            ;;
    esac

    pause_prompt
}

trace_route_test
