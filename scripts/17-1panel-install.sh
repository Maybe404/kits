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

install_1panel() {
    print_title "1Panel 服务器管理面板安装"

    local os=$(detect_os)

    case $os in
        ubuntu)
            print_info "使用 1Panel 官方脚本安装（Ubuntu）..."
            sudo bash <(curl -sSL https://resource.fit2cloud.com/1panel/package/quick_start.sh)
            ;;
        debian)
            print_info "使用 1Panel 官方脚本安装（Debian）..."
            bash <(curl -sSL https://resource.fit2cloud.com/1panel/package/quick_start.sh)
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
