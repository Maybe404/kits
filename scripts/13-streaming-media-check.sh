#!/bin/bash

source "$(dirname "$0")/../utils/colors.sh"
source "$(dirname "$0")/../utils/menu.sh"
source "$(dirname "$0")/../utils/detect-system.sh"

streaming_media_check() {
    print_title "流媒体区域限制检测"

    local os=$(detect_os)

    case $os in
        ubuntu|debian|macos)
            print_info "正在执行流媒体检测..."
            echo ""
            bash <(curl -L -s https://raw.githubusercontent.com/lmc999/RegionRestrictionCheck/main/check.sh)
            ;;
        *)
            print_error "不支持的系统"
            ;;
    esac

    pause_prompt
}

streaming_media_check
