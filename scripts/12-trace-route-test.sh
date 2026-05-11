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

trace_route_test() {
    print_title "回程路由检测"

    local os=$(detect_os)

    case $os in
        ubuntu|debian)
            print_info "正在执行回程路由检测..."
            echo ""
            wget https://raw.githubusercontent.com/vpsxb/testrace/main/testrace.sh -O testrace.sh && bash testrace.sh
            ;;
        macos)
            print_error "此脚本不支持 macOS（回程路由检测仅适用于服务器）"
            ;;
        *)
            print_error "不支持的系统"
            ;;
    esac

    pause_prompt
}

trace_route_test
