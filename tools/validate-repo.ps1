#!/usr/bin/env pwsh
# validate-repo.ps1 — 驗證 Agent Role Repo Framework v2 的結構完整性
# 使用方式：./tools/validate-repo.ps1 <目標目錄>
# 退出碼：0 = 通過，1 = 有必要檔案缺失
# 注意：只檢查檔案存在性，不檢查內容品質（內容品質用 repo-healthcheck Skill）

param(
  [string]$Target = "."
)

$required = @(
  "AGENTS.md",
  "CLAUDE.md",
  "GEMINI.md",
  ".github/copilot-instructions.md",
  ".github/skills/_index.yaml",
  ".ai/identity.yaml",
  ".ai/principles.md",
  ".ai/interfaces/exports.yaml",
  ".ai/interfaces/imports.yaml",
  ".ai/memory/decisions.md"
)

$recommended = @(
  "README.md",
  ".ai/knowledge/glossary.yaml",
  ".ai/knowledge/heuristics.md",
  ".ai/memory/lessons.md",
  ".ai/memory/evolution.md"
)

$requiredPass = 0
$requiredFail = 0
$recommendedPass = 0

function Test-Required {
  param([string]$RelativePath)

  $path = Join-Path $Target $RelativePath
  if (Test-Path $path) {
    Write-Host "  ✅ $RelativePath"
    $script:requiredPass++
  } else {
    Write-Host "  ❌ $RelativePath  (必要)"
    $script:requiredFail++
  }
}

function Test-Recommended {
  param([string]$RelativePath)

  $path = Join-Path $Target $RelativePath
  if (Test-Path $path) {
    Write-Host "  ✅ $RelativePath"
    $script:recommendedPass++
  } else {
    Write-Host "  ⚠️  $RelativePath  (建議，非必要)"
  }
}

Write-Host "🔍 RoleFoundry Validate"
Write-Host "檢查目錄：$Target"
Write-Host ""

Write-Host "=== 必要檔案 ==="
foreach ($file in $required) {
  Test-Required $file
}

Write-Host ""
Write-Host "=== 建議檔案 ==="
foreach ($file in $recommended) {
  Test-Recommended $file
}

Write-Host ""
Write-Host "=== 結果 ==="
Write-Host "  通過：$requiredPass/$($required.Count) 個必要檔案"
Write-Host "  建議檔案：$recommendedPass/$($recommended.Count) 個"

if ($requiredFail -eq 0) {
  Write-Host "  ✅ 結構驗證通過（0 個必要檔案缺失）"
  Write-Host ""
  Write-Host "提示：結構通過不代表內容品質。"
  Write-Host "      使用 repo-healthcheck Skill 做完整品質評估。"
  exit 0
}

Write-Host "  ❌ 結構驗證失敗（$requiredFail 個必要檔案缺失）"
Write-Host ""
Write-Host "修復方式："
Write-Host "  1. 使用 scaffold.sh / scaffold.ps1 補建缺失的目錄和空檔案"
Write-Host "  2. 使用 role-bootstrap Skill 填入必要內容"
exit 1
