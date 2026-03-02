#!/usr/bin/env bash
# sync-injection.sh — 同步 foundry-lite.md 到目標 Repo
# 使用方式：./tools/sync-injection.sh <目標Repo路徑>
# 用途：當 RoleFoundry 的 foundry-lite.md 更新後，同步到所有已注入的目標 Repo

set -e

SOURCE_LITE="$(dirname "$0")/../.ai/interfaces/injections/foundry-lite.md"
TARGET="${1:?請提供目標 Repo 路徑，例如：./tools/sync-injection.sh /path/to/project-repo}"
TARGET_AGENTS_DIR="$TARGET/.github/agents"
TARGET_LITE="$TARGET_AGENTS_DIR/foundry-lite.agent.md"

echo "🔄 RoleFoundry Sync Injection"
echo ""

# 確認來源檔案存在
if [ ! -f "$SOURCE_LITE" ]; then
  echo "❌ 來源檔案不存在：$SOURCE_LITE"
  exit 1
fi

# 確認目標 Repo 有 .github/agents/ 目錄
if [ ! -d "$TARGET_AGENTS_DIR" ]; then
  echo "⚠️  目標目錄不存在：$TARGET_AGENTS_DIR"
  echo "   正在建立..."
  mkdir -p "$TARGET_AGENTS_DIR"
fi

# 確認目標 Repo 的 imports.yaml 有引用 foundry-lite
IMPORTS_FILE="$TARGET/.ai/interfaces/imports.yaml"
if [ -f "$IMPORTS_FILE" ]; then
  if ! grep -q "role-foundry" "$IMPORTS_FILE"; then
    echo "⚠️  目標 Repo 的 imports.yaml 中未找到 role-foundry 依賴。"
    echo "   建議先使用 interface-wiring Skill 建立正式的介面配線。"
    echo ""
  fi
fi

# 複製 lite 版
if [ -f "$TARGET_LITE" ]; then
  echo "📄 更新既有的 foundry-lite.agent.md..."
  cp "$SOURCE_LITE" "$TARGET_LITE"
  echo "  ✅ 已更新：$TARGET_LITE"
else
  echo "📄 注入 foundry-lite.agent.md（首次）..."
  cp "$SOURCE_LITE" "$TARGET_LITE"
  echo "  ✅ 已注入：$TARGET_LITE"
fi

echo ""
echo "✅ 同步完成！"
echo ""
echo "提示：同步後建議確認以下事項："
echo "  1. 目標 Repo 的 .github/agents/foundry-lite.agent.md 內容是否正確"
echo "  2. 目標 Repo 的 imports.yaml 是否有 role-foundry 依賴記錄"
echo "  3. 目標 Repo 的 AGENTS.md 是否有引用 .github/agents/ 下的 lite 版"
