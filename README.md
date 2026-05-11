# kits

个人 VPS 及 macOS 常用脚本合集，支持 Ubuntu / Debian / macOS，自动识别系统环境。

## 使用

```bash
bash <(curl -sSL https://raw.githubusercontent.com/Maybe404/kits/main/run.sh)
```

或使用 wget：

```bash
bash <(wget -qO- https://raw.githubusercontent.com/Maybe404/kits/main/run.sh)
```

> 脚本会自动下载到 `~/.kits`，后续执行同一条命令可自动更新到最新版本。

## 功能

### 基础检测
| # | 功能 | Ubuntu/Debian | macOS |
|---|------|:---:|:---:|
| 1 | 查看本机 IP | ✅ | ✅ |
| 2 | 检查端口占用 | ✅ | ✅ |
| 3 | 检查容器 (Docker) | ✅ | ✅ |
| 4 | 检查网络出口 IP | ✅ | ✅ |
| 5 | 检查 DNS | ✅ | ✅ |

### 系统管理
| # | 功能 | Ubuntu/Debian | macOS |
|---|------|:---:|:---:|
| 6 | 系统更新 & 安装必备工具 | ✅ apt | ✅ brew |
| 7 | 一键获取 root 权限 | ✅ | ❌ |
| 8 | ACME 申请 SSL 证书 | ✅ | ✅ |
| 9 | ipblock 屏蔽国内访问 | ✅ | ❌ |
| 10 | SubStore 安装 | ✅ | ✅ |

### 网络测试
| # | 功能 | Ubuntu/Debian | macOS |
|---|------|:---:|:---:|
| 11 | 互联网延迟测试 | ✅ | ✅ |
| 12 | 回程路由检测 | ✅ | ❌ |
| 13 | 流媒体区域限制检测 | ✅ | ✅ |
| 14 | 融合怪综合检测 | ✅ | ❌ |
| 15 | 网络质量检测 | ✅ | ✅ |
| 16 | IP 质量检测 | ✅ | ✅ |
| 17 | 大包检测 (广州电信) | ✅ | ❌ |
| 18 | 小包检测 (广州电信) | ✅ | ❌ |

### VPS 工具
| # | 功能 | Ubuntu/Debian | macOS |
|---|------|:---:|:---:|
| 19 | 3x-ui 安装 | ✅ | ❌ |
| 20 | Hysteria 2 安装 | ✅ | ❌ |
| 21 | Sing-box 安装 | ✅ | ❌ |
| 22 | 1Panel 面板安装 | ✅ | ❌ |
| 23 | Snell 安装 | ✅ | ❌ |
| 24 | Shadowsocks-Rust 安装 | ✅ | ❌ |
| 25 | Reality (V2Ray) 安装 | ✅ | ❌ |
| 26 | 科技 Lion 安装 | ✅ | ❌ |
| 27 | SubStore Docker 安装 | ✅ | ✅ |

## 本地运行

```bash
git clone https://github.com/Maybe404/kits.git
cd kits
bash run.sh
```

## 添加新脚本

1. 在 `scripts/` 目录按命名规范 `NN-name.sh` 创建脚本
2. 参考现有脚本结构，通过 `detect_os` 区分系统分支
3. 在 `install.sh` 中添加菜单项和 `execute_script` 的 case 分支
