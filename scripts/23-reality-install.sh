#!/bin/bash

source "$(dirname "$0")/../utils/colors.sh"
source "$(dirname "$0")/../utils/menu.sh"
source "$(dirname "$0")/../utils/detect-system.sh"

install_reality() {
    print_title "Reality (V2Ray) 安装"

    local os=$(detect_os)

    case $os in
        ubuntu|debian)
            print_warning "此脚本仅支持 Linux 系统"
            echo ""

            if ! confirm_prompt "是否继续?"; then
                print_info "已取消"
                pause_prompt
                return 0
            fi

            print_info "正在下载并执行脚本..."
            wget -P /root -N --no-check-certificate "https://raw.githubusercontent.com/mack-a/v2ray-agent/master/install.sh" && chmod 700 /root/install.sh && /root/install.sh
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

install_reality
