# 品質標準定義

> 定義什麼是「PASS」、「WARN」、「FAIL」，供 repo-healthcheck Skill 使用。

---

## 整體判定規則

| 等級 | 條件 |
|------|------|
| **HEALTHY** | Structure 維度 PASS + 無任何 FAIL 項 |
| **NEEDS ATTENTION** | 有 WARN 項，但無 FAIL 項 |
| **CRITICAL** | 有任何 FAIL 項 |

---

## 最小可行 Repo（M0 標準）

滿足以下條件即可宣告 M0（self-hosted）：

- [ ] `AGENTS.md` 存在且 < 32KB
- [ ] `CLAUDE.md` 存在，包含重導向至 AGENTS.md 的語句
- [ ] `GEMINI.md` 存在，包含 `@./AGENTS.md`
- [ ] `.github/copilot-instructions.md` 存在，含技能清單
- [ ] `.ai/identity.yaml` 存在，包含全部 8 個頂層 key
- [ ] `.ai/principles.md` 存在，包含至少 1 個決策框架

---

## 完整品質 Repo（M4 標準）

滿足以下條件即可宣告 M4（battle-tested）：

### Structure 維度（10/10）
- 10 個必要檔案全部存在

### Identity 維度（全 PASS）
- one_liner ≤ 20 字
- perspective 描述視角（非職責）
- anti_patterns ≥ 3 條，每條有真實情境描述
- defers_to ≥ 1 條，含具體 on 欄位
- principles.md 有決策框架段落

### Skills 維度（全 PASS）
- 每個 Skill 的 SKILL.md 包含 5 個必要段落
- 每個 Skill 有 examples/（至少一個範例對）
- 觸發條件 ≤ 25 字
- 技能數量在 3-5 之間

### Interfaces 維度（全 PASS）
- exports.yaml 至少定義 1 個 export
- exports 中的 lite_version 路徑對應到實際存在的檔案

### Memory 維度（全 PASS）
- decisions.md 有至少 1 條記錄
- lessons.md 有至少 3 條真實鍛造觀察
- evolution.md 更新到最新里程碑

---

## 評分說明

### PASS / WARN / FAIL 判定

| 狀態 | 意義 | 影響 |
|------|------|------|
| PASS | 符合規範 | 無 |
| WARN | 不符合建議，但不阻礙基本功能 | 不影響 HEALTHY 判定 |
| FAIL | 缺少必要內容或明顯違反規範 | 導致 CRITICAL 判定 |

### 常見 WARN 情境

- one_liner 超過 20 字（建議，非強制）
- anti_patterns 只有 2 條（建議 3+ 條）
- examples/ 目錄是空的（有目錄但無內容）
- Memory 超過 3 個月未更新

### 常見 FAIL 情境

- 必要檔案缺失（AGENTS.md、identity.yaml 等）
- identity.yaml 缺少 defers_to 欄位（表示角色沒有謙遜邊界）
- exports.yaml 完全為空（表示角色完全孤立，無法被其他 Repo 使用）
- SKILL.md 缺少流程段落（技能不可執行）
