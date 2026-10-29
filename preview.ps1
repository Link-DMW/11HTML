# 本地预览：在 11HTML 目录起一个静态 http 服务并打开浏览器
# 用法：.\preview.ps1            默认 8000 端口
#       .\preview.ps1 -Port 8080
param([int]$Port = 8000)

$ErrorActionPreference = 'Stop'
Set-Location -LiteralPath $PSScriptRoot

if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    throw '没找到 python，无法起 http.server。装 Python 或改用 npx serve。'
}

$url = "http://127.0.0.1:$Port/"
Write-Host "本地预览: $url" -ForegroundColor Cyan
Write-Host "按 Ctrl+C 停止" -ForegroundColor DarkGray

Start-Process $url
python -m http.server $Port
