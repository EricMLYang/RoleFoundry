---
name: role-add
description: Add a lite agent to an existing role repo. Use when user says "幫我新增一個輔助角色", "這個 Repo 需要一個 [角色名] 來協助", "加一個 [角色] agent", or "我需要一個 [角色描述] 的輔助角色".
---

# Skill: role-add — 輔助角色新增

## 用途（Purpose）

當一個既有的角色 Repo 需要新增一個輔助角色（lite agent）時，引導完成輕量級的角色新增流程。
與 `role-bootstrap`（Mode 1：初始化主角色 Repo）互補，本技能是 **Mode 2：為既有 Repo 新增輔助角色**。

- **輸入**：輔助角色描述 + 與主角色的關係
- **輸出**：Agent 檔案 + 專屬技能 + AGENTS.md 更新 + 橋接同步

## 何時使用（When to Use）

觸發條件符合以下任一項即啟動本技能：
- 「幫我新增一個輔助角色」
- 「這個 Repo 需要一個 [角色名] 來協助」
- 「加一個 [角色] agent」
- 「我需要一個 [角色描述] 的輔助角色」

---

## 前置條件（Prerequisites）

- 目標 Repo 已完成 `role-bootstrap`（有完整的主角色結構）
- AGENTS.md 已存在且符合 Framework v2 規範
- 使用者能描述輔助角色的職責與和主角色的關係

---

## 流程（Process）

### Step 1: 輔助角色訪談 [interactive]

**1a. Archetype 匹配（自動）**

讀取 `catalog/archetypes/_index.yaml`，嘗試匹配最接近的原型：
- 若有匹配 → 載入 archetype 預設值作為起點
- 若無匹配 → 從空白開始

**1b. 簡化訪談（4 問）**

輔助角色只需回答 4 個問題（比主角色訪談精簡）：

1. **名稱與定位** — 中文名稱、英文 alias、一句話描述（one_liner）
2. **與主角色的關係** — 主角色 defers_to 輔助角色什麼？輔助角色 defers_to 主角色什麼？
3. **核心技能** — 輔助角色最常被叫去做的 1-3 件事（各附觸發條件）
4. **能力邊界** — 輔助角色 owns 什麼、advises 什麼

訪談完成後，輸出「輔助角色摘要」，等待使用者確認。

### Step 2: 產生 Agent 檔案 [autonomous]

在 `.github/agents/` 下建立 `{role-b-alias}.agent.md`，依照以下結構直接產生：

```markdown
# {角色名稱}（{alias}）

> 輔助角色 — 隸屬於 {主角色名稱} Repo

## Role
- **名稱**：{角色名稱}
- **Alias**：{alias}
- **一句話定位**：{one_liner}

## Responsibilities
{核心職責列表}

## Constraints
**擁有決策權（Owns）**：{owns}
**只給建議（Advises）**：{advises}
**尊重誰的決定（Defers to）**：{defers_to}

## Relationship
**與主角色的協作關係**：
- **主角色 → 本角色**：{主角色何時 defer 給本角色}
- **本角色 → 主角色**：{本角色何時 defer 給主角色}

**協作場景**：
{具體協作場景描述}
```

### Step 3: 產生輔助角色專屬技能 [autonomous]

根據訪談中確認的 1-3 個技能：

- 若匹配到 archetype 且有 `has_prebuilt: true`：
  從 `catalog/archetypes/{alias}/skills/` 複製對應技能
- 若無匹配：
  依照 `skill-author` Skill 的規範直接產生空白技能結構

目錄命名規則：`.github/skills/{role-b-alias}-{skill-alias}/`（加前綴避免與主角色技能衝突）

每個技能包含：`SKILL.md` + `checklist.md` + `changelog.md` + `examples/`

### Step 4: 更新 AGENTS.md [autonomous]

在 AGENTS.md 的技能表之後、跨 Repo 協作之前，新增「## 輔助角色」段落：

```markdown
## 輔助角色

### {角色名稱}（{alias}）

詳見：`.github/agents/{alias}.agent.md`

**定位**：{one_liner}
**與主角色關係**：{relationship_summary}

| 技能名稱 | alias | 觸發條件 | 模式 |
|---------|-------|---------|------|
| ... | ... | ... | ... |
```

同時更新 `.github/skills/_index.yaml`，加入輔助角色的專屬技能。

### Step 5: 同步橋接檔 [autonomous]

呼叫 `copilot-sync` Skill，確保 `.github/copilot-instructions.md` 反映新增的輔助角色資訊。

### Step 6: 品質檢查 [interactive]

逐項確認：

- [ ] `.github/agents/{alias}.agent.md` 格式正確，包含 Role/Responsibilities/Constraints/Relationship
- [ ] `.github/skills/_index.yaml` 包含輔助角色的所有技能
- [ ] AGENTS.md 有「## 輔助角色」段落
- [ ] defer 關係雙向明確（主角色 → 輔助角色、輔助角色 → 主角色）
- [ ] 技能目錄名稱有 `{role-b-alias}-` 前綴
- [ ] copilot-instructions.md 已同步

列出通過項（✅）與未通過項（❌），對未通過項提供修改建議。

---

## 品質標準（Quality Gates）

- Agent 檔案必須包含 4 個區塊（Role / Responsibilities / Constraints / Relationship）
- defer 關係必須雙向明確（主角色知道何時找輔助角色，輔助角色知道何時 defer 給主角色）
- 輔助角色技能數量在 1-3 個之間
- AGENTS.md 更新後仍在 32KB 以內
- 技能目錄有 `{role-b-alias}-` 前綴（防止命名衝突）

---

## 已知限制（Limitations）

- 輔助角色是 lite agent，不產生獨立的 identity.yaml 或 principles.md
- 輔助角色的領域知識需要使用者提供
- 若需要完整的獨立角色，應使用 `role-bootstrap` 建立獨立 Repo
