# OpenClaw 修复与启动指南

## 1. 故障描述
**OpenClaw** 服务未运行，导致网关不可用。系统服务列表中未找到 `OpenClaw` 或 `OpenClawGateway` 服务。

## 2. 系统环境检查
- **项目位置**：
  - 核心文件：`C:\nvm4w\nodejs\node_modules\openclaw`
  - 管理脚本：`d:\ETC\OpenClaw`
  - 配置文件：`C:\Users\jerry\.openclaw\openclaw.json`
- **当前版本**：`2026.3.2`

## 3. 启动方式

### 方式一：临时启动（当前终端会话）
在终端中执行以下命令，直接启动 OpenClaw 网关进程。**注意：关闭终端后服务将停止。**

```powershell
$env:OPENCLAW_CONFIG_PATH='C:\Users\jerry\.openclaw\openclaw.json'; node C:\nvm4w\nodejs\node_modules\openclaw\openclaw.mjs gateway
```

启动成功后，控制台将显示如下信息：
```
[gateway] listening on ws://127.0.0.1:18789
[canvas] host mounted at http://127.0.0.1:18789/__openclaw__/canvas/
```

### 方式二：安装为系统服务（推荐）
为了确保 OpenClaw 在后台长期运行并随系统启动，建议使用提供的批处理脚本进行安装。

1. **定位脚本目录**：
   打开目录 `d:\ETC\OpenClaw`

2. **执行安装脚本**：
   右键点击 `Install_Start_OpenClaw.bat` 并选择 **以管理员身份运行**。
   该脚本将自动执行以下操作：
   - 清理残留 Node 进程
   - 卸载旧服务
   - 使用 NSSM 安装新服务 `OpenClaw`
   - 配置日志与环境变量
   - 启动服务

3. **常用管理脚本**：
   - 启动/重启：`Start_OpenClaw.bat`
   - 停止服务：`Stop_OpenClaw.bat`

## 4. 服务验证与访问
服务启动后，可以通过以下方式进行验证和访问：

- **可视化界面 (Canvas)**：
  [http://127.0.0.1:18789/__openclaw__/canvas/](http://127.0.0.1:18789/__openclaw__/canvas/)

- **网关地址 (Gateway)**：
  `ws://127.0.0.1:18789`

- **浏览器控制接口**：
  `http://127.0.0.1:18791/`

- **日志文件位置**：
  `C:\Users\jerry\AppData\Local\Temp\openclaw\` (临时运行)
  或服务配置指定的日志路径（如 `C:\nvm4w\nodejs\node_modules\openclaw\logs`）。
