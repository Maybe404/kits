#!/bin/bash

source "$(dirname "$0")/../utils/colors.sh"
source "$(dirname "$0")/../utils/menu.sh"
source "$(dirname "$0")/../utils/detect-system.sh"

ipblock_install() {
    print_title "ipblock 屏蔽国内访问"

    local os=$(detect_os)

    case $os in
        ubuntu|debian)
            print_warning "此脚本需要 sudo 权限"
            echo ""

            if ! confirm_prompt "是否继续?"; then
                print_info "已取消"
                pause_prompt
                return 0
            fi

            print_info "正在下载并执行脚本..."
            sudo wget -O /usr/local/bin/ipblock https://raw.githubusercontent.com/Maybe404/VPS/main/ipblock.sh && sudo chmod +x /usr/local/bin/ipblock && sudo ipblock
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

ipblock_install
