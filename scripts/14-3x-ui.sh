#!/bin/bash

source "$(dirname "$0")/../utils/colors.sh"
source "$(dirname "$0")/../utils/menu.sh"
source "$(dirname "$0")/../utils/detect-system.sh"

install_3x_ui() {
    print_title "3x-ui 安装"

    local os=$(detect_os)
    local choice

    case $os in
        ubuntu|debian)
            print_menu_item "1" "全球源"
            print_menu_item "2" "国内源"
            echo ""
            get_user_choice 2
            local choice=$MENU_CHOICE

            if [ "$choice" == "1" ]; then
                print_info "使用全球源安装..."
                bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)
            elif [ "$choice" == "2" ]; then
                print_info "使用国内源安装..."
                bash <(curl -Ls http://3x-ui.xkig.cn/install.sh)
            else
                print_error "无效选择"
            fi
            ;;
        macos)
            print_error "此脚本不支持 macOS（3x-ui 仅适用于服务器）"
            ;;
        *)
            print_error "不支持的系统"
            ;;
    esac

    pause_prompt
}

install_3x_ui
