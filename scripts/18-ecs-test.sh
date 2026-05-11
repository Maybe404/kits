#!/bin/bash

source "$(dirname "$0")/../utils/colors.sh"
source "$(dirname "$0")/../utils/menu.sh"
source "$(dirname "$0")/../utils/detect-system.sh"

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
