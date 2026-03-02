# Skill: repo-healthcheck — Repo 健康檢查

---

## 用途（Purpose）

掃描一個角色 Repo 的結構完整性與品質，產出健康報告與改善建議清單。

- **輸入**：目標 Repo 的路徑（可以是當前 Repo 自身，或指定路徑）
- **輸出**：結構化健康報告，含 5 個維度的評分與具體改善建議

---

## 何時使用（When to Use）

- 「幫我檢查這個 Repo 的健康狀況」
- 「這個 Repo 有符合 Framework v2 規範嗎？」
- 「role-bootstrap 完成後，做一次完整品質驗證」
- 定期維護時，檢查 Repo 是否需要更新

---

## 前置條件（Prerequisites）

- 有目標 Repo 的讀取權限
- 目標 Repo 聲稱遵循 Agent Role Repo Framework v2

---

## 流程（Process）

### Step 1: 結構完整性檢查（Structure）[autonomous]

**必要檔案**（缺少任一項 → FAIL）：
```
AGENTS.md
CLAUDE.md
GEMINI.md
.github/copilot-instructions.md
.github/skills/_index.yaml
.ai/identity.yaml
.ai/principles.md
.ai/interfaces/exports.yaml
.ai/interfaces/imports.yaml
.ai/memory/decisions.md
```

**建議檔案**（缺少 → WARN，不 FAIL）：
```
.ai/knowledge/glossary.yaml
.ai/knowledge/heuristics.md
context/framework/（任意 Framework 文件）
README.md
```

計算：Structure Score = 通過必要檔案數 / 必要檔案總數

### Step 2: 身份一致性檢查（Identity）[autonomous]

讀取 `.ai/identity.yaml`，逐項確認：

| 檢查項 | 通過條件 | 結果 |
|--------|---------|------|
| schema_version 存在 | 欄位不為空 | PASS/FAIL |
| type 合法 | 值為 "expert" 或 "project" | PASS/FAIL |
| one_liner 長度 | 不超過 20 個字（中文字符計 1 字）| PASS/WARN |
| boundaries 完整 | 包含 owns、advises、defers_to 三個欄位 | PASS/FAIL |
| defers_to 具體 | 至少 1 條，且有 on 欄位 | PASS/WARN |
| anti_patterns 充足 | 至少 3 條 | PASS/WARN |
| quality_criteria 存在 | 至少 3 條 | PASS/WARN |

讀取 `.ai/principles.md`，確認：

| 檢查項 | 通過條件 |
|--------|---------|
| 有「決策框架」段落 | 文件中出現「決策框架」關鍵字，且有步驟化內容 |
| 每條原則附情境說明 | 文件中有「兩難」或「當...時」等情境描述 |

**交叉確認**：anti_patterns 的主題與 principles 的核心信念是否相互呼應？

Identity Score = 通過項數 / 總檢查項數

### Step 3: 技能品質檢查（Skills）[autonomous]

讀取 `.github/skills/_index.yaml`，對每個 Skill 確認：

| 檢查項 | 通過條件 |
|--------|---------|
| SKILL.md 存在 | 對應路徑的檔案存在 |
| SKILL.md 結構完整 | 包含用途、何時使用、流程、品質標準段落 |
| 觸發條件長度 | trigger 不超過 25 字 |
| 執行模式標記 | SKILL.md 的流程步驟有 [interactive/autonomous/hybrid] |
| checklist.md 存在 | 對應目錄有此檔案 |
| examples/ 存在 | 對應目錄有此目錄（內容可以是空的）|
| changelog.md 存在 | 對應目錄有此檔案 |

**整體技能指標**：
- 技能數量 3-5 個？（過少 WARN，過多 WARN）
- 是否有 interactive 和 autonomous 兩種模式的技能？

Skills Score = 通過項數 / 總檢查項數

### Step 4: 介面健康度（Interfaces）[autonomous]

| 檢查項 | 通過條件 |
|--------|---------|
| exports.yaml 非空 | 至少定義 1 個 skill 或 knowledge export |
| imports.yaml 有說明 | 即使是空的，也有說明原因的注釋 |
| exports 的 lite 版存在 | 如果 exports 中有 lite_version 路徑，對應檔案存在 |
| imports 的 reason 欄位 | 每條 import 有 reason 說明 |

### Step 5: 記憶活躍度（Memory）[autonomous]

| 檢查項 | 通過條件 |
|--------|---------|
| decisions.md 非空 | 至少 1 條決策記錄 |
| lessons.md 存在 | 檔案存在（即使只有模板）|
| evolution.md 存在 | 檔案存在 |
| decisions.md 最近有更新 | 記錄中有日期，且不超過 3 個月前（WARN 而非 FAIL）|

---

## 產出格式

```markdown
# Health Report — [Repo 名稱]
Generated: [日期]
Checked by: repo-healthcheck v1.0

## Summary Score

| 維度 | 得分 | 狀態 |
|------|------|------|
| Structure  | [n/m 必要檔案] | PASS / FAIL |
| Identity   | [n/m 檢查項]   | PASS / WARN / FAIL |
| Skills     | [n/m 檢查項]   | PASS / WARN / FAIL |
| Interfaces | [n/m 檢查項]   | PASS / WARN / FAIL |
| Memory     | [n/m 檢查項]   | PASS / WARN / FAIL |

**Overall: HEALTHY / NEEDS ATTENTION / CRITICAL**

判定規則：
- HEALTHY：Structure PASS + 無 FAIL 項
- NEEDS ATTENTION：有 WARN 但無 FAIL
- CRITICAL：有任何 FAIL 項

---

## Issues（FAIL 項）

### [維度名稱]
- ❌ [問題描述]
  → **修復建議**：[具體說明應該怎麼做，不能只說「補充缺失檔案」]

---

## Warnings（WARN 項）

- ⚠️ [問題描述]

---

## Recommendations（優先改善建議）

1. [最優先] [建議]
2. [次優先] [建議]
```

---

## 品質標準（Quality Gates）

- 報告中每個 FAIL 項必須附具體修復建議（不能只說「補充缺失檔案」）
- 評分要給出數字（n/m 格式），不能只說「通過」或「未通過」
- 完全 autonomous，不詢問使用者任何問題

---

## 已知限制（Limitations）

- 無法評估 SKILL.md 的內容品質（只能檢查結構），內容品質需要人類判斷
- 無法驗證 principles.md 的原則是否「真正來自真實兩難情境」
- 技能計數的「過少/過多」警告是基於 3-5 的建議範圍，實際上每個 Repo 情況不同
