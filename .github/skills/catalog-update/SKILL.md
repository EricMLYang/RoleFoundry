---
name: catalog-update
description: Update or add archetypes in catalog/archetypes/ based on real usage experience. Use when user says "根據這個 Repo 更新原型", "幫我把實際使用的改進同步回 catalog", "[角色名] 的原型技能已過時，需要更新", or "為 catalog 新增一個 [角色名] 原型".
---

# Skill: catalog-update — 目錄演進

## 用途（Purpose）

根據真實使用經驗，將學習點回饋到 `catalog/archetypes/`，或為目錄新增全新原型。
這是 RoleFoundry 生命週期閉環的最後一哩路：**鍛造 → 使用 → 回饋 → 改進原型**。

- **輸入**：真實角色 Repo 路徑 或 口頭描述的改進項
- **輸出**：更新後的 catalog 原型檔案 + 變更記錄

## 何時使用（When to Use）

觸發條件符合以下任一項即啟動本技能：
- 「根據這個 Repo 更新原型」
- 「幫我把實際使用的改進同步回 catalog」
- 「[角色名] 的原型技能已過時，需要更新」
- 「為 catalog 新增一個 [角色名] 原型」

---

## 前置條件（Prerequisites）

- `catalog/archetypes/_index.yaml` 已存在（更新操作）或目標 alias 已確定（新增操作）
- 使用者能提供真實 Repo 路徑，或能描述具體的改進項目

---

## 流程（Process）

### Step 1: 操作識別 [interactive]

詢問兩件事：

**1a. 操作類型**

```
請選擇操作類型：
(A) 更新現有原型（根據實際使用經驗改進 catalog 中的原型）
(B) 新增全新原型（為 catalog 加入目前沒有的角色類型）
```

**1b. 變更來源**

```
請選擇變更來源：
(1) 參考真實 Repo → 提供 Repo 路徑，Agent 自動掃描並比對差異
(2) 直接描述 → 口頭說明要改什麼，Agent 記錄並歸類
```

若為操作 **(A)**，讀取 `catalog/archetypes/_index.yaml`，以清單格式展示所有現有原型，請使用者確認目標原型 alias。

若為操作 **(B)**，詢問：
- 新原型的中文名稱與英文 alias
- 是否有參考的真實 Repo（有的話轉為來源 (1)）

---

### Step 2: 差異分析 [autonomous]

**來源 (1) — 真實 Repo 掃描**

讀取真實 Repo 的以下檔案，與 catalog 中對應原型比對，列出候選更新項：

| 真實 Repo 檔案 | 比對 catalog 的哪個部分 |
|---------------|----------------------|
| `.ai/identity.yaml` | `archetype.yaml` 的 `defaults.role` + `defaults.identity` |
| `.ai/principles.md` | `archetype.yaml` 的 `discovery_questions.principles` + `sample-principles.md` |
| `.github/skills/_index.yaml` | `skills/_index.yaml` + `archetype.yaml` 的 `defaults.capabilities` |
| `AGENTS.md` 的 boundaries 段 | `archetype.yaml` 的 `defaults.boundaries` |
| 每個 `SKILL.md` 的觸發條件 | archetype `skills/*/SKILL.md` 的觸發條件欄位 |

**新增操作（B）+ 來源 (1)**：以真實 Repo 為模板，產生全新 archetype 的初稿結構。

**來源 (2) — 口頭描述**

將使用者描述歸類到以下變更類型，展示分類結果供確認：

| 變更類型 | 說明 |
|---------|------|
| 技能變更 | 新增 / 修改 / 移除 archetype 的預設技能 |
| 邊界變更 | owns / advises / defers_to 欄位更新 |
| 視角 / 語氣變更 | perspective 或 communication_style 調整 |
| 反模式新增 | common_anti_patterns 補充 |
| 術語更新 | `.ai/knowledge/glossary.yaml` 更新 |

---

### Step 3: 變更提案確認 [interactive]

以分類清單展示所有候選更新，每項標明：

```
📁 影響的檔案：{檔案路徑}
🔄 現有內容：{現有值，或「（無）」}
   建議內容：{建議值}
⚠️  備注：{潛在衝突或需 domain-expert 確認的說明}（若無則省略）
```

詢問使用者：
- 「全部接受」
- 「逐項確認」（逐條顯示，使用者逐條批准或跳過）
- 「全部取消」

**不允許跳過此步驟直接修改 catalog。**

---

### Step 4: 應用變更 [autonomous]

按確認清單依序更新。可變更的對象及對應檔案：

| 變更對象 | 修改的檔案 |
|---------|----------|
| 技能新增 | `skills/` 新目錄 + `SKILL.md` + `changelog.md` + `checklist.md`；更新 `skills/_index.yaml` |
| 技能內容修改 | 對應 `skills/{alias}/SKILL.md` |
| 技能範疇 / 觸發更新 | `skills/_index.yaml` + `SKILL.md` |
| identity 預設值 | `archetype.yaml` 的 `defaults.*` 欄位 |
| discovery_questions | `archetype.yaml` 的 `discovery_questions.*` 欄位 |
| 反模式 | `archetype.yaml` 的 `common_anti_patterns` |
| sample-principles | `sample-principles.md` |
| 術語 | `.ai/knowledge/glossary.yaml` |
| 邊界定義 | `archetype.yaml` 的 `defaults.boundaries` |
| 新增原型（操作 B）| 新建整個 `{alias}/` 目錄 + 所有標準檔案；更新 `_index.yaml` |

**新增原型（操作 B）時的標準檔案清單**：
- `archetype.yaml`
- `sample-principles.md`
- `.ai/identity.yaml`
- `.ai/principles.md`
- `.ai/knowledge/glossary.yaml`
- `.ai/interfaces/exports.yaml`
- `skills/_index.yaml`
- 初始技能目錄（1-3 個，各含 `SKILL.md` + `changelog.md` + `checklist.md` + `examples/`）

---

### Step 5: 記錄變更 [autonomous]

1. 更新 `catalog/archetypes/_index.yaml` 中對應原型的 `last_updated` 欄位
2. 在修改的技能 `changelog.md` 中記錄本次更新（若技能有修改）
3. 在 `catalog/archetypes/{alias}/archetype.yaml` 新增或更新 `last_updated` 欄位
4. 在 `.ai/memory/evolution.md` 補充本次 catalog 演進記錄，格式如下：

```markdown
## {日期} — {原型名稱} 更新
- **來源**：{真實 Repo 路徑 或 口頭描述摘要}
- **變更摘要**：{2-3 行說明主要改了什麼}
- **影響的檔案**：{修改的檔案列表}
```

---

## 品質標準（Quality Gates）

- Step 3 使用者確認前，不得自動修改任何 catalog 檔案
- 技能新增時必須包含三件套：`SKILL.md` + `changelog.md` + `checklist.md`
- 新增原型必須有 `archetype.yaml`（含 `defaults` + `discovery_questions` + `common_anti_patterns`）
- 每次更新後必須在 `evolution.md` 補充記錄
- 變更提案中，凡涉及領域知識正確性的項目，必須標記 ⚠️ 提醒使用者確認

---

## 已知限制（Limitations）

- 本技能修改的是「原型預設值」，不影響任何已鍛造的角色 Repo（不做反向同步）
- 術語（glossary.yaml）的正確性屬於 domain-expert 職責，Agent 只負責記錄和格式化
- 若真實 Repo 結構不符合 Framework v2，掃描結果可能不完整
