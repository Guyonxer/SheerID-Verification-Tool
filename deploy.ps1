# SheerID Verification Tool - 自动部署脚本 (Windows PowerShell)

Write-Host "🚀 SheerID Verification Tool - 自动部署向导" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""

# 检查 Git
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "❌ 错误: 未安装 Git" -ForegroundColor Red
    Write-Host "请访问 https://git-scm.com/download/win 下载安装" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ Git 已安装" -ForegroundColor Green
Write-Host ""

# 选择部署平台
Write-Host "请选择部署平台:" -ForegroundColor Yellow
Write-Host "1. Render.com (推荐 - 完全免费)" -ForegroundColor White
Write-Host "2. Railway.app (5美元免费额度)" -ForegroundColor White
Write-Host "3. Fly.io (免费套餐)" -ForegroundColor White
Write-Host "4. 手动部署指南" -ForegroundColor White
Write-Host ""

$choice = Read-Host "请输入选项 (1-4)"

switch ($choice) {
    "1" {
        Write-Host ""
        Write-Host "📋 Render.com 部署步骤:" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "1️⃣  访问 https://render.com 并使用 GitHub 登录" -ForegroundColor White
        Write-Host ""
        Write-Host "2️⃣  点击 'New +' -> 'Web Service'" -ForegroundColor White
        Write-Host ""
        Write-Host "3️⃣  连接此 GitHub 仓库" -ForegroundColor White
        Write-Host ""
        Write-Host "4️⃣  配置如下:" -ForegroundColor White
        Write-Host "    Name: sheerid-api" -ForegroundColor Gray
        Write-Host "    Root Directory: auto-verify-tool" -ForegroundColor Gray
        Write-Host "    Runtime: Docker" -ForegroundColor Gray
        Write-Host "    Instance Type: Free" -ForegroundColor Gray
        Write-Host ""
        Write-Host "5️⃣  点击 'Create Web Service' 并等待部署完成" -ForegroundColor White
        Write-Host ""
        Write-Host "6️⃣  复制生成的 URL (例如: https://sheerid-api-xxx.onrender.com)" -ForegroundColor White
        Write-Host ""
        
        $backendUrl = Read-Host "请输入你的后端 URL (或按 Enter 跳过)"
        
        if ($backendUrl) {
            Write-Host ""
            Write-Host "正在更新 index.html..." -ForegroundColor Yellow
            
            $indexPath = "index.html"
            if (Test-Path $indexPath) {
                $content = Get-Content $indexPath -Raw
                $content = $content -replace "const BACKEND_URL = '.*?';", "const BACKEND_URL = '$backendUrl';"
                Set-Content $indexPath $content
                
                Write-Host "✅ 已更新 BACKEND_URL 为: $backendUrl" -ForegroundColor Green
                Write-Host ""
                Write-Host "请提交更改:" -ForegroundColor Yellow
                Write-Host "  git add index.html" -ForegroundColor Gray
                Write-Host "  git commit -m 'Update backend URL'" -ForegroundColor Gray
                Write-Host "  git push" -ForegroundColor Gray
            }
        }
    }
    
    "2" {
        Write-Host ""
        Write-Host "📋 Railway.app 部署步骤:" -ForegroundColor Cyan
        Write-Host ""
        
        # 检查 Railway CLI
        if (-not (Get-Command railway -ErrorAction SilentlyContinue)) {
            Write-Host "正在安装 Railway CLI..." -ForegroundColor Yellow
            npm install -g @railway/cli
        }
        
        Write-Host "✅ Railway CLI 已安装" -ForegroundColor Green
        Write-Host ""
        Write-Host "执行以下命令部署:" -ForegroundColor Yellow
        Write-Host "  railway login" -ForegroundColor Gray
        Write-Host "  cd auto-verify-tool" -ForegroundColor Gray
        Write-Host "  railway init" -ForegroundColor Gray
        Write-Host "  railway up" -ForegroundColor Gray
        Write-Host "  railway domain" -ForegroundColor Gray
    }
    
    "3" {
        Write-Host ""
        Write-Host "📋 Fly.io 部署步骤:" -ForegroundColor Cyan
        Write-Host ""
        
        # 检查 Fly CLI
        if (-not (Get-Command fly -ErrorAction SilentlyContinue)) {
            Write-Host "正在安装 Fly CLI..." -ForegroundColor Yellow
            iwr https://fly.io/install.ps1 -useb | iex
        }
        
        Write-Host "✅ Fly CLI 已安装" -ForegroundColor Green
        Write-Host ""
        Write-Host "执行以下命令部署:" -ForegroundColor Yellow
        Write-Host "  fly auth login" -ForegroundColor Gray
        Write-Host "  cd auto-verify-tool" -ForegroundColor Gray
        Write-Host "  fly launch --name sheerid-api" -ForegroundColor Gray
        Write-Host "  fly deploy" -ForegroundColor Gray
    }
    
    "4" {
        Write-Host ""
        Write-Host "📖 打开部署文档..." -ForegroundColor Cyan
        Start-Process "QUICK-DEPLOY.md"
    }
    
    default {
        Write-Host "❌ 无效选项" -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "✅ 部署向导完成！" -ForegroundColor Green
Write-Host ""
Write-Host "📚 更多信息请查看:" -ForegroundColor Yellow
Write-Host "  - QUICK-DEPLOY.md (快速部署指南)" -ForegroundColor Gray
Write-Host "  - DEPLOYMENT.md (详细部署文档)" -ForegroundColor Gray
Write-Host ""
Write-Host "💡 提示: 部署后记得更新 index.html 中的 BACKEND_URL" -ForegroundColor Yellow
Write-Host ""

Read-Host "按 Enter 键退出"
