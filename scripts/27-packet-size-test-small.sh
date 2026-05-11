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

packet_size_test_small() {
    print_title "小包检测 (广州电信 - 12 字节)"

    local os=$(detect_os)

    case $os in
        ubuntu|debian)
            if ! command -v nexttrace &> /dev/null; then
                print_error "nexttrace 未安装"
                print_info "请先安装 nexttrace"
                pause_prompt
                return 1
            fi

            print_info "正在执行小包检测..."
            echo ""
            nexttrace --tcp --psize 12 14.116.225.60 -p 80
            ;;
        macos|*)
            print_error "此脚本仅支持 Linux 系统"
            ;;
    esac

    pause_prompt
}

packet_size_test_small
