#!/usr/bin/env pwsh
# scaffold.ps1 — 建立 Agent Role Repo Framework v2 的目錄骨架
# 使用方式：./tools/scaffold.ps1 <目標目錄>
# 冪等：只建立不存在的目錄和檔案

param(
  [Parameter(Mandatory = $true)]
  [string]$Target
)

$dirs = @(
  ".github/skills",
  ".github/prompts",
  ".github/agents",
  ".ai/knowledge/standards",
  ".ai/interfaces/injections",
  ".ai/memory",
  "context/framework",
  "context/references",
  "context/domain",
  "tools",
  "docs"
)

$stubs = @(
  "AGENTS.md",
  "CLAUDE.md",
  "GEMINI.md",
  "README.md",
  ".github/copilot-instructions.md",
  ".github/skills/_index.yaml",
  ".ai/identity.yaml",
  ".ai/principles.md",
  ".ai/interfaces/exports.yaml",
  ".ai/interfaces/imports.yaml",
  ".ai/memory/decisions.md",
  ".ai/memory/lessons.md",
  ".ai/memory/evolution.md"
)

Write-Host "🔨 RoleFoundry Scaffold"
Write-Host "目標目錄：$Target"
Write-Host ""

Write-Host "📁 建立目錄結構..."
foreach ($dir in $dirs) {
  $fullPath = Join-Path $Target $dir
  if (-not (Test-Path $fullPath)) {
    New-Item -Path $fullPath -ItemType Directory -Force | Out-Null
    Write-Host "  ✅ 建立：$dir/"
  } else {
    Write-Host "  ⏭️  已存在：$dir/"
  }
}

Write-Host ""
Write-Host "📄 建立必要檔案（stub）..."
foreach ($stub in $stubs) {
  $fullPath = Join-Path $Target $stub
  if (-not (Test-Path $fullPath)) {
    Set-Content -Path $fullPath -Value "# $stub — TODO: 填入內容（參考 role-bootstrap Skill）"
    Write-Host "  ✅ 建立：$stub"
  } else {
    Write-Host "  ⏭️  已存在：$stub"
  }
}

Write-Host ""
Write-Host "✅ 目錄骨架建立完成！"
Write-Host ""
Write-Host "下一步："
Write-Host "  1. 使用 role-bootstrap Skill 填入所有檔案的內容"
Write-Host "  2. 或參考 RoleFoundry/catalog/archetypes/ 下的角色原型"
Write-Host "  3. 完成後使用 validate-repo 驗證結構"
Write-Host ""
Write-Host "  ./tools/validate-repo.ps1 $Target"
