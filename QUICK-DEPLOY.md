# ⚡ 快速部署指南

## 🎯 最简单的方法 - Render.com (3分钟部署)

### 步骤 1: 准备 GitHub 仓库

**选项 A: Fork 原仓库**
1. 访问 https://github.com/ThanhNguyxn/SheerID-Verification-Tool
2. 点击右上角 **Fork** 按钮
3. 等待 Fork 完成

**选项 B: 上传到你自己的仓库**
```bash
cd SheerID-Verification-Tool
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/你的用户名/你的仓库名.git
git push -u origin master
```

---

### 步骤 2: 一键部署到 Render

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

**或者手动部署：**

1. **访问 Render.com**
   - 打开 https://render.com
   - 使用 GitHub 登录

2. **创建 Web Service (后端)**
   - 点击 **New +** → **Web Service**
   - 连接你的 GitHub 仓库
   - 配置如下：
     ```
     Name: sheerid-api
     Region: Singapore (或离你最近的)
     Branch: master
     Root Directory: auto-verify-tool
     Runtime: Docker
     Docker Build Context: auto-verify-tool
     Docker Command: (留空，使用 Dockerfile 默认)
     Instance Type: Free
     ```
   - 点击 **Create Web Service**

3. **创建 Static Site (前端)**
   - 点击 **New +** → **Static Site**
   - 选择同一个仓库
   - 配置如下：
     ```
     Name: sheerid-frontend
     Branch: master
     Build Command: echo "No build needed"
     Publish Directory: .
     ```
   - 点击 **Create Static Site**

4. **等待部署完成**
   - 后端部署需要 5-10 分钟（首次构建 Docker 镜像）
   - 前端部署需要 1-2 分钟

---

### 步骤 3: 配置前端连接后端

1. **获取后端 URL**
   - 在 Render Dashboard 找到你的后端服务
   - 复制 URL，例如：`https://sheerid-api-abc123.onrender.com`

2. **更新前端配置**
   - 编辑 `index.html` 文件
   - 找到这一行：
     ```javascript
     const BACKEND_URL = 'https://sheerid-api-v2-d5gdbxa5hjd2baak.japaneast-01.azurewebsites.net';
     ```
   - 替换为你的后端 URL：
     ```javascript
     const BACKEND_URL = 'https://sheerid-api-abc123.onrender.com';
     ```

3. **提交更改**
   ```bash
   git add index.html
   git commit -m "Update backend URL"
   git push
   ```

4. **等待自动重新部署**
   - Render 会自动检测到更改并重新部署前端
   - 约 1 分钟后完成

---

### 步骤 4: 测试部署

1. 访问你的前端 URL：`https://sheerid-frontend-xyz.onrender.com`
2. 输入一个测试验证链接
3. 点击 **VERIFY NOW**
4. 查看实时日志

✅ **部署成功！**

---

## 🚀 其他快速部署选项

### Railway.app (推荐备选)

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new)

**步骤：**
1. 点击上方按钮
2. 连接 GitHub 仓库
3. 选择 `auto-verify-tool` 目录
4. 自动检测 Dockerfile 并部署
5. 获取生成的 URL

---

### Fly.io (全球 CDN)

```bash
# 安装 Fly CLI (Windows PowerShell)
iwr https://fly.io/install.ps1 -useb | iex

# 登录
fly auth login

# 部署后端
cd SheerID-Verification-Tool/auto-verify-tool
fly launch --name sheerid-api
fly deploy

# 获取 URL
fly status
```

---

### Vercel (仅前端)

```bash
# 安装 Vercel CLI
npm install -g vercel

# 部署前端
cd SheerID-Verification-Tool
vercel --prod

# 获取 URL (自动显示)
```

**注意：** 后端需要单独部署到 Render/Railway/Fly

---

## 🔧 环境变量配置

在 Render Dashboard 中设置：

| 变量名 | 值 | 必需 |
|--------|-----|------|
| `PORT` | `3000` | ✅ |
| `NODE_ENV` | `production` | ✅ |

---

## 📊 免费套餐限制

| 平台 | CPU | 内存 | 带宽 | 休眠 |
|------|-----|------|------|------|
| Render | 0.5 CPU | 512MB | 100GB/月 | 15分钟无活动 |
| Railway | 共享 | 512MB | 100GB/月 | 无 |
| Fly.io | 共享 | 256MB | 160GB/月 | 无 |

---

## ⚠️ 常见问题

### Q1: 首次访问很慢？
**A:** 免费套餐会在 15 分钟无活动后休眠，首次访问需要 30-60 秒唤醒。

### Q2: Puppeteer 启动失败？
**A:** 确保使用提供的 Dockerfile，它包含了所有必需的依赖。

### Q3: CORS 错误？
**A:** 检查 `server.js` 中的 CORS 配置，确保允许你的前端域名。

### Q4: 如何查看日志？
**A:** 在 Render Dashboard 点击服务 → Logs 标签页。

---

## 🎉 完成！

你的 SheerID 验证工具现在已经部署到云端了！

**分享你的链接：**
- 前端: `https://your-frontend.onrender.com`
- API: `https://your-api.onrender.com`

**下一步：**
- 🌐 配置自定义域名
- 📊 添加 Google Analytics
- 🔒 添加访问密码保护
- 💾 集成数据库存储统计

需要帮助？提交 Issue: https://github.com/ThanhNguyxn/SheerID-Verification-Tool/issues
