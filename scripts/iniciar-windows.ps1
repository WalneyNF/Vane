param(
    [ValidateSet('dev','production')]
    [string]$Mode = 'dev',
    [switch]$Install
)
$ErrorActionPreference = 'Stop'
Set-Location (Split-Path -Parent $PSScriptRoot)
if (-not (Test-Path 'package.json')) { throw 'package.json nao encontrado.' }
if (-not (Get-Command node -ErrorAction SilentlyContinue)) { throw 'Node.js nao encontrado no PATH.' }
if (-not (Get-Command npm -ErrorAction SilentlyContinue)) { throw 'npm nao encontrado no PATH.' }
New-Item -ItemType Directory -Force -Path 'data' | Out-Null
Write-Host '=== WMK Pesquisa IA V1.0 - Windows / sem Docker ===' -ForegroundColor Cyan
Write-Host ('Node: ' + (& node --version))
Write-Host ('npm: ' + (& npm --version))
try {
    $null = Invoke-RestMethod -Uri 'http://127.0.0.1:11434/api/tags' -TimeoutSec 3
    Write-Host 'Ollama: acessivel na porta 11434' -ForegroundColor Green
} catch {
    Write-Warning 'Ollama nao respondeu em 127.0.0.1:11434. Configure ou inicie o servico se desejar IA local.'
}
if (-not $env:SEARXNG_API_URL) {
    Write-Warning 'SEARXNG_API_URL nao definida. Pesquisa web requer instancia SearXNG externa (sem Docker). Configure no assistente inicial.'
} else {
    Write-Host ('SearXNG configurado: ' + $env:SEARXNG_API_URL)
}
if ($Install -or -not (Test-Path 'node_modules')) {
    Write-Host 'Instalando dependencias...'
    & npm install
    if ($LASTEXITCODE -ne 0) { throw 'Falha no npm install.' }
}
if ($Mode -eq 'production') {
    Write-Host 'Compilando...'
    & npm run build
    if ($LASTEXITCODE -ne 0) { throw 'Falha no build.' }
    & npm run start
} else {
    & npm run dev
}
if ($LASTEXITCODE -ne 0) { throw ('Aplicacao terminou com erro: ' + $LASTEXITCODE) }
