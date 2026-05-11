#!/bin/bash

source "$(dirname "$0")/../utils/colors.sh"
source "$(dirname "$0")/../utils/menu.sh"
source "$(dirname "$0")/../utils/detect-system.sh"

install_1panel() {
    print_title "1Panel 服务器管理面板安装"

    local os=$(detect_os)

    case $os in
        ubuntu)
            print_info "使用 1Panel 官方脚本安装（Ubuntu）..."
            curl -sSL https://resource.fit2cloud.com/1panel/package/quick_start.sh -o quick_start.sh && sudo bash quick_start.sh
            ;;
        debian)
            print_info "使用 1Panel 官方脚本安装（Debian）..."
            curl -sSL https://resource.fit2cloud.com/1panel/package/quick_start.sh -o quick_start.sh && bash quick_start.sh
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

install_1panel
