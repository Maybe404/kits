#!/bin/bash

source "$(dirname "$0")/../utils/colors.sh"
source "$(dirname "$0")/../utils/menu.sh"
source "$(dirname "$0")/../utils/detect-system.sh"

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
