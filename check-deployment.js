#!/usr/bin/env node

/**
 * 部署状态检查工具
 * 检查后端 API 是否正常运行
 */

const https = require('https');
const http = require('http');

const colors = {
    reset: '\x1b[0m',
    green: '\x1b[32m',
    red: '\x1b[31m',
    yellow: '\x1b[33m',
    cyan: '\x1b[36m',
    gray: '\x1b[90m'
};

function log(message, color = 'reset') {
    console.log(`${colors[color]}${message}${colors.reset}`);
}

function checkUrl(url) {
    return new Promise((resolve, reject) => {
        const protocol = url.startsWith('https') ? https : http;
        const startTime = Date.now();
        
        protocol.get(url, (res) => {
            const duration = Date.now() - startTime;
            let data = '';
            
            res.on('data', (chunk) => {
                data += chunk;
            });
            
            res.on('end', () => {
                resolve({
                    status: res.statusCode,
                    duration,
                    data: data.substring(0, 200)
                });
            });
        }).on('error', (err) => {
            reject(err);
        });
    });
}

async function main() {
    log('\n🔍 SheerID Verification Tool - 部署状态检查\n', 'cyan');
    
    // 从 index.html 读取 BACKEND_URL
    const fs = require('fs');
    let backendUrl = null;
    
    try {
        const indexContent = fs.readFileSync('index.html', 'utf8');
        const match = indexContent.match(/const BACKEND_URL = ['"](.+?)['"]/);
        if (match) {
            backendUrl = match[1];
        }
    } catch (err) {
        log('⚠️  无法读取 index.html', 'yellow');
    }
    
    if (!backendUrl) {
        log('请输入你的后端 URL:', 'yellow');
        process.stdout.write('> ');
        
        // 简单的输入读取
        const readline = require('readline');
        const rl = readline.createInterface({
            input: process.stdin,
            output: process.stdout
        });
        
        rl.question('', async (answer) => {
            backendUrl = answer.trim();
            rl.close();
            await runChecks(backendUrl);
        });
    } else {
        await runChecks(backendUrl);
    }
}

async function runChecks(backendUrl) {
    log(`检查后端: ${backendUrl}\n`, 'gray');
    
    // 检查 1: 健康检查
    log('1️⃣  健康检查 (GET /)...', 'cyan');
    try {
        const result = await checkUrl(backendUrl);
        if (result.status === 200) {
            log(`   ✅ 成功 (${result.duration}ms)`, 'green');
            log(`   响应: ${result.data}`, 'gray');
        } else {
            log(`   ⚠️  状态码: ${result.status}`, 'yellow');
        }
    } catch (err) {
        log(`   ❌ 失败: ${err.message}`, 'red');
        log('\n可能的原因:', 'yellow');
        log('  - 后端服务未启动', 'gray');
        log('  - URL 配置错误', 'gray');
        log('  - 网络连接问题', 'gray');
        return;
    }
    
    // 检查 2: API 端点
    log('\n2️⃣  API 端点检查 (GET /api/logs)...', 'cyan');
    try {
        const result = await checkUrl(`${backendUrl}/api/logs`);
        if (result.status === 200) {
            log(`   ✅ SSE 端点正常`, 'green');
        } else {
            log(`   ⚠️  状态码: ${result.status}`, 'yellow');
        }
    } catch (err) {
        log(`   ❌ 失败: ${err.message}`, 'red');
    }
    
    // 总结
    log('\n📊 检查完成！\n', 'cyan');
    log('下一步:', 'yellow');
    log('  1. 确保 index.html 中的 BACKEND_URL 正确', 'gray');
    log('  2. 部署前端到 Render/Vercel', 'gray');
    log('  3. 访问前端 URL 测试完整流程', 'gray');
    log('\n💡 提示: 免费套餐首次访问可能需要 30-60 秒唤醒\n', 'yellow');
}

main();
