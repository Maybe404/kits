#!/bin/bash

source "$(dirname "$0")/../utils/colors.sh"
source "$(dirname "$0")/../utils/menu.sh"
source "$(dirname "$0")/../utils/detect-system.sh"

substore_install() {
    print_title "SubStore 安装"

    local os=$(detect_os)

    case $os in
        ubuntu|debian|macos)
            print_info "正在安装 SubStore..."
            curl -sSL https://sub-store-org.github.io/resource/ssm/install.sh | bash
            print_success "安装完成"
            ;;
        *)
            print_error "不支持的系统"
            ;;
    esac

    pause_prompt
}

substore_install
