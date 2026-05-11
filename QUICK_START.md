# 快速开始指南

## 本地测试

### 1. 克隆或下载项目

```bash
cd /path/to/your/project
```

### 2. 赋予执行权限

```bash
chmod +x install.sh
chmod +x scripts/*.sh
chmod +x utils/*.sh
```

### 3. 运行脚本

```bash
./install.sh
```

## 推送到 GitHub

### 1. 创建新的 GitHub 仓库

登录 GitHub，创建名为 `one-click-installer` 的新仓库（可以选择其他名字）

### 2. 初始化本地 Git 仓库

```bash
cd /Users/maybe/Documents/code/scripts/one-click-installer
git init
git add .
git commit -m "初始化 VPS 一键脚本项目"
```

### 3. 添加远程仓库并推送

```bash
# 将 YOUR_USERNAME 和 your-repo-name 替换为实际值
git remote add origin https://github.com/YOUR_USERNAME/one-click-installer.git
git branch -M main
git push -u origin main
```

## 在服务器上运行

### 方式一：使用 curl（推荐）

```bash
bash <(curl -sSL https://raw.githubusercontent.com/YOUR_USERNAME/one-click-installer/main/install.sh)
```

### 方式二：使用 wget

```bash
bash <(wget -O- https://raw.githubusercontent.com/YOUR_USERNAME/one-click-installer/main/install.sh)
```

### 方式三：克隆仓库后运行

```bash
git clone https://github.com/YOUR_USERNAME/one-click-installer.git
cd one-click-installer
chmod +x install.sh
./install.sh
```

## 项目包含的脚本

### 基础检测 (5 个)
- ✓ 查看本机 IP
- ✓ 检查端口占用
- ✓ 检查容器
- ✓ 检查网络出口 IP
- ✓ 检查 DNS

### 系统管理 (5 个)
- ✓ 系统更新 & 安装必备应用
- ✓ 一键获取 root 权限
- ✓ 一键 ACME 申请证书
- ✓ ipblock 屏蔽国内访问
- ✓ SubStore 安装

### 网络测试 (3 个)
- ✓ 互联网延迟测试
- ✓ 回程路由检测
- ✓ 流媒体区域限制检测

### VPS 工具 (4 个)
- ✓ 3x-ui 安装
- ✓ Hysteria 2 (Hy2) 安装
- ✓ Sing-box 安装
- ✓ 1Panel 面板安装

**总计：17 个脚本**

## 扩展项目

要添加新的脚本，只需：

1. 在 `scripts/` 目录创建新的 `.sh` 文件（命名规范：`NN-script-name.sh`）
2. 参考现有脚本的结构编写脚本
3. 在 `install.sh` 中添加菜单项和脚本执行逻辑

示例脚本模板：

```bash
#!/bin/bash

source "$(dirname "$0")/../utils/colors.sh"
source "$(dirname "$0")/../utils/menu.sh"
source "$(dirname "$0")/../utils/detect-system.sh"

my_function() {
    print_title "脚本标题"
    
    local os=$(detect_os)
    
    case $os in
        ubuntu|debian)
            print_info "执行 Linux 命令..."
            # Linux 命令
            ;;
        macos)
            print_error "此脚本不支持 macOS"
            ;;
        *)
            print_error "不支持的系统"
            ;;
    esac
    
    pause_prompt
}

my_function
```

## 系统支持

| 系统 | 支持情况 | 备注 |
|------|--------|------|
| Ubuntu | ✅ | 推荐 18.04+ |
| Debian | ✅ | 推荐 10+ |
| macOS | ⚠️ | 部分脚本不支持 |

## 常见问题

**Q: 脚本执行权限不足？**
A: 某些操作需要 root 或 sudo 权限，请确保有相应权限

**Q: 脚本下载失败？**
A: 检查网络连接和防火墙设置

**Q: 在 Windows 上如何使用？**
A: 可以使用 WSL2 或虚拟机（Ubuntu/Debian）

## 许可证

MIT License

---

**提示**：定期更新脚本，添加新功能！
