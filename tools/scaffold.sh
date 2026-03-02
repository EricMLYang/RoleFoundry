#!/usr/bin/env bash
# scaffold.sh — 建立 Agent Role Repo Framework v2 的目錄骨架
# 使用方式：./tools/scaffold.sh <目標目錄>
# 冪等：只建立不存在的目錄和檔案

set -e

TARGET="${1:?請提供目標目錄路徑，例如：./tools/scaffold.sh /path/to/new-repo}"

echo "🔨 RoleFoundry Scaffold"
echo "目標目錄：$TARGET"
echo ""

# 建立目錄結構
dirs=(
  ".github/skills"
  ".github/prompts"
  ".github/agents"
  ".ai/knowledge/standards"
  ".ai/interfaces/injections"
  ".ai/memory"
  "context/framework"
  "context/references"
  "context/examples"
  "templates/bridge-files"
  "tools"
  "docs"
)

echo "📁 建立目錄結構..."
for dir in "${dirs[@]}"; do
  full_path="$TARGET/$dir"
  if [ ! -d "$full_path" ]; then
    mkdir -p "$full_path"
    echo "  ✅ 建立：$dir/"
  else
    echo "  ⏭️  已存在：$dir/"
  fi
done

# 建立必要的空檔案（stub）
stubs=(
  "AGENTS.md"
  "CLAUDE.md"
  "GEMINI.md"
  "README.md"
  ".github/copilot-instructions.md"
  ".github/skills/_index.yaml"
  ".ai/identity.yaml"
  ".ai/principles.md"
  ".ai/interfaces/exports.yaml"
  ".ai/interfaces/imports.yaml"
  ".ai/memory/decisions.md"
  ".ai/memory/lessons.md"
  ".ai/memory/evolution.md"
)

echo ""
echo "📄 建立必要檔案（stub）..."
for stub in "${stubs[@]}"; do
  full_path="$TARGET/$stub"
  if [ ! -f "$full_path" ]; then
    # 建立帶有提示的空 stub
    echo "# $stub — TODO: 填入內容（參考 role-bootstrap Skill）" > "$full_path"
    echo "  ✅ 建立：$stub"
  else
    echo "  ⏭️  已存在：$stub"
  fi
done

echo ""
echo "✅ 目錄骨架建立完成！"
echo ""
echo "下一步："
echo "  1. 使用 role-bootstrap Skill 填入所有檔案的內容"
echo "  2. 或參考 RoleFoundry/context/examples/ 下的範例"
echo "  3. 完成後使用 validate-repo.sh 驗證結構"
echo ""
echo "  ./tools/validate-repo.sh $TARGET"
