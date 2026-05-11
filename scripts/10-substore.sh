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
