# 🚀 部署说明

本项目已配置好多个云平台的部署文件，可以快速部署到云端。

## 📁 部署配置文件

| 文件 | 用途 | 平台 |
|------|------|------|
| `render.yaml` | Render.com 配置 | Render |
| `railway.json` | Railway.app 配置 | Railway |
| `fly.toml` | Fly.io 配置 | Fly.io |
| `auto-verify-tool/Dockerfile` | Docker 镜像 | 所有平台 |
| `.dockerignore` | Docker 忽略文件 | 所有平台 |

## ⚡ 快速开始

### Windows 用户

```powershell
# 运行自动部署脚本
.\deploy.ps1
```

### Linux/Mac 用户

```bash
# 运行部署脚本
bash deploy-render.sh
```

## 📖 详细文档

- **[QUICK-DEPLOY.md](QUICK-DEPLOY.md)** - 3分钟快速部署指南
- **[DEPLOYMENT.md](DEPLOYMENT.md)** - 完整部署文档（包含所有平台）

## 🎯 推荐部署方案

### 方案 1: Render.com (最简单)

**优势：**
- ✅ 完全免费
- ✅ 自动 HTTPS
- ✅ 支持 Docker
- ✅ GitHub 集成

**步骤：**
1. Fork 本仓库
2. 访问 [render.com](https://render.com)
3. 创建 Web Service，选择你的仓库
4. 等待自动部署

**详细步骤：** 查看 [QUICK-DEPLOY.md](QUICK-DEPLOY.md)

---

### 方案 2: Railway.app (最快速)

**优势：**
- ✅ 一键部署
- ✅ 自动检测配置
- ✅ 无需手动配置

**步骤：**
```bash
npm install -g @railway/cli
railway login
cd auto-verify-tool
railway up
```

---

### 方案 3: Fly.io (全球 CDN)

**优势：**
- ✅ 全球分布
- ✅ 低延迟
- ✅ 免费套餐

**步骤：**
```bash
# Windows
iwr https://fly.io/install.ps1 -useb | iex

# 部署
fly auth login
cd auto-verify-tool
fly launch
fly deploy
```

---

## 🔧 部署后配置

### 1. 获取后端 URL

部署完成后，你会得到一个后端 URL，例如：
```
https://sheerid-api-abc123.onrender.com
```

### 2. 更新前端配置

编辑 `index.html`，找到：

```javascript
const BACKEND_URL = 'https://sheerid-api-v2-d5gdbxa5hjd2baak.japaneast-01.azurewebsites.net';
```

替换为你的后端 URL：

```javascript
const BACKEND_URL = 'https://sheerid-api-abc123.onrender.com';
```

### 3. 提交更改

```bash
git add index.html
git commit -m "Update backend URL"
git push
```

### 4. 部署前端

**选项 A: 使用 Render Static Site**
1. 在 Render 创建 Static Site
2. 连接同一个仓库
3. 自动部署

**选项 B: 使用 Vercel**
```bash
npm install -g vercel
vercel --prod
```

---

## 📊 平台对比

| 平台 | 免费额度 | 部署速度 | 难度 | 推荐度 |
|------|----------|----------|------|--------|
| Render | 750h/月 | ⭐⭐⭐ | ⭐ | ⭐⭐⭐⭐⭐ |
| Railway | $5/月 | ⭐⭐⭐⭐⭐ | ⭐ | ⭐⭐⭐⭐ |
| Fly.io | 3个应用 | ⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐⭐ |
| Vercel | 100GB | ⭐⭐⭐⭐⭐ | ⭐ | ⭐⭐⭐ (仅前端) |

---

## ⚠️ 注意事项

### 免费套餐限制

- **Render**: 15分钟无活动后休眠，首次访问需要 30-60 秒唤醒
- **Railway**: 每月 $5 免费额度，超出后需付费
- **Fly.io**: 最多 3 个免费应用

### 性能优化

1. **使用 CDN**: 将前端托管到 Vercel/Netlify
2. **添加缓存**: 使用 Redis 缓存验证结果
3. **监控**: 集成 Sentry 错误追踪

---

## 🆘 故障排查

### 问题 1: Puppeteer 无法启动

**原因**: 缺少 Chrome 依赖

**解决**: 使用提供的 Dockerfile，它包含所有依赖

### 问题 2: 内存不足

**原因**: 免费套餐内存限制 (512MB)

**解决**: 
- 优化 Puppeteer 配置
- 升级到付费套餐

### 问题 3: CORS 错误

**原因**: 前端域名未在 CORS 白名单

**解决**: 编辑 `server.js`，添加你的前端域名

---

## 📞 获取帮助

- 📖 查看 [QUICK-DEPLOY.md](QUICK-DEPLOY.md)
- 📖 查看 [DEPLOYMENT.md](DEPLOYMENT.md)
- 🐛 提交 Issue: https://github.com/ThanhNguyxn/SheerID-Verification-Tool/issues
- 💬 加入讨论: https://github.com/ThanhNguyxn/SheerID-Verification-Tool/discussions

---

## ✅ 部署检查清单

- [ ] 选择部署平台
- [ ] 部署后端服务
- [ ] 获取后端 URL
- [ ] 更新 index.html 中的 BACKEND_URL
- [ ] 部署前端
- [ ] 测试完整流程
- [ ] (可选) 配置自定义域名
- [ ] (可选) 添加监控和日志

---

**祝部署顺利！🎉**

如果遇到问题，请查看详细文档或提交 Issue。
