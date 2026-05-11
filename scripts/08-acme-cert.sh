#!/bin/bash

source "$(dirname "$0")/../utils/colors.sh"
source "$(dirname "$0")/../utils/menu.sh"
source "$(dirname "$0")/../utils/detect-system.sh"

acme_cert() {
    print_title "一键 ACME 申请证书"

    local os=$(detect_os)

    case $os in
        ubuntu|debian)
            print_info "正在下载并执行脚本..."
            wget -N --no-check-certificate https://raw.githubusercontent.com/Misaka-blog/acme-script/main/acme.sh && bash acme.sh
            ;;
        macos)
            print_info "正在下载并执行脚本..."
            curl -O https://raw.githubusercontent.com/Misaka-blog/acme-script/main/acme.sh && bash acme.sh
            ;;
        *)
            print_error "不支持的系统"
            ;;
    esac

    pause_prompt
}

acme_cert
