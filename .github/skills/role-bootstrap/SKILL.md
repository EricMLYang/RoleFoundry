# Skill: role-bootstrap — 完整角色 Repo 起始

> **旗艦技能**：RoleFoundry 最核心的能力。端到端引導完成一個符合 Framework v2 規範的角色 Repo。

---

## 用途（Purpose）

當使用者需要建立一個全新的角色 Repo 時，引導完成從角色定義到可用 Repo 的端到端流程。

- **輸入**：自然語言角色描述
- **輸出**：符合 Framework v2 的完整角色 Repo（所有必要檔案齊全）

---

## 何時使用（When to Use）

觸發條件符合以下任一項即啟動本技能：
- 「幫我建立一個新的角色 Repo」
- 「我想鍛造一個 [角色名] 的 Expert Repo」
- 「幫我起始一個 Project Repo」
- 「我需要一個 [角色描述] 的 Agent」

---

## 前置條件（Prerequisites）

- 使用者能說出角色的大致職責（不需要很精確，訪談過程會釐清）
- 使用者知道 Expert 或 Project 類型（不確定時協助判斷）
- 本 Repo（RoleFoundry）已完整載入（AGENTS.md + .ai/ + context/）

---

## 流程（Process）

### Step 1: 角色訪談 [interactive]

**1a. Archetype 匹配（自動）**

先讀取 `context/archetypes/_index.yaml`，根據使用者描述的角色自動匹配最接近的原型：
- 若有匹配 → 載入對應的 `archetype.yaml` 作為預設值，告知使用者「已匹配到 [原型名稱] 原型，以下預設值可直接採用或調整」
- 若無匹配 → 告知使用者「未找到匹配的角色原型，將從空白開始訪談」
- 若有部分匹配 → 列出候選原型和 `variants_hint`，讓使用者選擇最接近的

匹配到原型後，使用 `discovery_questions` 引導使用者客製化，而非逐一詢問所有問題。

**1b. 結構化訪談**

載入 `.github/prompts/role-interview.prompt.md` 的訪談結構，向使用者提問以下 6 個問題（可以對話方式進行，不需要使用者正式填寫）。若已載入 archetype 預設值，可跳過已有答案的問題，聚焦在需要客製的部分：

1. **角色基本資料**：名稱（中文）、英文 alias、類型（Expert/Project）
2. **一句話定位**：格式「確保 [目標] 在 [約束條件] 下 [達成方式]」，引導使用者凝練出 one_liner
3. **能力邊界**：owns（決策權）、advises（只給建議）、defers_to（尊重誰的決定）
4. **視角與風格**：用比喻描述思考方式，確認溝通風格
5. **初始技能**：最常被叫去做的 3-5 件事，各附觸發條件
6. **反模式**：這個角色表現不佳時，最容易犯什麼錯

訪談完成後，輸出「角色訪談摘要」（markdown 格式），等待使用者確認或修正。

### Step 2: 結構規劃 [autonomous]

基於訪談結果，規劃：
- 完整目錄結構（markdown tree 格式）
- 每個初始 Skill 的 alias 與觸發條件

參照 `context/framework/agent-role-repo-framework-v2.md` 確認結構符合規範。
若使用了 archetype，參照 `context/archetypes/` 對應的 `sample-principles.md` 作為品質基準。

輸出：目錄結構圖，等待使用者確認。

### Step 3: 核心檔案產生 [autonomous]

按以下順序產生（後者依賴前者，不可調整順序）：

1. `.ai/identity.yaml` — 角色靈魂，最重要，使用 `templates/identity.yaml.tmpl`
2. `.ai/principles.md` — 判斷框架，使用 `templates/principles.md.tmpl`
3. `AGENTS.md` — 核心指令源，使用 `templates/AGENTS.md.tmpl`
4. `CLAUDE.md` / `GEMINI.md` / `.github/copilot-instructions.md` — 三個橋接檔，使用 `templates/bridge-files/` 下的模板
5. `.github/skills/_index.yaml` — 技能清單，含觸發條件與模式
6. 每個初始 Skill 的目錄結構：`SKILL.md`（框架完整版）+ `checklist.md` + `changelog.md` + 空的 `examples/`
7. `.ai/interfaces/exports.yaml` + `imports.yaml` — 介面定義
8. `.ai/knowledge/glossary.yaml` — 至少 10 個核心術語
9. `.ai/memory/decisions.md` — 記錄本次鍛造的關鍵設計決策
10. **預設技能**（自動包含，不需使用者設定）：
    讀取 RoleFoundry 的 `templates/_defaults.yaml`，
    將其中所有預設技能從 `templates/default-skills/` 複製到目標 Repo 的 `.github/skills/`，
    並將每個預設技能加入 _index.yaml。
    目前預設技能：skill-expand（技能擴充）

**注意**：AGENTS.md 必須在 32KB 以內。使用 `see：` 引用而非嵌入大量內容。

### Step 4: 品質審查 [interactive]

產生完成後，執行內建品質檢查（直接逐條確認，不需啟動 repo-healthcheck Skill）：

**身份品質（identity.yaml）**
- [ ] 包含所有 6 個頂層區塊？（schema_version, type, role, identity, capabilities, boundaries, quality_criteria, anti_patterns）
- [ ] one_liner 不超過 20 字？
- [ ] boundaries.defers_to 至少有 1 條，且 `on` 欄位很具體？
- [ ] anti_patterns 至少 3 條，且基於真實情境？

**判斷力品質（principles.md）**
- [ ] 每條核心信念對應至少一個真實兩難情境？
- [ ] 有「決策框架」段落（不只是信念列表）？

**技能品質（skills）**
- [ ] 每個 Skill 的觸發條件用一句話說清楚？（不超過 25 字）
- [ ] Skill 數量在 3-5 個之間？

**介面品質（interfaces）**
- [ ] exports.yaml 不為空？
- [ ] AGENTS.md 大小在 32KB 以內？

**橋接同步（copilot-instructions.md）**
- [ ] copilot-instructions.md 的技能表與 _index.yaml 一致？
- [ ] 角色識別（one_liner、perspective）與 identity.yaml 一致？
- [ ] 「完整版請參閱 AGENTS.md」連結存在？

列出通過項（✅）與未通過項（❌），對未通過項提供具體修改建議。

### Step 5: 產出摘要 [autonomous]

產生產出摘要：
- 角色名稱與一句話定位
- 建立的檔案清單（按目錄分組）
- 推薦的「第一個真實任務」——用來驗證 Repo 是否可用
- 建議的後續迭代方向（按優先順序）
- 提示：建議使用 `repo-healthcheck` Skill 做完整品質驗證

---

## 品質標準（Quality Gates）

- 產出的 AGENTS.md 必須在 32KB 以內
- identity.yaml 的 perspective 必須描述「視角」而非「職責清單」
- 每個初始 Skill 必須有 examples/ 目錄（可以是空目錄，但必須存在）
- principles.md 必須有「決策框架」段落（不只是信念列表）
- 所有橋接檔必須齊全（CLAUDE.md、GEMINI.md、.github/copilot-instructions.md）

---

## 已知限制（Limitations）

- 無法自動填充領域知識（`context/` 下的內容需使用者提供）
- 初始 Skill 的 SKILL.md 是「框架合規」的，但需要角色擁有者迭代實際內容品質
- examples/ 在初始版本中為空，需要在第一次真實使用後補充
