[![Support on Afdian](https://img.shields.io/badge/Support-爱发电-orange.svg?style=flat-square&logo=afdian)](https://afdian.com/a/Rabbit-Spec)
<h1 align="center">ZTE-Modem-TimeSync-Shortcut</h1>

<p align="center">
  <strong>专为 macOS 快捷指令优化的自动化方案</strong>
</p>
<p align="center">
  <strong>解决中兴光猫桥接模式下的时间同步与系统稳定性</strong>
</p>

<p align="center">
<img src="https://raw.githubusercontent.com/Rabbit-Spec/Surge/Master/Conf/img/1.PNG" width="300"></img>
</p>

## 📖 项目背景

当中兴光猫切换至 **桥接模式** 后，由于失去了原有的 NTP 对时能力，系统时间通常会回退至 `1970-01-01`。

**时间回退会导致以下问题：**
- **日志诊断困难**：所有的系统日志（System Log）时间戳错误，无法判断故障发生的确切时间。
- **服务逻辑冲突**：内部服务（如 IGMP/MLD 查询）因时间维度错误频繁重试。
- **潜在重启风险**：错误堆积可能导致光猫 CPU 负载异常，引发 `reboot for media` 等异常重启。
- **心理疾病风险**：桥接模式下时间错误的光猫可能会导致上网冲浪时的心理断流。

本项目通过 macOS **快捷指令 (Shortcuts)** 自动化运行 Shell 脚本，实现**秒级精准对时**，让光猫在最稳定的状态下运行。

## ✨ 功能亮点

- ⏱️ **秒级同步**：支持 「YYYY-MM-DD HH:MM:SS」 格式，彻底解决以往方案只对准分钟的缺憾。
- ⚡ **延迟补偿**：针对 macOS 环境优化，内置 1s 传输补偿逻辑，确保误差极小。
- 🔔 **原生通知**：集成 「osascript」 系统通知，同步成功即刻反馈。

## 🚀 快捷指令
点击下方链接导入封装好的快捷指令：
👉 **[点击直接下载快捷指令](https://www.icloud.com/shortcuts/d5d56846eb264bd8a862ef7b33766bb1)**
> **注意**：导入后仍需完成下方的「环境准备」步骤，并修改指令中的 IP 和密码。

## 📦 环境准备：安装必备工具
由于脚本依赖 `expect` 来处理 Telnet 的自动登录交互，而 macOS 默认不带此工具，需要通过 **Homebrew** 进行安装。

#### **第一步：安装 Homebrew (若已安装请跳过)**
打开「终端」(Terminal)，执行以下命令：
```bash
/bin/bash -c "$(curl -fsSL [https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh](https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh))"
```
#### **第二步：安装 expect (若已安装请跳过)**
打开「终端」(Terminal)，执行以下命令：
```bash
brew install expect
```
#### **安装完成后，执行 expect -v 若显示版本号即安装成功。**

#### **现在运行刚才下载的快捷指令即可✅**

## 📜 免责声明
Rabbit-Spec仓库内容仅用于技术交流。

操作底层固件配置存在风险，因使用本脚本导致的硬件故障，本人概不负责。

本项目采用 MIT License 开源。
