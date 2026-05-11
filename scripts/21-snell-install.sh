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

install_snell() {
    print_title "Snell 安装"

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
            wget -O snell.sh --no-check-certificate https://git.io/Snell.sh && chmod +x snell.sh && ./snell.sh
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

install_snell
