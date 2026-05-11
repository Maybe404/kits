# VPS 一键脚本管理器

一个功能强大、设计美观的 VPS 管理脚本集合，支持 Ubuntu、Debian 和 macOS 系统。

## 特性

- 🎨 美观的终端 UI，支持彩色输出
- 🔄 自动检测系统环境（Ubuntu/Debian/macOS）
- 📦 集合多个常用 VPS 管理脚本
- 🛠️ 模块化设计，易于扩展
- 📱 支持交互式菜单和返回选项
- ⚡ 快速部署和配置

## 项目结构

```
one-click-installer/
├── install.sh              # 主入口脚本
├── README.md               # 项目说明文档
├── scripts/                # 功能脚本目录
│   ├── 01-show-ip.sh       # 查看本机 IP
│   ├── 02-check-ports.sh   # 检查端口占用
│   ├── 03-check-containers.sh    # 查看容器
│   ├── 04-check-outgoing-ip.sh   # 检查网络出口 IP
│   ├── 05-check-dns.sh     # 检查 DNS
│   ├── 06-system-update.sh # 系统更新
│   ├── 07-get-root.sh      # 获取 root 权限
│   ├── 08-acme-cert.sh     # 申请 SSL 证书
│   ├── 09-ipblock.sh       # IP 屏蔽工具
│   ├── 10-substore.sh      # SubStore 安装
│   ├── 11-network-latency-test.sh    # 网络延迟测试
│   ├── 12-trace-route-test.sh        # 回程路由检测
│   ├── 13-streaming-media-check.sh   # 流媒体检测
│   └── 14-3x-ui.sh         # 3x-ui 安装
└── utils/                  # 工具函数目录
    ├── colors.sh           # 颜色和样式定义
    ├── detect-system.sh    # 系统检测函数
    └── menu.sh             # 菜单生成函数
```

## 快速开始

### 方式一：直接运行（推荐）

```bash
bash <(curl -sSL https://raw.githubusercontent.com/your-username/one-click-installer/main/install.sh)
```

### 方式二：克隆仓库后运行

```bash
git clone https://github.com/your-username/one-click-installer.git
cd one-click-installer
chmod +x install.sh
./install.sh
```

### 方式三：Wget 下载运行

```bash
wget https://raw.githubusercontent.com/your-username/one-click-installer/main/install.sh -O install.sh
chmod +x install.sh
./install.sh
```

## 脚本功能说明

### 基础检测
- **查看本机 IP**：显示本机所有 IP 地址
- **检查端口占用**：列出系统中所有监听的端口
- **检查容器**：显示 Docker 容器状态
- **检查网络出口 IP**：查看当前网络的出口 IP
- **检查 DNS**：显示当前 DNS 配置

### 系统管理
- **系统更新**：更新系统并安装必备应用
- **获取 root 权限**：一键获取 root 权限
- **ACME 证书**：申请免费 SSL 证书
- **ipblock 工具**：屏蔽国内访问
- **SubStore**：安装 SubStore 服务

### 网络测试
- **延迟测试**：检测国际网络延迟
- **回程路由**：检测回程路由信息
- **流媒体检测**：检测流媒体区域限制

### VPS 工具
- **3x-ui**：安装 3x-ui 面板

## 系统支持

- ✅ Ubuntu (推荐 18.04+)
- ✅ Debian (推荐 10+)
- ✅ macOS (推荐 10.15+)

> 部分脚本可能仅支持特定系统，具体请参考脚本提示

## 使用建议

1. **更新系统**：首次使用建议先运行"系统更新"脚本
2. **权限提示**：部分脚本需要 sudo 权限，请确保有相应权限
3. **网络环境**：某些操作需要良好的网络连接
4. **备份数据**：执行系统级操作前建议备份重要数据

## 常见问题

### Q: 脚本执行失败怎么办？
A: 
1. 检查网络连接
2. 确保有相应的权限（sudo/root）
3. 查看错误信息，根据提示解决问题

### Q: 能否在 Windows 上使用？
A: 不支持。Windows 用户可以使用 WSL2 或虚拟机运行。

### Q: 如何自定义脚本？
A: 所有脚本都是 Shell 脚本，可以直接编辑相应的 .sh 文件。

## 扩展脚本

要添加新的脚本：

1. 在 `scripts/` 目录创建新的 `.sh` 文件
2. 按照现有脚本的结构编写
3. 在 `install.sh` 中添加菜单项和对应的脚本执行逻辑

## 贡献

欢迎提交 Issue 和 Pull Request！

## 许可证

MIT License

## 免责声明

此脚本仅供学习和参考使用。使用此脚本造成的任何损失，使用者自行承担全部责任。

---

Made with ❤️ for VPS enthusiasts
