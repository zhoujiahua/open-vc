# OpenVC

OpenVC 是一套开源、简单、易用、快速、容器化的 VPN 组网与内网穿透管理软件。后端基于 Egg.js 构建，默认监听本地 `7001` 端口。

## 特性
- 基于 Egg.js 的按约定组织的轻量服务端
- RESTful 风格 API，统一响应结构
- 内置单元测试与 ESLint 规则
- 可通过 `egg-scripts` 进行生产部署

## 快速开始
1. 准备环境
   - Node.js ≥ 16
   - npm
2. 安装依赖并启动开发服务
   ```bash
   npm i
   npm run dev
   # 打开 http://localhost:7001/
   ```

## API 说明
默认 API 前缀：`/api/v1`

- GET `/`  
  健康检查与欢迎页，返回纯文本：`Hi, OpenVC.`

- GET `/api/v1/user/info`  
  查询用户信息（示例 Echo）
  - Query：任意键值对
  - 响应：
    ```json
    { "code": 0, "message": "success", "result": { "...query" : "..." } }
    ```

- POST `/api/v1/user/login`  
  用户登录（示例 Echo）
  - Body：JSON
  - 响应：
    ```json
    { "code": 0, "message": "success", "result": { "...body" : "..." } }
    ```

- POST `/api/v1/user/register`  
  用户注册（示例 Echo），结构同上

- GET `/api/v1/wireguard/cmd`  
  执行受限本地命令（示例执行 `dir`），返回标准输出与标准错误：
  ```json
  { "code": 0, "message": "success", "result": { "stdout": "...", "stderr": "" } }
  ```

### 示例请求
```bash
# 健康检查
curl http://localhost:7001/

# 获取用户信息
curl "http://localhost:7001/api/v1/user/info?name=jerry"

# 登录
curl -X POST "http://localhost:7001/api/v1/user/login" \
  -H "Content-Type: application/json" \
  -d "{\"username\":\"demo\",\"password\":\"123456\"}"
```

## 开发与测试
- 启动开发：`npm run dev`
- 代码检查：`npm run lint`
- 单元测试：`npm test`
- 覆盖率：`npm run cov`

项目包含基础用例 [test/app/controller/home.test.js](test/app/controller/home.test.js)，验证根路由返回。

## 部署
使用 `egg-scripts` 启动与停止生产服务：
```bash
npm start
npm stop
```

更多框架能力与配置请参考 [Egg 官方文档][egg]。

[egg]: https://eggjs.org
