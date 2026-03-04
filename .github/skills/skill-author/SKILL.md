---
name: skill-author
description: Add or rewrite a skill for a role repo. Use when user says "幫我為 [角色] 新增一個 [技能名] 的 Skill", "我的 [skill-name] SKILL.md 太空泛", or "把我描述的這個工作流程設計成一個 Skill".
---

# Skill: skill-author — 技能撰寫

## 用途(Purpose)

為既有角色 Repo 新增一個技能,或重寫品質不足的既有技能。

- **輸入**:角色 Repo 的 identity.yaml(或描述)+ 技能需求描述
- **輸出**:完整的 Skill 目錄(`SKILL.md` + `checklist.md` + `changelog.md` + `examples/` 目錄)

## 何時使用（When to Use）

- 「幫我為 [角色] 新增一個 [技能名] 的 Skill」
- 「我的 [skill-name] SKILL.md 太空泛，幫我重寫」
- 「把我描述的這個工作流程設計成一個 Skill」

---

## 前置條件（Prerequisites）

- 目標 Repo 的 identity.yaml 已完成（技能必須與角色身份一致）
- 使用者能大致描述技能的目的（不需要很精確）

---

## 流程（Process）

### Step 1: 技能定位確認 [hybrid]

確認以下三點（如果使用者的描述已經清楚，直接進入 Step 2；如果不清楚，提問）：

**觸發條件**（最重要）：什麼情況下會叫 Agent 用這個技能？
→ 如果使用者說不清楚，問：「上週有沒有一個真實任務，你希望有這個技能來幫你完成？描述一下那個任務。」

**主要產出**：這個技能應該產生什麼？（檔案、報告、設計稿、審查意見...）

**執行模式**：
- 每個步驟都要等使用者確認 → `interactive`
- 可以自主完成，不需要等待 → `autonomous`
- 看情況，有些步驟需要確認，有些不需要 → `hybrid`

### Step 2: SKILL.md 撰寫 [autonomous]

依照以下段落結構產生完整的 SKILL.md：

必須包含以下段落：

| 段落 | 要求 |
|------|------|
| 用途（Purpose）| 1-2 句話，說清楚解決什麼問題；明確說明輸入和輸出 |
| 何時使用（When to Use）| 至少 2 個具體觸發句（使用者真實說的話）|
| 前置條件（Prerequisites）| 執行前需要什麼才能開始 |
| 流程（Process）| 步驟化，每步驟標明 `[interactive / autonomous / hybrid]` |
| 品質標準（Quality Gates）| 可客觀判斷的通過條件（避免「是否充分？」這類主觀問題）|
| 已知限制（Limitations）| 誠實說明這個技能做不到什麼 |

**額外要求**：
- 流程步驟不超過 7 個（超過考慮拆分為兩個 Skill）
- 每個步驟的標題用動詞開頭（「收集需求」而非「需求」）
- 觸發條件不超過 25 字

### Step 3: checklist.md 產生 [autonomous]

從 SKILL.md 的「品質標準」章節直接轉換為 checkbox 清單格式。

**規則**：每條 checkbox 必須是可以客觀判斷「是」或「否」的問句或描述。
避免：「內容是否充分？」（主觀）
推薦：「每個步驟都有 [interactive/autonomous] 標記？」（客觀）

### Step 4: examples/ 規劃 [interactive]

詢問使用者：「你有一個可以示範這個技能的真實案例嗎？」

**如果有**，協助產生：
- `[case-name]-input.md` — 輸入描述（使用者的真實任務描述）
- `[case-name]-output.md` — 期望產出（可以是草稿，使用者後續補完）

**如果沒有**，建立 `examples/README.md`：
```markdown
# examples/

本技能的使用範例。
第一次真實使用後，請將輸入和期望產出補充到這裡。

## 範例格式
- `[case-name]-input.md` — 使用者的輸入描述
- `[case-name]-output.md` — 技能產出的結果
```

### Step 5: changelog.md 初始化 [autonomous]

建立 changelog.md，包含 v1.0 記錄：

```markdown
## v1.0 (日期)
- 初始版本：[簡述主要流程]
- 執行模式：[interactive/autonomous/hybrid]
```

### Step 6: _index.yaml 更新 [autonomous]

將新技能加入目標 Repo 的 `.github/skills/_index.yaml`，填入：
- name、alias、trigger、description、mode、phase、path

---

## 品質標準（Quality Gates）

- SKILL.md 的每個流程步驟都有 `[interactive/autonomous/hybrid]` 標記
- 觸發條件（trigger）用一句話說清楚，不超過 25 字
- checklist.md 所有項目都是可客觀判斷的（避免主觀問題）
- examples/ 目錄存在（即使只有 README.md）

---

## 已知限制（Limitations）

- 技能的實際效果取決於 examples/ 的品質——範例越具體，Agent 產出越穩定
- 如果目標角色的 identity.yaml 不清晰，產出的 Skill 與角色的一致性可能不足
