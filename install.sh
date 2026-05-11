#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

source "$SCRIPT_DIR/utils/colors.sh"
source "$SCRIPT_DIR/utils/menu.sh"
source "$SCRIPT_DIR/utils/detect-system.sh"

# 菜单选项数组
MENU_OPTIONS_BASIC=(
    "查看本机 IP"
    "检查端口占用"
    "检查容器"
    "检查网络出口 IP"
    "检查 DNS"
)

MENU_OPTIONS_SYSTEM=(
    "系统更新 & 安装必备应用"
    "一键获取 root 权限"
    "一键 ACME 申请证书"
    "ipblock 屏蔽国内访问"
    "SubStore 安装"
)

MENU_OPTIONS_NETWORK=(
    "互联网延迟测试"
    "回程路由检测"
    "流媒体区域限制检测"
    "融合怪检测"
    "网络质量检测"
    "IP 质量检测"
    "大包检测 (1024 字节)"
    "小包检测 (12 字节)"
)

MENU_OPTIONS_VPS=(
    "3x-ui 安装"
    "Hysteria 2 (Hy2) 安装"
    "Sing-box 安装"
    "1Panel 面板安装"
    "Snell 安装"
    "Shadowsocks-Rust (ss) 安装"
    "Reality (V2Ray) 安装"
    "科技 Lion 安装"
    "SubStore Docker 安装 (不带通知)"
)

# 显示主菜单
show_main_menu() {
    local os=$(detect_os)
    local os_name=$(get_os_display_name "$os")

    print_title "VPS 一键脚本管理器"

    echo -e "${CYAN}当前系统: ${WHITE}${os_name}${NC}"
    echo ""

    echo -e "${PURPLE}=== 基础检测 ===${NC}"
    local i=1
    for option in "${MENU_OPTIONS_BASIC[@]}"; do
        print_menu_item "$i" "$option"
        ((i++))
    done

    echo ""
    echo -e "${PURPLE}=== 系统管理 ===${NC}"
    for option in "${MENU_OPTIONS_SYSTEM[@]}"; do
        print_menu_item "$i" "$option"
        ((i++))
    done

    echo ""
    echo -e "${PURPLE}=== 网络测试 ===${NC}"
    for option in "${MENU_OPTIONS_NETWORK[@]}"; do
        print_menu_item "$i" "$option"
        ((i++))
    done

    echo ""
    echo -e "${PURPLE}=== VPS 工具 ===${NC}"
    for option in "${MENU_OPTIONS_VPS[@]}"; do
        print_menu_item "$i" "$option"
        ((i++))
    done

    echo ""
    echo -e "${RED}[0]${NC} 退出"
    echo ""
}

# 执行选中的脚本
execute_script() {
    local choice=$1
    local script=""

    case $choice in
        1) script="scripts/01-show-ip.sh" ;;
        2) script="scripts/02-check-ports.sh" ;;
        3) script="scripts/03-check-containers.sh" ;;
        4) script="scripts/04-check-outgoing-ip.sh" ;;
        5) script="scripts/05-check-dns.sh" ;;
        6) script="scripts/06-system-update.sh" ;;
        7) script="scripts/07-get-root.sh" ;;
        8) script="scripts/08-acme-cert.sh" ;;
        9) script="scripts/09-ipblock.sh" ;;
        10) script="scripts/10-substore.sh" ;;
        11) script="scripts/11-network-latency-test.sh" ;;
        12) script="scripts/12-trace-route-test.sh" ;;
        13) script="scripts/13-streaming-media-check.sh" ;;
        14) script="scripts/14-3x-ui.sh" ;;
        15) script="scripts/15-hy2-install.sh" ;;
        16) script="scripts/16-singbox-install.sh" ;;
        17) script="scripts/17-1panel-install.sh" ;;
        18) script="scripts/18-ecs-test.sh" ;;
        19) script="scripts/19-network-quality-check.sh" ;;
        20) script="scripts/20-ip-quality-check.sh" ;;
        21) script="scripts/21-snell-install.sh" ;;
        22) script="scripts/22-shadowsocks-install.sh" ;;
        23) script="scripts/23-reality-install.sh" ;;
        24) script="scripts/24-kejilion-install.sh" ;;
        25) script="scripts/25-substore-docker.sh" ;;
        26) script="scripts/26-packet-size-test-large.sh" ;;
        27) script="scripts/27-packet-size-test-small.sh" ;;
        *)
            print_error "无效选择"
            return 1
            ;;
    esac

    if [ -f "$script" ]; then
        chmod +x "$script"
        bash "$script"
        return 0
    else
        print_error "脚本文件不存在: $script"
        pause_prompt
        return 1
    fi
}

# 主循环
main() {
    while true; do
        show_main_menu

        local total_options=$((${#MENU_OPTIONS_BASIC[@]} + ${#MENU_OPTIONS_SYSTEM[@]} + ${#MENU_OPTIONS_NETWORK[@]} + ${#MENU_OPTIONS_VPS[@]}))
        get_user_choice $total_options
        local choice=$MENU_CHOICE

        if [ "$choice" == "0" ]; then
            print_info "感谢使用，再见！"
            exit 0
        fi

        execute_script "$choice"
    done
}

# 检查系统
if [ "$(detect_os)" == "unknown" ]; then
    print_error "不支持的系统"
    exit 1
fi

main
