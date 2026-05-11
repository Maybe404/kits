#!/bin/bash

source "$(dirname "$0")/../utils/colors.sh"
source "$(dirname "$0")/../utils/menu.sh"
source "$(dirname "$0")/../utils/detect-system.sh"

get_root() {
    print_title "一键获取 root 权限"

    local os=$(detect_os)

    case $os in
        ubuntu|debian)
            print_warning "此脚本会尝试获取 root 权限"
            echo ""

            if ! confirm_prompt "是否继续?"; then
                print_info "已取消"
                pause_prompt
                return 0
            fi

            print_info "正在下载并执行脚本..."
            wget -N https://gitlab.com/rwkgyg/vpsroot/raw/main/root.sh && bash root.sh
            ;;
        macos)
            print_error "此脚本不支持 macOS"
            ;;
        *)
            print_error "不支持的系统"
            ;;
    esac

    pause_prompt
}

get_root
