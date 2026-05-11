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
