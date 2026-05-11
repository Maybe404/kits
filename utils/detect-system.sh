# 系统检测函数

detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            OS_NAME=$ID
            OS_VERSION=$VERSION_ID

            case $ID in
                ubuntu)
                    echo "ubuntu"
                    ;;
                debian)
                    echo "debian"
                    ;;
                *)
                    echo "unknown"
                    ;;
            esac
        else
            echo "unknown"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    else
        echo "unknown"
    fi
}

get_os_display_name() {
    local os=$1
    case $os in
        ubuntu)
            echo "Ubuntu"
            ;;
        debian)
            echo "Debian"
            ;;
        macos)
            echo "macOS"
            ;;
        *)
            echo "Unknown"
            ;;
    esac
}

# 检查是否为root/sudo
check_privileges() {
    if [[ "$EUID" != 0 ]]; then
        return 1
    fi
    return 0
}
