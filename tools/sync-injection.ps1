#!/usr/bin/env pwsh
# sync-injection.ps1 — 同步 foundry-lite.md 到目標 Repo
# 使用方式：./tools/sync-injection.ps1 <目標Repo路徑>
# 用途：當 RoleFoundry 的 foundry-lite.md 更新後，同步到所有已注入的目標 Repo

param(
  [Parameter(Mandatory = $true)]
  [string]$Target
)

$sourceLite = Join-Path $PSScriptRoot "..\.ai\interfaces\injections\foundry-lite.md"
$targetAgentsDir = Join-Path $Target ".github/agents"
$targetLite = Join-Path $targetAgentsDir "foundry-lite.agent.md"

Write-Host "🔄 RoleFoundry Sync Injection"
Write-Host ""

if (-not (Test-Path $sourceLite)) {
  Write-Host "❌ 來源檔案不存在：$sourceLite"
  exit 1
}

if (-not (Test-Path $targetAgentsDir)) {
  Write-Host "⚠️  目標目錄不存在：$targetAgentsDir"
  Write-Host "   正在建立..."
  New-Item -Path $targetAgentsDir -ItemType Directory -Force | Out-Null
}

$importsFile = Join-Path $Target ".ai/interfaces/imports.yaml"
if (Test-Path $importsFile) {
  $hasDependency = Select-String -Path $importsFile -Pattern "role-foundry" -Quiet
  if (-not $hasDependency) {
    Write-Host "⚠️  目標 Repo 的 imports.yaml 中未找到 role-foundry 依賴。"
    Write-Host "   建議先使用 interface-wiring Skill 建立正式的介面配線。"
    Write-Host ""
  }
}

if (Test-Path $targetLite) {
  Write-Host "📄 更新既有的 foundry-lite.agent.md..."
} else {
  Write-Host "📄 注入 foundry-lite.agent.md（首次）..."
}

Copy-Item -Path $sourceLite -Destination $targetLite -Force
Write-Host "  ✅ 已同步：$targetLite"

Write-Host ""
Write-Host "✅ 同步完成！"
Write-Host ""
Write-Host "提示：同步後建議確認以下事項："
Write-Host "  1. 目標 Repo 的 .github/agents/foundry-lite.agent.md 內容是否正確"
Write-Host "  2. 目標 Repo 的 imports.yaml 是否有 role-foundry 依賴記錄"
Write-Host "  3. 目標 Repo 的 AGENTS.md 是否有引用 .github/agents/ 下的 lite 版"
