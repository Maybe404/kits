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

ecs_test() {
    print_title "融合怪 (ECS 综合检测)"

    local os=$(detect_os)

    case $os in
        ubuntu|debian)
            print_info "正在执行融合怪检测..."
            echo ""
            bash <(wget -qO- --no-check-certificate https://gitlab.com/spiritysdx/za/-/raw/main/ecs.sh)
            ;;
        macos)
            print_error "此脚本不支持 macOS（融合怪是 VPS 综合跑分工具）"
            ;;
        *)
            print_error "不支持的系统"
            ;;
    esac

    pause_prompt
}

ecs_test
