#!/bin/bash

echo "🚀 SheerID Verification Tool - Render 部署脚本"
echo "=============================================="
echo ""

# 检查是否安装了 git
if ! command -v git &> /dev/null; then
    echo "❌ 错误: 未安装 Git"
    exit 1
fi

echo "📋 部署步骤："
echo ""
echo "1️⃣  Fork 本项目到你的 GitHub 账号"
echo "   访问: https://github.com/ThanhNguyxn/SheerID-Verification-Tool"
echo "   点击右上角 'Fork' 按钮"
echo ""
echo "2️⃣  登录 Render.com"
echo "   访问: https://render.com"
echo "   使用 GitHub 账号登录"
echo ""
echo "3️⃣  创建新的 Blueprint"
echo "   - 点击 'New +' -> 'Blueprint'"
echo "   - 选择你 Fork 的仓库"
echo "   - Render 会自动检测 render.yaml"
echo "   - 点击 'Apply' 开始部署"
echo ""
echo "4️⃣  等待部署完成 (约 5-10 分钟)"
echo "   - 后端 API 会自动部署"
echo "   - 前端静态站点会自动部署"
echo ""
echo "5️⃣  获取你的 URL"
echo "   - 后端: https://sheerid-api-xxx.onrender.com"
echo "   - 前端: https://sheerid-frontend-xxx.onrender.com"
echo ""
echo "6️⃣  更新前端配置"
echo "   编辑 index.html，将 BACKEND_URL 改为你的后端 URL"
echo ""
echo "✅ 完成！访问你的前端 URL 即可使用"
echo ""
echo "💡 提示: 免费套餐在 15 分钟无活动后会休眠"
echo "   首次访问可能需要等待 30-60 秒唤醒"
echo ""
