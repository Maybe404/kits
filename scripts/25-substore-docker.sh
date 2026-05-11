#!/bin/bash

source "$(dirname "$0")/../utils/colors.sh"
source "$(dirname "$0")/../utils/menu.sh"
source "$(dirname "$0")/../utils/detect-system.sh"

substore_docker_install() {
    print_title "SubStore Docker 安装 (不带通知)"

    local os=$(detect_os)

    local data_dir
    case $os in
        ubuntu|debian)
            data_dir="/root/sub-store-data"
            ;;
        macos)
            data_dir="$HOME/sub-store-data"
            ;;
        *)
            print_error "不支持的系统"
            pause_prompt
            return 1
            ;;
    esac

    if ! command -v docker &> /dev/null; then
        print_error "Docker 未安装"
        pause_prompt
        return 1
    fi

    print_info "正在安装 SubStore Docker..."
    print_info "数据目录: $data_dir"
    echo ""
    docker run -it -d --restart=always \
      -e "SUB_STORE_CRON=0 0 * * *" \
      -e SUB_STORE_FRONTEND_BACKEND_PATH=/YvJx5UaHrzqFnEp3LKMC \
      -p 3001:3001 \
      -v "$data_dir":/opt/app/data \
      --name sub-store xream/sub-store

    print_success "SubStore Docker 安装完成"
    print_info "访问地址: http://localhost:3001/YvJx5UaHrzqFnEp3LKMC"

    pause_prompt
}

substore_docker_install
