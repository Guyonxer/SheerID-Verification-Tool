# 🚀 立即部署到 Render.com - 完整指南

> **使用 Blueprint 一键部署 - 最简单的方式！**

---

## 📋 第一步：准备 GitHub 仓库（2分钟）

由于代码目前在本地，我们需要先推送到 GitHub。

### 方式 1: Fork 原仓库（最快）⭐

1. **打开浏览器，访问：**
   ```
   https://github.com/ThanhNguyxn/SheerID-Verification-Tool
   ```

2. **点击右上角 "Fork" 按钮**
   - 等待几秒钟
   - Fork 完成后会跳转到你的仓库

3. **你的仓库地址：**
   ```
   https://github.com/你的用户名/SheerID-Verification-Tool
   ```

### 方式 2: 创建新仓库并推送

1. **创建新仓库**
   - 访问：https://github.com/new
   - 仓库名：`sheerid-tool`（或任意名称）
   - 设为 **Public**
   - **不要**勾选 "Initialize with README"
   - 点击 "Create repository"

2. **推送代码**
   
   在当前目录运行：
   ```bash
   git remote remove origin
   git remote add origin https://github.com/你的用户名/sheerid-tool.git
   git push -u origin master
   ```

✅ **GitHub 仓库准备完成！**

---

## 🎯 第二步：使用 Blueprint 一键部署（3分钟）

### 1. 登录 Render

**打开浏览器，访问：**
```
https://render.com
```

**点击 "Get Started" 或 "Sign In"**

**选择 "Sign in with GitHub"**
- 授权 Render 访问你的 GitHub
- 允许访问你的仓库

### 2. 使用 Blueprint 部署

**方式 A: 直接从仓库部署**

1. 在 Render Dashboard，点击 **"New +"**
2. 选择 **"Blueprint"**
3. 找到你的仓库：`SheerID-Verification-Tool` 或 `sheerid-tool`
4. 点击 **"Connect"**
5. Render 会自动检测到 `render.yaml` 文件
6. 点击 **"Apply"** 开始部署

**方式 B: 使用 Deploy to Render 按钮**

如果你的仓库是 Public，可以直接访问：
```
https://render.com/deploy?repo=https://github.com/你的用户名/SheerID-Verification-Tool
```

### 3. 查看部署进度

Blueprint 会自动创建两个服务：

| 服务 | 名称 | 类型 | 状态 |
|------|------|------|------|
| 后端 API | `sheerid-api` | Web Service | 🔄 部署中... |
| 前端界面 | `sheerid-frontend` | Static Site | 🔄 部署中... |

**部署时间：**
- 后端：5-10 分钟（首次构建 Docker 镜像）
- 前端：1-2 分钟

**查看日志：**
- 点击服务名称
- 切换到 **"Logs"** 标签页
- 实时查看部署进度

### 4. 等待部署完成

当看到以下信息时，表示部署成功：

**后端：**
```
==> Your service is live 🎉
==> Server running at http://localhost:3000
```

**前端：**
```
==> Your site is live 🎉
```

✅ **部署完成！**

---

## 🔧 第三步：配置前端连接后端（2分钟）

### 1. 获取后端 URL

在 Render Dashboard：
1. 点击 `sheerid-api` 服务
2. 复制顶部的 URL，例如：
   ```
   https://sheerid-api-abc123.onrender.com
   ```

### 2. 更新前端配置

**编辑本地文件 `index.html`：**

找到这一行（大约第 300 行）：
```javascript
const BACKEND_URL = 'https://sheerid-api-v2-d5gdbxa5hjd2baak.japaneast-01.azurewebsites.net';
```

替换为你的后端 URL：
```javascript
const BACKEND_URL = 'https://sheerid-api-abc123.onrender.com';
```

### 3. 提交并推送

```bash
git add index.html
git commit -m "Update backend URL"
git push
```

### 4. 等待自动重新部署

- Render 会自动检测到代码更改
- 前端会自动重新部署（约 1 分钟）
- 刷新页面查看更新

✅ **配置完成！**

---

## 🎉 第四步：测试部署

### 1. 获取你的 URL

在 Render Dashboard：

**后端 API：**
```
https://sheerid-api-abc123.onrender.com
```

**前端界面：**
```
https://sheerid-frontend-xyz.onrender.com
```

### 2. 测试后端

**方式 A: 浏览器访问**

打开：`https://sheerid-api-abc123.onrender.com`

应该看到：
```json
{"status":"ok","message":"SheerID Verification API is running"}
```

**方式 B: 使用检查工具**

```bash
node check-deployment.js
```

### 3. 测试前端

1. 访问：`https://sheerid-frontend-xyz.onrender.com`
2. 输入测试验证链接
3. 选择服务类型
4. 点击 **"VERIFY NOW"**
5. 查看实时日志

✅ **测试成功！**

---

## 📊 部署总结

### 你现在拥有：

| 服务 | URL | 状态 |
|------|-----|------|
| 🔧 后端 API | `https://sheerid-api-xxx.onrender.com` | ✅ 运行中 |
| 🌐 前端界面 | `https://sheerid-frontend-xxx.onrender.com` | ✅ 运行中 |

### 部署配置：

- ✅ Docker 容器化
- ✅ 自动 HTTPS
- ✅ 健康检查
- ✅ 自动重启
- ✅ 持续部署（Git 推送自动更新）

---

## ⚠️ 重要提示

### 免费套餐限制

**休眠机制：**
- 15 分钟无活动后自动休眠
- 首次访问需要 30-60 秒唤醒
- 每月 750 小时免费（约 31 天）

**解决方案：**

使用 [UptimeRobot](https://uptimerobot.com) 保持唤醒：
1. 注册 UptimeRobot（免费）
2. 添加监控：
   - Monitor Type: HTTP(s)
   - URL: 你的后端 URL
   - Monitoring Interval: 5 分钟
3. 保存后服务就不会休眠了

### 资源限制

| 资源 | 免费套餐 |
|------|----------|
| CPU | 0.5 核心 |
| 内存 | 512 MB |
| 带宽 | 100 GB/月 |
| 构建时间 | 无限制 |

---

## 🔧 后续优化

### 1. 配置自定义域名

**在 Render Dashboard：**
1. 点击服务 → Settings
2. 找到 "Custom Domain"
3. 添加你的域名
4. 配置 DNS 记录（CNAME）

### 2. 添加环境变量

**在 Render Dashboard：**
1. 点击服务 → Environment
2. 添加环境变量：
   ```
   NODE_ENV=production
   LOG_LEVEL=info
   ```

### 3. 配置通知

**在 Render Dashboard：**
1. Settings → Notifications
2. 添加 Email 或 Slack 通知
3. 接收部署状态更新

### 4. 查看监控数据

**在 Render Dashboard：**
1. 点击服务 → Metrics
2. 查看：
   - CPU 使用率
   - 内存使用率
   - 请求数量
   - 响应时间

---

## 🆘 常见问题

### Q1: Blueprint 部署失败

**可能原因：**
- `render.yaml` 配置错误
- 仓库权限问题
- Docker 构建失败

**解决方案：**
1. 检查 Logs 查看错误信息
2. 确保 `render.yaml` 在仓库根目录
3. 确保 Render 有访问仓库的权限

### Q2: 后端部署成功但无法访问

**可能原因：**
- 服务正在启动中
- 健康检查失败
- 端口配置错误

**解决方案：**
1. 等待 1-2 分钟
2. 查看 Logs 确认服务已启动
3. 确认看到 "Server running at..." 消息

### Q3: 前端无法连接后端

**可能原因：**
- BACKEND_URL 配置错误
- CORS 配置问题
- 后端服务未运行

**解决方案：**
1. 检查 `index.html` 中的 BACKEND_URL
2. 确保后端 URL 正确且可访问
3. 检查浏览器控制台的错误信息

### Q4: 首次访问很慢

**原因：** 免费套餐休眠机制

**解决方案：**
- 等待 30-60 秒服务唤醒
- 使用 UptimeRobot 保持唤醒
- 升级到付费套餐（$7/月）

---

## 📚 相关资源

### Render 文档
- [Render 官方文档](https://render.com/docs)
- [Blueprint 指南](https://render.com/docs/infrastructure-as-code)
- [Docker 部署](https://render.com/docs/docker)

### 项目文档
- [START-HERE.md](START-HERE.md) - 完整部署指南
- [QUICK-DEPLOY.md](QUICK-DEPLOY.md) - 快速部署
- [DEPLOYMENT.md](DEPLOYMENT.md) - 详细文档

---

## ✅ 部署检查清单

完成后打勾：

- [ ] GitHub 仓库已准备（Fork 或新建）
- [ ] 代码已推送到 GitHub
- [ ] 已登录 Render.com
- [ ] 使用 Blueprint 部署
- [ ] 后端部署成功
- [ ] 前端部署成功
- [ ] 已更新 BACKEND_URL
- [ ] 代码已提交推送
- [ ] 前端自动重新部署
- [ ] 测试后端 API
- [ ] 测试前端界面
- [ ] (可选) 配置 UptimeRobot
- [ ] (可选) 添加自定义域名

---

## 🎊 恭喜！

你已经成功使用 Render Blueprint 部署了 SheerID Verification Tool！

**你的服务：**
```
🌐 前端: https://sheerid-frontend-xyz.onrender.com
🔧 API:  https://sheerid-api-abc123.onrender.com
```

**下次更新：**
```bash
git add .
git commit -m "Update features"
git push
```

Render 会自动检测并重新部署！

---

**祝使用愉快！** 🚀

有问题？查看 [DEPLOYMENT.md](DEPLOYMENT.md) 或提交 Issue。
