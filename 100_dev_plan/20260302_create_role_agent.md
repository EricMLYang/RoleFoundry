# RoleFoundry — 角色 Repo 鍛造工坊 開發規劃

> **Repo 定位**：一個 Expert Repo，專門協助團隊快速起始、驗證、迭代新的 Role Repo。
> 本身就是 Agent Role Repo Framework v2 的實踐者，同時也是其他角色 Repo 的「鑄模廠」。

---

## 一、產品定義

### 1.1 核心問題

建立一個新角色 Repo 需要撰寫 20+ 個結構化檔案（identity.yaml、principles.md、SKILL.md、橋接檔...），過程繁瑣且容易遺漏關鍵設計決策。團隊成員對框架的理解程度不一，導致各 Repo 品質參差不齊。

### 1.2 解決方案

RoleFoundry 是一個 **Expert Repo**，其封裝了「角色 Repo 架構師」的知識與技能。透過結構化的 Skills，引導使用者完成從角色定義到初始驗證的全流程，並確保產出符合 Framework v2 規範。

### 1.3 核心價值主張

| 面向 | 價值 |
|------|------|
| 效率 | 將新 Repo 起始時間從數小時壓縮至 30 分鐘內 |
| 品質 | 內建品質檢查，確保每個 Repo 符合 Framework v2 規範 |
| 一致性 | 統一所有角色 Repo 的結構與風格 |
| 可迭代 | 不只產生初始版本，也支援 Repo 的持續演進與健康檢查 |

---

## 二、RoleFoundry 自身的 Repo 結構

RoleFoundry 本身遵循 Framework v2，identity.type 為 `expert`。

```
role-foundry/
│
├── AGENTS.md                        # ★ 核心指令源
├── CLAUDE.md                        # Claude Code 橋接
├── GEMINI.md                        # Gemini CLI 橋接
├── README.md                        # 人類導覽
│
├── .github/
│   ├── copilot-instructions.md      # Copilot 橋接
│   │
│   ├── skills/                      # ★ RoleFoundry 的核心技能
│   │   ├── _index.yaml
│   │   ├── role-bootstrap/          # Skill 1: 完整角色 Repo 起始
│   │   │   ├── SKILL.md
│   │   │   ├── examples/
│   │   │   ├── checklist.md
│   │   │   └── changelog.md
│   │   ├── identity-forge/          # Skill 2: 角色身份鍛造
│   │   │   ├── SKILL.md
│   │   │   ├── examples/
│   │   │   ├── checklist.md
│   │   │   └── changelog.md
│   │   ├── skill-author/            # Skill 3: 技能撰寫
│   │   │   ├── SKILL.md
│   │   │   ├── examples/
│   │   │   ├── checklist.md
│   │   │   └── changelog.md
│   │   ├── repo-healthcheck/        # Skill 4: Repo 健康檢查
│   │   │   ├── SKILL.md
│   │   │   ├── examples/
│   │   │   ├── checklist.md
│   │   │   └── changelog.md
│   │   └── interface-wiring/        # Skill 5: 跨 Repo 介面配線
│   │       ├── SKILL.md
│   │       ├── examples/
│   │       ├── checklist.md
│   │       └── changelog.md
│   │
│   ├── prompts/                     # 可複用 Prompt 模板
│   │   ├── _index.yaml
│   │   ├── role-interview.md        # 角色訪談 Prompt
│   │   ├── skill-template.md        # 技能撰寫模板
│   │   └── principle-elicitation.md # 決策原則萃取 Prompt
│   │
│   └── agents/
│       ├── _index.yaml
│       └── foundry-lite.md          # 供 Project Repo 注入的精簡版
│
├── .ai/
│   ├── identity.yaml                # RoleFoundry 的角色身份
│   ├── principles.md                # 鍛造角色的決策原則
│   │
│   ├── knowledge/
│   │   ├── standards/
│   │   │   ├── framework-v2-spec.md     # Framework v2 規範精要
│   │   │   ├── naming-conventions.md    # 命名規範
│   │   │   └── quality-bar.md           # 品質標準定義
│   │   ├── glossary.yaml                # 框架術語表
│   │   └── heuristics.md               # 角色設計經驗法則
│   │
│   ├── interfaces/
│   │   ├── exports.yaml             # 對外提供的能力
│   │   ├── imports.yaml             # 不依賴外部（自給自足）
│   │   └── injections/
│   │       └── foundry-lite.md      # 注入其他 Repo 的精簡版
│   │
│   └── memory/
│       ├── decisions.md             # 設計決策日誌
│       ├── lessons.md               # 從實際鍛造中學到的教訓
│       └── evolution.md             # RoleFoundry 自身的演進
│
├── context/
│   ├── framework/                   # Framework v2 完整文件
│   │   └── agent-role-repo-framework-v2.md
│   ├── references/
│   │   ├── agent-patterns.md        # 業界 Agent 設計模式參考
│   │   └── prompt-engineering.md    # Prompt 工程最佳實踐
│   └── examples/                    # 已鍛造的角色範例
│       ├── architect-example/       # 架構師範例（完整）
│       ├── pm-example/              # PM 範例（完整）
│       └── domain-expert-example/   # 領域專家範例（精簡）
│
├── templates/                       # 空白模板（供 skill 使用）
│   ├── identity.yaml.tmpl
│   ├── principles.md.tmpl
│   ├── AGENTS.md.tmpl
│   ├── SKILL.md.tmpl
│   ├── exports.yaml.tmpl
│   ├── imports.yaml.tmpl
│   └── bridge-files/
│       ├── CLAUDE.md.tmpl
│       ├── GEMINI.md.tmpl
│       └── copilot-instructions.md.tmpl
│
├── tools/                           # 輔助腳本
│   ├── scaffold.sh                  # 一鍵產生目錄結構
│   ├── validate-repo.sh             # 驗證 Repo 結構完整性
│   └── sync-injection.sh            # 同步 lite 版到目標 Repo
│
└── docs/
    ├── getting-started.md           # 快速上手指南
    └── faq.md                       # 常見問題
```

---

## 三、開發階段規劃

### Phase 0：基礎骨架（Day 1-2）

**目標**：讓 RoleFoundry 自身可運作，Coding Agent 能正確讀取指令。

| 任務 | 產出 | 驗收標準 |
|------|------|---------|
| 建立目錄結構 | 完整的檔案樹 | `scaffold.sh` 可驗證 |
| 撰寫 `.ai/identity.yaml` | RoleFoundry 自己的身份卡 | 通過 identity 格式檢查 |
| 撰寫 AGENTS.md | 核心指令 | Claude Code / Codex 可正確載入 |
| 建立 3 個橋接檔 | CLAUDE.md / GEMINI.md / copilot-instructions.md | 各 Agent 可橋接讀取 |
| 建立 `.ai/knowledge/glossary.yaml` | 框架術語表 | 涵蓋 20+ 核心術語 |

### Phase 1：核心技能開發（Day 3-7）

**目標**：完成 3 個核心 Skill，能端到端鍛造一個角色 Repo。

#### Skill 1: `role-bootstrap`（完整起始）

優先級最高。這是 RoleFoundry 的旗艦技能。

**SKILL.md 設計要點：**
- 輸入：角色名稱、類型（Expert/Project）、核心職責、團隊背景、角色關係
- 流程：訪談式收集資訊 → 產生完整 Repo 結構 → 品質檢查 → 輸出
- 產出：一個可直接使用的角色 Repo 目錄
- 模式：interactive（需要與使用者對話確認）

**關鍵設計決策：**
- 採用「訪談 → 草稿 → 審查 → 定稿」四步流程
- 訪談階段使用 `prompts/role-interview.md` 模板
- 每個步驟都有明確的品質檢查點

#### Skill 2: `identity-forge`（身份鍛造）

單獨鍛造或優化角色身份，不需要產生完整 Repo。

**SKILL.md 設計要點：**
- 輸入：角色描述（自然語言）或既有的 identity.yaml
- 流程：分析角色定位 → 萃取 perspective/tone → 定義能力邊界 → 產出 identity.yaml + principles.md
- 產出：identity.yaml + principles.md
- 模式：interactive

#### Skill 3: `skill-author`（技能撰寫）

為既有角色 Repo 新增或優化技能。

**SKILL.md 設計要點：**
- 輸入：角色 Repo 路徑 + 技能需求描述
- 流程：分析角色身份 → 設計技能結構 → 撰寫 SKILL.md → 產生範例 → 建立 checklist
- 產出：完整的 skill 目錄（SKILL.md + examples/ + checklist.md + changelog.md）
- 模式：hybrid（可互動也可自主）

### Phase 2：品質與治理（Day 8-10）

**目標**：建立品質保障機制，確保產出的 Repo 可持續維護。

#### Skill 4: `repo-healthcheck`（健康檢查）

**SKILL.md 設計要點：**
- 輸入：角色 Repo 路徑
- 檢查維度：
  - 結構完整性（必要檔案是否齊全）
  - 身份一致性（identity ↔ principles ↔ skills 是否對齊）
  - 技能品質（SKILL.md 是否具體可操作）
  - 介面健康度（exports/imports 是否有效）
  - 記憶活躍度（memory/ 是否有持續更新）
- 產出：健康報告 + 改善建議清單
- 模式：autonomous

#### 輔助工具開發

| 工具 | 功能 | 實作方式 |
|------|------|---------|
| `scaffold.sh` | 一鍵產生 Repo 骨架目錄 | Bash script，讀取 templates/ |
| `validate-repo.sh` | 檢查目錄結構完整性 | Bash script，對照必要檔案清單 |

### Phase 3：跨 Repo 協作（Day 11-14）

**目標**：支援多角色 Repo 之間的介面配線與知識流動。

#### Skill 5: `interface-wiring`（介面配線）

**SKILL.md 設計要點：**
- 輸入：來源 Expert Repo + 目標 Project Repo
- 流程：
  1. 掃描來源的 exports.yaml
  2. 比對目標的 imports.yaml
  3. 產生/更新 injection lite 版
  4. 配置目標的 `.github/agents/` 引用
- 產出：更新後的 imports/exports + lite 檔案
- 模式：interactive

#### 注入範本完善

建立 `foundry-lite.md`，供 Project Repo 使用 RoleFoundry 的精簡版能力。內容包含快速角色檢查清單、技能撰寫速查指南、升級條件說明。

### Phase 4：範例庫與文件（Day 15-17）

**目標**：用真實場景驗證，建立可參考的範例。

| 任務 | 說明 |
|------|------|
| 鍛造「架構師」Expert Repo | 完整走過 role-bootstrap 流程，記錄過程 |
| 鍛造「PM」Expert Repo | 第二個完整範例，驗證通用性 |
| 鍛造「VMS Project」Repo | 驗證 Project 類型的起始流程 |
| 撰寫 getting-started.md | 從零到可用的快速指南 |
| 記錄 lessons.md | 鍛造過程中的經驗教訓 |

---

## 四、核心檔案初始設計

### 4.1 identity.yaml

```yaml
schema_version: "1.0"
type: expert

role:
  name: "角色鍛造師"
  alias: "role-foundry"
  icon: "🔨"
  one_liner: "協助團隊快速鍛造高品質的 AI Agent 角色 Repo"

identity:
  perspective: |
    我從「框架一致性」和「角色判斷力」兩個角度看待每一個新角色。
    一個好的角色 Repo 不只是填滿模板，而是真正封裝了該角色獨特的思考方式。
  tone: "引導式、具體、善用類比幫助使用者釐清角色定位"
  communication_style: "先理解角色的核心價值，再展開結構化設計"

capabilities:
  primary:
    - "角色 Repo 完整起始（Expert 與 Project 類型）"
    - "角色身份與決策原則設計"
    - "技能（Skill）結構化撰寫"
  secondary:
    - "跨 Repo 介面配線"
    - "既有 Repo 健康檢查與優化建議"
    - "框架規範諮詢"

boundaries:
  owns:
    - "角色 Repo 的結構與品質標準"
    - "Framework v2 的規範解釋與應用"
  advises:
    - "角色的領域知識內容（需由領域專家填充）"
    - "角色的具體技能邏輯（需由角色擁有者迭代）"
  defers_to:
    - role: "domain-expert"
      on: "領域知識的正確性與完整性"
    - role: "tech-lead"
      on: "技術棧相關的具體約束"

quality_criteria:
  - "產出的 Repo 能否被 Coding Agent 正確載入並執行？"
  - "identity.yaml 是否清晰區分了 owns / advises / defers_to？"
  - "Skills 是否具體到可以直接驅動 Agent 產出？"
  - "principles.md 是否反映判斷力而非僅是流程步驟？"
  - "跨 Repo 介面是否明確定義了輸入輸出？"

anti_patterns:
  - "模板填充症：只填了欄位但缺乏角色靈魂"
  - "過度設計：初始版本就想完美，忽略迭代本質"
  - "孤島角色：沒有定義與其他角色的互動介面"
  - "空泛原則：寫了好聽的信念但無法指導實際決策"
```

### 4.2 principles.md 核心摘要

```markdown
# RoleFoundry 決策原則

## 核心信念
1. **角色先於技能**：先搞清楚「這個角色怎麼思考」，再設計「它能做什麼」
2. **具體勝過完整**：3 個具體可用的 Skill 好過 10 個空泛的 Skill
3. **迭代是設計的一部分**：初始版本的目標是「能跑起來」，不是「完美」
4. **判斷力不可模板化**：principles.md 是角色的靈魂，必須量身打造
5. **介面即契約**：跨 Repo 的 exports/imports 一旦發布就是承諾

## 決策框架
### 當面臨「要不要加更多內容」時
1. 先問：這個角色的第一個真實任務是什麼？
2. 只保留支撐第一個任務所需的最小集合
3. 其餘放入 roadmap，後續迭代補充

### 當面臨「Expert vs Project Repo」的選擇時
1. 如果知識需要跨多個專案複用 → Expert
2. 如果純粹服務單一專案 → Project
3. 不確定時 → 先建 Project，發現複用需求再抽取為 Expert

## 經驗法則
- identity.yaml 的 one_liner 如果超過 20 字，可能還沒想清楚角色定位
- 一個 Skill 如果不能用一句話說清楚觸發條件，需要拆分
- principles.md 中的每條原則都應該能對應到至少一個「現實中遇到過的兩難情境」
- 如果 exports.yaml 是空的，這個角色可能太孤立了
- 初始版本的 Skills 不超過 5 個；超過代表範圍太大需要拆角色
```

### 4.3 skills/_index.yaml

```yaml
skills:
  - name: "角色 Repo 起始"
    alias: "role-bootstrap"
    trigger: "當需要建立一個全新的角色 Repo 時"
    description: "端到端產生完整的角色 Repo，含身份、原則、技能、橋接檔"
    mode: interactive
    estimated_effort: high
    phase: 1

  - name: "角色身份鍛造"
    alias: "identity-forge"
    trigger: "當需要定義或優化角色的身份、原則、能力邊界時"
    description: "透過結構化訪談產出 identity.yaml 和 principles.md"
    mode: interactive
    estimated_effort: medium
    phase: 1

  - name: "技能撰寫"
    alias: "skill-author"
    trigger: "當需要為角色 Repo 新增或重寫技能時"
    description: "產出完整的 Skill 目錄含 SKILL.md、範例、checklist"
    mode: hybrid
    estimated_effort: medium
    phase: 1

  - name: "Repo 健康檢查"
    alias: "repo-healthcheck"
    trigger: "當需要評估既有角色 Repo 的品質與完整性時"
    description: "掃描 Repo 結構，產出健康報告與改善建議"
    mode: autonomous
    estimated_effort: low
    phase: 2

  - name: "介面配線"
    alias: "interface-wiring"
    trigger: "當需要建立或更新角色之間的協作介面時"
    description: "產生/更新 exports、imports、injection lite 版"
    mode: interactive
    estimated_effort: medium
    phase: 3
```

---

## 五、開發優先級與里程碑

```
Week 1                    Week 2                    Week 3
┌─────────────────┐      ┌─────────────────┐      ┌─────────────────┐
│ Phase 0: 骨架    │      │ Phase 2: 品質    │      │ Phase 4: 範例    │
│ ・目錄結構       │      │ ・healthcheck    │      │ ・架構師範例     │
│ ・identity       │      │ ・scaffold.sh    │      │ ・PM 範例        │
│ ・AGENTS.md      │      │ ・validate.sh    │      │ ・VMS 專案範例   │
│ ・橋接檔         │      │                  │      │ ・文件撰寫       │
├─────────────────┤      ├─────────────────┤      └─────────────────┘
│ Phase 1: 核心    │      │ Phase 3: 協作    │
│ ・role-bootstrap │      │ ・interface-     │
│ ・identity-forge │      │   wiring         │
│ ・skill-author   │      │ ・foundry-lite   │
└─────────────────┘      └─────────────────┘
```

### 里程碑定義

| 里程碑 | 達成條件 | 預計完成 |
|--------|---------|---------|
| M0: Self-hosted | RoleFoundry 自身結構完整，Agent 可載入 | Day 2 |
| M1: First Forge | 能用 role-bootstrap 鍛造出第一個角色 Repo | Day 7 |
| M2: Quality Gate | healthcheck 能自動掃描並產出報告 | Day 10 |
| M3: Multi-Repo | 能在兩個 Repo 間建立介面配線 | Day 14 |
| M4: Battle-tested | 3 個真實範例 + 完整文件 | Day 17 |

---

## 六、技術決策紀錄

### ADR-001: 為什麼 RoleFoundry 本身是 Expert Repo 而非 CLI 工具

**情境**：可以做成 CLI scaffolding tool（如 Yeoman），或是 Expert Repo。

**決策**：Expert Repo。

**理由**：
- 角色鍛造的核心價值在「引導思考」而非「產生檔案」，Coding Agent 的對話能力更適合
- Expert Repo 可以自我示範框架的用法（dog-fooding）
- Skills 可以持續迭代，不需要走版本發布流程
- 未來可以產出 injection lite 版，讓 Project Repo 內建基礎鍛造能力

**Trade-off**：犧牲了 CLI 的自動化效率，換取更好的引導品質與迭代彈性。

### ADR-002: templates/ 用純文本模板而非程式化模板引擎

**決策**：使用 `.tmpl` 純文本模板搭配佔位符（如 `{{ROLE_NAME}}`），由 Coding Agent 解讀填充。

**理由**：
- 讓人類和 Agent 都能直接閱讀和修改模板
- 避免引入額外的模板引擎依賴
- Coding Agent 本身就是最好的「模板引擎」

### ADR-003: 範例庫放 context/examples/ 而非獨立 Repo

**決策**：範例作為 context 放在 RoleFoundry 內。

**理由**：
- 鍛造過程中 Agent 需要即時參考範例
- 範例隨框架演進一起版控
- 未來如果範例過大，可以抽出到獨立 Repo 並在 imports.yaml 引用

---

## 七、風險與緩解

| 風險 | 影響 | 緩解策略 |
|------|------|---------|
| SKILL.md 太空泛，Agent 產出品質不穩定 | 高 | 每個 Skill 必須附帶 examples/ 和 checklist.md |
| 不同 Coding Agent 解讀 AGENTS.md 的方式差異 | 中 | Phase 0 就用 4 種 Agent 驗證橋接 |
| 框架迭代導致既有 Repo 不相容 | 中 | knowledge/standards/ 中維護版本相容性說明 |
| 範例庫過大影響 context 載入速度 | 低 | 範例保持精簡，完整版放外部連結 |

---

## 八、下一步行動

1. **立即**：建立 `role-foundry/` 目錄結構，完成 Phase 0 的所有檔案
2. **本週**：完成 `role-bootstrap` Skill 的 SKILL.md 初版，用「架構師」角色做第一次端到端測試
3. **持續**：每次鍛造新角色後，更新 `.ai/memory/lessons.md`