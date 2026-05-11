# 菜单相关的函数

source "$(dirname "${BASH_SOURCE[0]}")/colors.sh"

# 打印标题
print_title() {
    local title=$1
    clear
    echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${NC}  $title"
    echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# 打印分隔线
print_separator() {
    echo -e "${GRAY}────────────────────────────────────────────────────────────${NC}"
}

# 打印成功信息
print_success() {
    local msg=$1
    echo -e "${GREEN}${CHECK} $msg${NC}"
}

# 打印错误信息
print_error() {
    local msg=$1
    echo -e "${RED}${CROSS} $msg${NC}"
}

# 打印警告信息
print_warning() {
    local msg=$1
    echo -e "${YELLOW}⚠ $msg${NC}"
}

# 打印信息
print_info() {
    local msg=$1
    echo -e "${CYAN}${ARROW} $msg${NC}"
}

# 生成菜单项
print_menu_item() {
    local number=$1
    local description=$2
    printf "${CYAN}[${number}]${NC} %s\n" "$description"
}

# 获取用户选择，结果存入全局变量 MENU_CHOICE
MENU_CHOICE=0
get_user_choice() {
    local max=$1

    echo ""
    read -p "$(echo -e ${CYAN}请选择:${NC}) " MENU_CHOICE

    if ! [[ "$MENU_CHOICE" =~ ^[0-9]+$ ]] || [ "$MENU_CHOICE" -lt 1 ] || [ "$MENU_CHOICE" -gt "$max" ]; then
        MENU_CHOICE=0
    fi
}

# 暂停
pause_prompt() {
    echo ""
    read -p "$(echo -e ${CYAN}按 Enter 继续...${NC})"
}

# 确认提示
confirm_prompt() {
    local msg=$1
    local response

    echo ""
    read -p "$(echo -e ${YELLOW}${msg} \(y/n\): ${NC})" response

    if [[ "$response" =~ ^[Yy]$ ]]; then
        return 0
    else
        return 1
    fi
}
