#!/bin/bash

source "$(dirname "$0")/../utils/colors.sh"
source "$(dirname "$0")/../utils/menu.sh"
source "$(dirname "$0")/../utils/detect-system.sh"

system_update() {
    print_title "系统更新 & 安装必备应用"

    local os=$(detect_os)

    print_warning "此操作需要 root/sudo 权限，请确认您已具有权限"
    echo ""

    if ! confirm_prompt "是否继续?"; then
        print_info "已取消"
        pause_prompt
        return 0
    fi

    case $os in
        ubuntu|debian)
            print_info "开始更新系统和安装必备应用..."
            apt update -y && apt upgrade -y && apt dist-upgrade -y && apt full-upgrade -y && apt autoremove -y && apt install -y curl vim wget sudo net-tools unzip iperf3
            print_success "更新完成"
            ;;
        macos)
            print_info "检查 Homebrew..."
            if ! command -v brew &> /dev/null; then
                print_info "安装 Homebrew..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            fi

            print_info "更新 Homebrew 索引..."
            brew update

            print_info "安装必备工具..."
            brew install curl vim wget unzip iperf3

            print_warning "如需升级所有已安装的包请手动执行: brew upgrade"
            print_success "完成"
            ;;
        *)
            print_error "不支持的系统"
            pause_prompt
            return 1
            ;;
    esac

    pause_prompt
}

system_update
