#!/bin/bash

source "$(dirname "$0")/../utils/colors.sh"
source "$(dirname "$0")/../utils/menu.sh"
source "$(dirname "$0")/../utils/detect-system.sh"

show_ip() {
    print_title "本机 IP 地址"

    local os=$(detect_os)

    case $os in
        ubuntu|debian)
            hostname -I
            ;;
        macos)
            ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}'
            ;;
        *)
            print_error "不支持的系统"
            return 1
            ;;
    esac

    pause_prompt
}

show_ip
