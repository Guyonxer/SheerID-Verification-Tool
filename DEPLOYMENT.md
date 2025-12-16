# 🚀 部署指南

本项目支持多种云平台部署，推荐使用以下免费方案：

## 方案 1: Render.com (推荐) ⭐

### 优势
- ✅ 完全免费套餐
- ✅ 支持 Docker
- ✅ 自动 HTTPS
- ✅ 持续部署 (Git 集成)
- ✅ 无需信用卡

### 部署步骤

1. **注册 Render 账号**
   - 访问 [render.com](https://render.com)
   - 使用 GitHub 账号登录

2. **连接 GitHub 仓库**
   - Fork 本项目到你的 GitHub
   - 在 Render Dashboard 点击 "New +"
   - 选择 "Blueprint"
   - 连接你的 GitHub 仓库

3. **自动部署**
   - Render 会自动检测 `render.yaml` 配置
   - 点击 "Apply" 开始部署
   - 等待 5-10 分钟完成构建

4. **获取 URL**
   - 后端 API: `https://sheerid-api-xxx.onrender.com`
   - 前端界面: `https://sheerid-frontend-xxx.onrender.com`

5. **更新前端配置**
   - 编辑 `index.html` 中的 `BACKEND_URL`
   - 替换为你的后端 API URL
   - 提交代码，自动重新部署

---

## 方案 2: Railway.app

### 优势
- ✅ $5 免费额度/月
- ✅ 支持 Docker
- ✅ 简单易用

### 部署步骤

1. **安装 Railway CLI**
   ```bash
   npm install -g @railway/cli
   ```

2. **登录并初始化**
   ```bash
   railway login
   cd SheerID-Verification-Tool/auto-verify-tool
   railway init
   ```

3. **部署**
   ```bash
   railway up
   ```

4. **添加域名**
   ```bash
   railway domain
   ```

---

## 方案 3: Fly.io

### 优势
- ✅ 免费套餐 (3个小应用)
- ✅ 全球 CDN
- ✅ 支持 Docker

### 部署步骤

1. **安装 Fly CLI**
   ```bash
   # Windows (PowerShell)
   iwr https://fly.io/install.ps1 -useb | iex
   ```

2. **登录并初始化**
   ```bash
   fly auth login
   cd SheerID-Verification-Tool/auto-verify-tool
   fly launch
   ```

3. **配置 fly.toml**
   ```toml
   app = "sheerid-api"
   
   [build]
     dockerfile = "Dockerfile"
   
   [[services]]
     internal_port = 3000
     protocol = "tcp"
   
     [[services.ports]]
       port = 80
       handlers = ["http"]
   
     [[services.ports]]
       port = 443
       handlers = ["tls", "http"]
   ```

4. **部署**
   ```bash
   fly deploy
   ```

---

## 方案 4: Vercel (仅前端) + 其他后端

### 前端部署到 Vercel

1. **安装 Vercel CLI**
   ```bash
   npm install -g vercel
   ```

2. **部署前端**
   ```bash
   cd SheerID-Verification-Tool
   vercel --prod
   ```

3. **配置环境变量**
   - 在 Vercel Dashboard 设置 `BACKEND_URL`

### 后端部署到 Render/Railway/Fly

按照上述方案部署后端服务

---

## 方案 5: Heroku (需要信用卡)

### 部署步骤

1. **安装 Heroku CLI**
   ```bash
   npm install -g heroku
   ```

2. **登录并创建应用**
   ```bash
   heroku login
   cd SheerID-Verification-Tool/auto-verify-tool
   heroku create sheerid-api
   ```

3. **设置 Buildpack**
   ```bash
   heroku buildpacks:set heroku/nodejs
   ```

4. **部署**
   ```bash
   git push heroku master
   ```

---

## 环境变量配置

所有平台都需要设置以下环境变量：

| 变量名 | 值 | 说明 |
|--------|-----|------|
| `PORT` | `3000` | 服务端口 |
| `NODE_ENV` | `production` | 生产环境 |

---

## 更新前端 API 地址

部署后端后，需要更新前端的 API 地址：

**编辑 `index.html`，找到：**

```javascript
const BACKEND_URL = 'https://sheerid-api-v2-d5gdbxa5hjd2baak.japaneast-01.azurewebsites.net';
```

**替换为你的后端 URL：**

```javascript
const BACKEND_URL = 'https://your-backend-url.onrender.com';
```

---

## 性能优化建议

### 1. 使用 CDN
- Cloudflare (免费)
- 将前端静态文件托管到 CDN

### 2. 数据库持久化
- 添加 Redis 缓存验证结果
- 使用 MongoDB 存储统计数据

### 3. 监控和日志
- 集成 Sentry 错误追踪
- 使用 LogTail 日志管理

---

## 故障排查

### 问题 1: Puppeteer 无法启动

**解决方案：**
```dockerfile
# 确保 Dockerfile 使用正确的基础镜像
FROM ghcr.io/puppeteer/puppeteer:latest
```

### 问题 2: 内存不足

**解决方案：**
- 升级到付费套餐
- 优化 Puppeteer 配置：
  ```javascript
  const browser = await puppeteer.launch({
    args: ['--no-sandbox', '--disable-setuid-sandbox', '--disable-dev-shm-usage']
  });
  ```

### 问题 3: CORS 错误

**解决方案：**
```javascript
// server.js 中确保 CORS 配置正确
app.use(cors({
  origin: ['https://your-frontend-url.com'],
  credentials: true
}));
```

---

## 成本估算

| 平台 | 免费额度 | 付费价格 |
|------|----------|----------|
| Render | 750小时/月 | $7/月起 |
| Railway | $5额度/月 | 按使用量 |
| Fly.io | 3个应用 | $1.94/月起 |
| Vercel | 100GB带宽 | $20/月起 |

---

## 推荐配置

**最佳免费方案：**
- 后端: Render.com (Web Service)
- 前端: Vercel 或 Render Static Site
- 总成本: **$0/月**

**生产环境方案：**
- 后端: Railway.app ($7/月)
- 前端: Vercel Pro ($20/月)
- CDN: Cloudflare (免费)
- 监控: Sentry (免费套餐)
- 总成本: **$27/月**

---

## 下一步

1. ✅ 选择部署平台
2. ✅ 部署后端服务
3. ✅ 更新前端 API 地址
4. ✅ 部署前端界面
5. ✅ 测试完整流程
6. ✅ 配置自定义域名 (可选)

祝部署顺利！🚀
