#!/bin/bash

# 从 run.sh 调用时工具函数已通过 export -f 继承；单独执行时从云端加载
if ! declare -f print_title &>/dev/null; then
    RAW_BASE="${RAW_BASE:-https://raw.githubusercontent.com/Maybe404/kits/main}"
    _T=$(mktemp -d); trap "rm -rf $_T" EXIT INT TERM
    curl -fsSL "$RAW_BASE/utils/colors.sh"       -o "$_T/c.sh" || exit 1
    curl -fsSL "$RAW_BASE/utils/menu.sh"          -o "$_T/m.sh" || exit 1
    curl -fsSL "$RAW_BASE/utils/detect-system.sh" -o "$_T/d.sh" || exit 1
    source "$_T/c.sh"; source "$_T/m.sh"; source "$_T/d.sh"
fi

install_singbox() {
    print_title "Sing-box 安装"

    local os=$(detect_os)
    local choice

    case $os in
        ubuntu|debian)
            print_menu_item "1" "独立脚本安装"
            print_menu_item "2" "全家桶安装"
            echo ""
            get_user_choice 2
            local choice=$MENU_CHOICE

            if [ "$choice" == "1" ]; then
                print_info "使用独立脚本安装..."
                wget -N -O /root/singbox.sh https://raw.githubusercontent.com/qiuxiuya/qiuxiuya/main/VPS/singbox.sh && chmod +x /root/singbox.sh && ln -sf /root/singbox.sh /usr/local/bin/singbox && bash /root/singbox.sh
            elif [ "$choice" == "2" ]; then
                print_info "使用全家桶安装..."
                bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/sing-box/main/sing-box.sh)
            else
                print_error "无效选择"
            fi
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

install_singbox
