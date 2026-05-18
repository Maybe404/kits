#!/bin/bash

RAW_BASE="https://raw.githubusercontent.com/Maybe404/kits/main"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd)"

# 本地执行（克隆仓库后直接运行）时使用本地文件，否则从云端加载
if [ -f "$SCRIPT_DIR/utils/colors.sh" ]; then
    source "$SCRIPT_DIR/utils/colors.sh"
    source "$SCRIPT_DIR/utils/menu.sh"
    source "$SCRIPT_DIR/utils/detect-system.sh"
else
    _T=$(mktemp -d)
    trap "rm -rf $_T" EXIT INT TERM
    echo "正在加载..."
    curl -fsSL "$RAW_BASE/utils/colors.sh"      -o "$_T/colors.sh"  || { echo "加载失败，请检查网络"; exit 1; }
    curl -fsSL "$RAW_BASE/utils/menu.sh"         -o "$_T/menu.sh"    || { echo "加载失败，请检查网络"; exit 1; }
    curl -fsSL "$RAW_BASE/utils/detect-system.sh" -o "$_T/detect.sh" || { echo "加载失败，请检查网络"; exit 1; }
    source "$_T/colors.sh"
    source "$_T/menu.sh"
    source "$_T/detect.sh"
fi

# 导出工具函数和变量给子脚本进程
export -f print_title print_separator print_success print_error print_warning print_info \
          print_menu_item pause_prompt confirm_prompt \
          detect_os get_os_display_name check_privileges get_user_choice
export RED GREEN YELLOW BLUE PURPLE CYAN WHITE GRAY NC BOLD DIM UNDERLINE \
       BG_RED BG_GREEN BG_BLUE BG_CYAN CHECK CROSS ARROW BULLET STAR MENU_CHOICE
export RAW_BASE SCRIPT_DIR

# ── 菜单选项 ─────────────────────────────────────────────────────────────────

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

# ── 菜单显示 ─────────────────────────────────────────────────────────────────

show_main_menu() {
    local os_name
    os_name=$(get_os_display_name "$(detect_os)")

    print_title "kits - 一键脚本"
    echo -e "${CYAN}当前系统: ${WHITE}${os_name}${NC}"
    echo ""

    echo -e "${PURPLE}=== 基础检测 ===${NC}"
    local i=1
    for opt in "${MENU_OPTIONS_BASIC[@]}";   do print_menu_item "$i" "$opt"; ((i++)); done

    echo ""
    echo -e "${PURPLE}=== 系统管理 ===${NC}"
    for opt in "${MENU_OPTIONS_SYSTEM[@]}";  do print_menu_item "$i" "$opt"; ((i++)); done

    echo ""
    echo -e "${PURPLE}=== 网络测试 ===${NC}"
    for opt in "${MENU_OPTIONS_NETWORK[@]}"; do print_menu_item "$i" "$opt"; ((i++)); done

    echo ""
    echo -e "${PURPLE}=== VPS 工具 ===${NC}"
    for opt in "${MENU_OPTIONS_VPS[@]}";     do print_menu_item "$i" "$opt"; ((i++)); done

    echo ""
    print_separator
    echo -e "${YELLOW}[u]${NC} 卸载 (清理本地残留)"
    echo -e "${RED}[0]${NC} 退出"
    echo ""
}

# ── 执行脚本 ─────────────────────────────────────────────────────────────────

execute_script() {
    local choice=$1
    local script=""

    case $choice in
        1)  script="scripts/01-show-ip.sh" ;;
        2)  script="scripts/02-check-ports.sh" ;;
        3)  script="scripts/03-check-containers.sh" ;;
        4)  script="scripts/04-check-outgoing-ip.sh" ;;
        5)  script="scripts/05-check-dns.sh" ;;
        6)  script="scripts/06-system-update.sh" ;;
        7)  script="scripts/07-get-root.sh" ;;
        8)  script="scripts/08-acme-cert.sh" ;;
        9)  script="scripts/09-ipblock.sh" ;;
        10) script="scripts/10-substore.sh" ;;
        11) script="scripts/11-network-latency-test.sh" ;;
        12) script="scripts/12-trace-route-test.sh" ;;
        13) script="scripts/13-streaming-media-check.sh" ;;
        14) script="scripts/18-ecs-test.sh" ;;
        15) script="scripts/19-network-quality-check.sh" ;;
        16) script="scripts/20-ip-quality-check.sh" ;;
        17) script="scripts/26-packet-size-test-large.sh" ;;
        18) script="scripts/27-packet-size-test-small.sh" ;;
        19) script="scripts/14-3x-ui.sh" ;;
        20) script="scripts/15-hy2-install.sh" ;;
        21) script="scripts/16-singbox-install.sh" ;;
        22) script="scripts/17-1panel-install.sh" ;;
        23) script="scripts/21-snell-install.sh" ;;
        24) script="scripts/22-shadowsocks-install.sh" ;;
        25) script="scripts/23-reality-install.sh" ;;
        26) script="scripts/24-kejilion-install.sh" ;;
        27) script="scripts/25-substore-docker.sh" ;;
        *)  print_error "无效选择"; return 1 ;;
    esac

    # 本地模式执行本地文件，远程模式执行云端文件
    if [ -f "$SCRIPT_DIR/$script" ]; then
        bash "$SCRIPT_DIR/$script"
    else
        bash <(curl -fsSL "$RAW_BASE/$script")
    fi
}

# ── 卸载 ─────────────────────────────────────────────────────────────────────

do_uninstall() {
    print_title "卸载 / 清理"

    local found=0
    [ -d "$HOME/.kits" ] && print_info "发现旧版本缓存: ~/.kits" && found=1

    if [ $found -eq 0 ]; then
        print_success "无任何本地残留，无需操作"
        pause_prompt
        return 0
    fi

    if confirm_prompt "确认清理所有本地残留?"; then
        [ -d "$HOME/.kits" ] && rm -rf "$HOME/.kits" && print_success "已删除 ~/.kits"
        print_success "清理完成"
    else
        print_info "已取消"
    fi

    pause_prompt
}

# ── 主循环 ───────────────────────────────────────────────────────────────────

main() {
    local total_options=$((${#MENU_OPTIONS_BASIC[@]} + ${#MENU_OPTIONS_SYSTEM[@]} + ${#MENU_OPTIONS_NETWORK[@]} + ${#MENU_OPTIONS_VPS[@]}))

    while true; do
        show_main_menu

        echo ""
        read -p "$(echo -e "${CYAN}请选择:${NC} ")" MENU_CHOICE

        case "$MENU_CHOICE" in
            0)
                print_info "再见！"
                exit 0
                ;;
            u|U)
                do_uninstall
                ;;
            ''|*[!0-9]*)
                print_error "无效选择"
                sleep 1
                ;;
            *)
                if [ "$MENU_CHOICE" -ge 1 ] && [ "$MENU_CHOICE" -le "$total_options" ]; then
                    execute_script "$MENU_CHOICE"
                else
                    print_error "无效选择"
                    sleep 1
                fi
                ;;
        esac
    done
}

if [ "$(detect_os)" == "unknown" ]; then
    print_error "不支持的系统"
    exit 1
fi

main
