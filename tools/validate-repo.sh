#!/usr/bin/env bash
# validate-repo.sh — 驗證 Agent Role Repo Framework v2 的結構完整性
# 使用方式：./tools/validate-repo.sh <目標目錄>
# 退出碼：0 = 通過，1 = 有必要檔案缺失
# 注意：只檢查檔案存在性，不檢查內容品質（內容品質用 repo-healthcheck Skill）

set -e

TARGET="${1:-.}"  # 預設為當前目錄

echo "🔍 RoleFoundry Validate"
echo "檢查目錄：$TARGET"
echo ""

PASS=0
FAIL=0

check_required() {
  local path="$TARGET/$1"
  if [ -e "$path" ]; then
    echo "  ✅ $1"
    ((PASS++)) || true
  else
    echo "  ❌ $1  (必要)"
    ((FAIL++)) || true
  fi
}

check_recommended() {
  local path="$TARGET/$1"
  if [ -e "$path" ]; then
    echo "  ✅ $1"
    ((PASS++)) || true
  else
    echo "  ⚠️  $1  (建議，非必要)"
  fi
}

echo "=== 必要檔案 ==="
check_required "AGENTS.md"
check_required "CLAUDE.md"
check_required "GEMINI.md"
check_required ".github/copilot-instructions.md"
check_required ".github/skills/_index.yaml"
check_required ".ai/identity.yaml"
check_required ".ai/principles.md"
check_required ".ai/interfaces/exports.yaml"
check_required ".ai/interfaces/imports.yaml"
check_required ".ai/memory/decisions.md"

echo ""
echo "=== 建議檔案 ==="
check_recommended "README.md"
check_recommended ".ai/knowledge/glossary.yaml"
check_recommended ".ai/knowledge/heuristics.md"
check_recommended ".ai/memory/lessons.md"
check_recommended ".ai/memory/evolution.md"

echo ""
echo "=== 結果 ==="
echo "  通過：$PASS 個必要檔案"

if [ "$FAIL" -eq 0 ]; then
  echo "  ✅ 結構驗證通過（0 個必要檔案缺失）"
  echo ""
  echo "提示：結構通過不代表內容品質。"
  echo "      使用 repo-healthcheck Skill 做完整品質評估。"
  exit 0
else
  echo "  ❌ 結構驗證失敗（$FAIL 個必要檔案缺失）"
  echo ""
  echo "修復方式："
  echo "  1. 使用 scaffold.sh 補建缺失的目錄和空檔案"
  echo "  2. 使用 role-bootstrap Skill 填入必要內容"
  exit 1
fi
