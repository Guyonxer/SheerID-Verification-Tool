@echo off
chcp 65001 >nul
color 0A

echo.
echo ═══════════════════════════════════════════════════════════
echo   🚀 SheerID Verification Tool - 一键部署向导
echo ═══════════════════════════════════════════════════════════
echo.

echo 📋 部署步骤：
echo.
echo 【步骤 1】准备 GitHub 仓库
echo ─────────────────────────────────────────────────────────
echo.
echo 选项 A: Fork 原仓库（推荐）
echo   1. 访问: https://github.com/ThanhNguyxn/SheerID-Verification-Tool
echo   2. 点击右上角 "Fork" 按钮
echo   3. 等待 Fork 完成
echo.
echo 选项 B: 创建新仓库
echo   1. 访问: https://github.com/new
echo   2. 创建新仓库（例如：sheerid-tool）
echo   3. 不要初始化 README
echo.
pause
echo.

echo 【步骤 2】推送代码到你的仓库
echo ─────────────────────────────────────────────────────────
echo.
set /p REPO_URL="请输入你的仓库 URL (例如: https://github.com/你的用户名/仓库名.git): "
echo.

if "%REPO_URL%"=="" (
    echo ❌ 错误: 仓库 URL 不能为空
    pause
    exit /b 1
)

echo 正在设置远程仓库...
git remote remove origin 2>nul
git remote add origin %REPO_URL%

echo 正在提交所有更改...
git add .
git commit -m "Add deployment configurations" 2>nul

echo 正在推送到 GitHub...
git push -u origin master
if errorlevel 1 (
    echo.
    echo ⚠️ 推送失败，可能需要先登录 GitHub
    echo 请运行: git push -u origin master
    echo.
    pause
)

echo.
echo ✅ 代码已推送到 GitHub！
echo.
pause

echo 【步骤 3】部署到 Render.com
echo ─────────────────────────────────────────────────────────
echo.
echo 1. 访问: https://render.com
echo 2. 点击 "Get Started" 或 "Sign In"
echo 3. 使用 GitHub 账号登录
echo.
pause

echo 4. 点击 "New +" → "Web Service"
echo 5. 找到并选择你的仓库
echo 6. 配置如下：
echo    • Name: sheerid-api
echo    • Region: Singapore (或离你最近的)
echo    • Branch: master
echo    • Root Directory: auto-verify-tool
echo    • Environment: Docker
echo    • Instance Type: Free
echo.
pause

echo 7. 点击 "Create Web Service"
echo 8. 等待 5-10 分钟部署完成
echo.
echo 💡 提示: 可以在 Logs 标签页查看部署进度
echo.
pause

echo 【步骤 4】获取后端 URL
echo ─────────────────────────────────────────────────────────
echo.
echo 部署完成后，你会看到类似这样的 URL：
echo https://sheerid-api-abc123.onrender.com
echo.
set /p BACKEND_URL="请输入你的后端 URL: "
echo.

if "%BACKEND_URL%"=="" (
    echo ⚠️ 跳过更新配置，你可以稍后手动更新 index.html
    goto :deploy_frontend
)

echo 正在更新 index.html...
powershell -Command "(Get-Content index.html) -replace \"const BACKEND_URL = '.*?';\", \"const BACKEND_URL = '%BACKEND_URL%';\" | Set-Content index.html"

echo 正在提交更改...
git add index.html
git commit -m "Update backend URL"
git push

echo.
echo ✅ 前端配置已更新！
echo.

:deploy_frontend
echo 【步骤 5】部署前端
echo ─────────────────────────────────────────────────────────
echo.
echo 选项 A: 使用 Render Static Site
echo   1. 在 Render Dashboard 点击 "New +" → "Static Site"
echo   2. 选择同一个仓库
echo   3. 配置：
echo      • Name: sheerid-frontend
echo      • Build Command: echo "No build"
echo      • Publish Directory: .
echo   4. 点击 "Create Static Site"
echo.
echo 选项 B: 使用 Vercel（更快）
echo   1. 安装 Vercel CLI: npm install -g vercel
echo   2. 运行: vercel --prod
echo.
pause

echo.
echo ═══════════════════════════════════════════════════════════
echo   ✅ 部署完成！
echo ═══════════════════════════════════════════════════════════
echo.
echo 📊 你的服务：
echo   • 后端 API: %BACKEND_URL%
echo   • 前端: 等待 Static Site 部署完成
echo.
echo 🔍 测试部署：
echo   运行: node check-deployment.js
echo.
echo 📖 更多帮助：
echo   查看 START-HERE.md
echo.
pause

start https://render.com
