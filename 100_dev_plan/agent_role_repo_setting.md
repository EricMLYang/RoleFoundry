# Agent Role Repo Framework v2

## 設計哲學

**AI 時代的護城河是「編碼過的判斷力」。** 每個 Repo 是一個角色的「技能容器」——封裝了分析框架、決策邏輯、品質標準與溝通風格。

核心原則：**一份 Markdown 為王，各 Agent 只做橋接。**

---

## 一、Multi-Agent 橋接架構

團隊混用 Claude Code、GitHub Copilot、Codex CLI、Gemini CLI。
最穩健的做法是「一個核心 Markdown + 各自的 Router 設定檔」。

### 各 Agent 的預設讀取檔

| Agent | 預設讀取檔 | 橋接方式 |
|-------|-----------|---------|
| **Codex CLI** | `AGENTS.md`（原生） | 不需橋接，直接就是核心 |
| **Claude Code** | `CLAUDE.md` | 內容指向 AGENTS.md |
| **GitHub Copilot** | `.github/copilot-instructions.md` | 內容指向 AGENTS.md |
| **Gemini CLI** | `GEMINI.md` | 用 `@./AGENTS.md` import 語法 |

### 各橋接檔的內容

**CLAUDE.md**
```markdown
# Claude Code Entry Point

請閱讀並遵循本 Repo 的核心指令文件：AGENTS.md

技能（Skills）、Prompts、Agent 定義位於 .github/ 目錄下，
角色身份與知識體系位於 .ai/ 目錄下，
大量上下文資料位於 context/ 目錄下。

詳細的目錄導覽與工作規範，請見 AGENTS.md。
```

**GEMINI.md**
```markdown
@./AGENTS.md
```
> Gemini CLI 原生支援 `@file.md` import 語法，會自動展開內容。

**.github/copilot-instructions.md**
```markdown
# GitHub Copilot Instructions

本 Repo 的完整工作規範定義在根目錄的 AGENTS.md。
以下為 Copilot 需要遵循的核心摘要：

## 角色
見 .ai/identity.yaml

## 編碼規範
見 .ai/knowledge/standards/

## Skills 與 Prompts
見 .github/skills/ 和 .github/prompts/

---
完整版請參閱 AGENTS.md。
```

> **注意**：GitHub Copilot 不支援 import 語法，所以 copilot-instructions.md 需要放一份精簡摘要 + 指向 AGENTS.md 的引導。Copilot 在 Chat 模式下可以被要求「讀取 AGENTS.md」，但 inline suggestions 只看 copilot-instructions.md。

### Codex CLI 補充設定

Codex CLI 也支援專案層級的 `.codex/config.toml`，可選擇性配置：

```toml
# .codex/config.toml（可選）
# 提高 AGENTS.md 讀取上限（預設 32KB）
project_doc_max_bytes = 65536
```

---

## 二、目錄結構

```
<role-or-project-repo>/
│
├── AGENTS.md                        # ★ 核心本體（Codex 原生 + 所有 Agent 的指令源）
├── CLAUDE.md                        # Claude Code 橋接 → AGENTS.md
├── GEMINI.md                        # Gemini CLI 橋接 → @./AGENTS.md
├── README.md                        # 人類閱讀用
│
├── .github/                         # === Skills / Prompts / Agents ===
│   │                                #     (以 GitHub Copilot 設定為主目錄)
│   ├── copilot-instructions.md      # Copilot 橋接 → AGENTS.md 摘要
│   │
│   ├── skills/                      # 技能定義區
│   │   ├── _index.yaml              # 技能清單與觸發條件
│   │   ├── <skill-name>/
│   │   │   ├── SKILL.md             # 技能指令（主 prompt）
│   │   │   ├── examples/            # 輸入/輸出範例對
│   │   │   ├── checklist.md         # 品質檢查清單
│   │   │   └── changelog.md         # 技能演進紀錄
│   │   └── ...
│   │
│   ├── prompts/                     # 可複用 Prompt 模板
│   │   ├── _index.yaml
│   │   └── <prompt-name>.md
│   │
│   └── agents/                      # Agent 定義（含注入的精簡版角色）
│       ├── _index.yaml
│       └── <agent-name>.md
│
├── .codex/                          # Codex CLI 專案設定（可選）
│   └── config.toml
│
├── .ai/                             # === 角色範疇：身份 / 知識 / 介面 / 記憶 ===
│   │
│   ├── identity.yaml                # 角色身份定義
│   ├── principles.md                # 決策原則與判斷框架
│   │
│   ├── knowledge/                   # 輕量核心知識
│   │   ├── standards/               # 規範、慣例、編碼風格
│   │   ├── glossary.yaml            # 術語表
│   │   └── heuristics.md            # 經驗法則速查
│   │
│   ├── interfaces/                  # 跨 Repo 介面定義
│   │   ├── exports.yaml             # 對外提供的能力
│   │   ├── imports.yaml             # 依賴的外部能力
│   │   └── injections/              # 注入其他 Repo 的精簡版技能
│   │       └── <target>-lite.md
│   │
│   └── memory/                      # 演進紀錄
│       ├── decisions.md             # 重要決策日誌
│       ├── lessons.md               # 經驗教訓
│       └── evolution.md             # 角色能力演進軌跡
│
├── context/                         # === 大量上下文（放 repo root）===
│   ├── domain/                      # 領域知識文件（可能很大）
│   ├── references/                  # 參考文件、外部資料
│   ├── examples/                    # 大量範例或案例庫
│   └── data/                        # 資料樣本、Schema 定義等
│
├── templates/                       # 產出物模板
├── tools/                           # 輔助腳本
└── docs/                            # 文件產出區
```

### 三層分離的設計邏輯

```
┌──────────────────────────────────────────────────────────┐
│  .github/          「能做什麼」— 技能、提示、代理人定義     │
│  (skills,           行動導向，直接驅動 Agent 工作          │
│   prompts,          為什麼放 .github？因為 Copilot 原生    │
│   agents)           讀取此目錄，且 skills 需要版控追蹤      │
├──────────────────────────────────────────────────────────┤
│  .ai/              「是什麼人」— 身份、原則、核心知識、記憶  │
│  (identity,         角色範疇，定義判斷力的邊界               │
│   principles,       輕量、穩定、跨專案可複用                │
│   knowledge,        knowledge/ = 精煉後的核心知識           │
│   interfaces,       （規範、術語、經驗法則）                 │
│   memory)                                                 │
├──────────────────────────────────────────────────────────┤
│  context/          「知道什麼」— 大量外部上下文              │
│  (domain,           資料導向，可能很龐大                    │
│   references,       放 root 是因為多個 Agent 都需要         │
│   examples,         直接存取，且可能被 .gitignore 部分排除   │
│   data)                                                   │
└──────────────────────────────────────────────────────────┘
```

**概念區分：**
- `knowledge/`（在 .ai/ 內）= 精煉後的核心知識，像是「這個角色腦中的精華筆記」
- `context/`（在 root）= 大量原始上下文，像是「這個角色桌上的參考書堆」

---

## 三、AGENTS.md 核心本體內容結構

```markdown
# AGENTS.md — [角色名稱] Expert Agent

> 本文件是所有 Coding Agent 的核心指令源。
> Claude Code、Codex CLI 原生讀取；Copilot、Gemini CLI 透過橋接讀取。

## 角色身份
見 `.ai/identity.yaml` — 定義了這個角色的視角、語氣、能力邊界。

## 決策原則
見 `.ai/principles.md` — 編碼了這個角色的判斷框架與經驗法則。

## Repo 目錄導覽

| 目錄 | 用途 | 何時讀取 |
|------|------|---------|
| `.github/skills/` | 技能定義（SKILL.md） | 執行特定任務時 |
| `.github/prompts/` | 可複用 Prompt 模板 | 需要標準化產出時 |
| `.github/agents/` | Agent 定義與精簡版角色 | 需要特定角色協助時 |
| `.ai/knowledge/` | 核心知識（規範、術語） | 所有產出都需遵守 |
| `.ai/interfaces/` | 跨 Repo 介面 | 跨角色協作時 |
| `.ai/memory/` | 決策日誌與經驗 | 遇到類似情境時參考 |
| `context/` | 大量領域上下文 | 需要深度背景資訊時 |

## 工作規範

### 所有 Agent 共同遵守
1. 產出標註來源：任何重要產出都標記 `[Agent: <agent-name>]`
2. 決策留痕：重大決定記錄到 `.ai/memory/decisions.md`
3. 不確定就問：寧可詢問人類，不要猜測
4. 遵守規範：`.ai/knowledge/standards/` 下的規範是底線
5. 技能優先：執行任務前先檢查 `.github/skills/` 有無對應技能

### 技能觸發規則
執行任務時，先查看 `.github/skills/_index.yaml` 確認是否有匹配的技能。
如有，載入對應的 `SKILL.md` 並遵循其指令。
如無，依據 `.ai/principles.md` 中的決策框架自行判斷。

### 跨 Repo 協作
需要其他角色支援時：
1. 查看 `.ai/interfaces/imports.yaml` 了解可用的外部能力
2. 讀取對應 Expert Repo 的 exports 了解介面規格
3. 如果該角色有注入本 Repo 的 lite 版，優先使用 `.github/agents/` 下的定義

## Agent 特定補充

### Claude Code
- 支援 Project Knowledge，可將 `.ai/` 和 `context/` 加入 Project
- 適合：深度分析、長文撰寫、複雜重構、多檔案編輯

### Codex CLI
- 原生讀取本文件，支援 Skills 發現（.codex/skills/）
- 適合：快速任務、非互動式批次處理、CI/CD 整合
- 專案設定：`.codex/config.toml`

### GitHub Copilot
- 讀取 `.github/copilot-instructions.md`（本文件摘要版）
- 技能位於 `.github/skills/`（可被 Copilot Chat 引用）
- 適合：行內補全、快速修改、即時程式碼生成

### Gemini CLI
- 透過 `GEMINI.md` 的 `@./AGENTS.md` 載入本文件
- 支援子目錄 GEMINI.md 發現（自動掃描）
- 適合：快速查詢、跨檔案搜尋、程式碼解釋、Google Search 整合
```

---

## 四、核心抽象定義

### 4.1 identity.yaml — 角色身份卡

```yaml
# .ai/identity.yaml
schema_version: "1.0"
type: expert | project           # Repo 類型

role:
  name: "架構師"                  # 角色名稱
  alias: "architect"              # 英文代號（跨 Repo 引用用）
  icon: "🏗️"                     # 視覺識別
  one_liner: "確保系統在技術上可行、可擴展、可維護"

identity:
  perspective: |                  # 用什麼視角看世界
    我從系統整體的角度思考每一個決策。
    我關注的是：這個選擇在 6 個月後會帶來什麼後果？
  tone: "精確、直接、偶爾使用類比讓抽象概念具體化"
  communication_style: "先給結論，再展開推理鏈"

capabilities:
  primary:                        # 核心能力
    - "系統架構設計與評審"
    - "技術選型與 Trade-off 分析"
    - "跨團隊技術方案協調"
  secondary:                      # 輔助能力
    - "Code Review（架構面）"
    - "效能分析與瓶頸定位"

boundaries:
  owns:                           # 擁有決策權
    - "系統架構決策"
    - "技術標準制定"
  advises:                        # 建議但不決定
    - "功能需求優先順序"
    - "UI/UX 設計方向"
  defers_to:                      # 尊重誰的決定
    - role: "pm"
      on: "需求範圍與優先順序"
    - role: "domain-expert"
      on: "業務邏輯正確性"

quality_criteria:                 # 產出品質標準
  - "方案是否考慮了未來 6 個月的擴展性？"
  - "是否有明確的 Trade-off 說明？"
  - "是否與現有系統一致？"

anti_patterns:                    # 容易犯的錯
  - "過度設計（Over-engineering）"
  - "忽略實作團隊的能力現況"
  - "只給方向不給可執行的下一步"
```

### 4.2 principles.md — 決策原則

```markdown
# 決策原則

## 核心信念
1. **可逆性決定速度**：可逆的決定快速做，不可逆的決定慎重做
2. **約束即自由**：明確的約束減少決策疲勞
3. ...

## 決策框架
當面臨 [某類情境] 時，我優先考慮：
1. [第一優先]
2. [第二優先]
3. [可犧牲項]

## 經驗法則（Heuristics）
- 如果一個服務超過 X 行，考慮拆分
- 如果一個 API 超過 Y 個參數，考慮重新設計
- ...
```

### 4.3 skills/_index.yaml — 技能清單

```yaml
# .github/skills/_index.yaml
skills:
  - name: "架構審查"
    alias: "arch-review"
    trigger: "當收到新功能需求或技術方案時"
    description: "從擴展性、一致性、維護成本三個角度審查技術方案"
    mode: interactive          # interactive | autonomous | hybrid
    estimated_effort: medium   # low | medium | high

  - name: "技術選型分析"
    alias: "tech-selection"
    trigger: "當需要選擇新技術、框架或工具時"
    description: "產出結構化的 Trade-off 分析報告"
    mode: interactive
    estimated_effort: high

  - name: "ADR 撰寫"
    alias: "adr-write"
    trigger: "當重大技術決策確定後"
    description: "撰寫 Architecture Decision Record"
    mode: autonomous
    estimated_effort: low
```

### 4.4 interfaces/ — 跨 Repo 介面

```yaml
# .ai/interfaces/exports.yaml
exports:
  skills:
    - alias: "arch-review"
      lite_version: "injections/arch-review-lite.md"
      description: "精簡版架構審查，適合注入專案 Repo"
    - alias: "adr-write"
      lite_version: "injections/adr-lite.md"

  knowledge:
    - type: "standards"
      path: "knowledge/standards/api-design-guide.md"
      description: "API 設計規範，可被專案直接引用"
    - type: "checklist"
      path: "skills/arch-review/checklist.md"

  prompts:
    - alias: "quick-arch-check"
      path: "prompts/quick-arch-check.md"
      description: "5 分鐘快速架構健康檢查"
```

```yaml
# .ai/interfaces/imports.yaml
imports:
  - from: "pm"
    needs:
      - "需求文件模板（PRD）"
      - "優先順序框架"
    reason: "架構決策需要理解業務優先順序"

  - from: "devops"
    needs:
      - "部署架構現況"
      - "基礎設施約束條件"
    reason: "架構設計需要符合部署環境限制"
```

---

## 五、Expert Repo vs Project Repo

| 維度 | Expert Repo | Project Repo |
|------|-------------|--------------|
| **核心目的** | 持續精進某角色的判斷力 | 讓專案成功交付 |
| **identity.type** | `expert` | `project` |
| **Skills 深度** | 深且廣，持續迭代 | 精簡版 + 專案特有少量技能 |
| **knowledge/ 範圍** | 跨專案的精煉知識 | 專案特定的精煉知識 |
| **context/ 範圍** | 該角色的領域參考資料 | 專案需求、設計、架構等大量文件 |
| **Memory 重點** | 跨專案的經驗累積 | 專案決策紀錄 |
| **演進頻率** | 高（每週迭代） | 低（里程碑驅動） |

### Project Repo 的特殊結構

```
project-vms/
│
├── AGENTS.md                        # 專案核心指令
├── CLAUDE.md                        # 橋接
├── GEMINI.md                        # 橋接
│
├── .github/
│   ├── copilot-instructions.md
│   ├── skills/                      # 專案專屬技能（少量）
│   ├── prompts/                     # 專案專屬 Prompt
│   └── agents/                      # ← 注入的角色小助手
│       ├── architect-lite.md        # 來自架構師 Expert Repo
│       ├── qa-lite.md               # 來自 QA Expert Repo
│       └── pm-lite.md               # 來自 PM Expert Repo
│
├── .ai/
│   ├── identity.yaml                # type: project
│   ├── principles.md                # 專案層級的決策原則
│   ├── knowledge/
│   │   └── project-brief.md         # 專案概述（所有 Agent 的共同上下文）
│   ├── interfaces/
│   │   └── imports.yaml             # 依賴哪些 Expert
│   └── memory/
│       ├── decisions.md
│       ├── sprint-log.md
│       └── tech-debt.md
│
├── context/                         # 大量專案上下文
│   ├── requirements/                # 需求文件
│   ├── design/                      # 設計文件
│   ├── architecture/                # 架構文件
│   └── domain/                      # 專案領域知識
│
├── src/
├── tests/
└── docs/
```

---

## 六、跨 Repo 協作模式

### 模式 A：Expert → Project 注入

```
architect-expert/.ai/interfaces/injections/arch-review-lite.md
    ↓ 複製到
project-vms/.github/agents/architect-lite.md
```

**arch-review-lite.md 範例：**
```markdown
# 架構師小助手（Lite）

你是專案內建的架構顧問。完整知識庫在 architect-expert repo，
在這個專案中，你專注於：

## 快速架構檢查清單
任何結構性變更前，確認：
1. 是否符合本專案的 ADR 決策？（見 context/architecture/adr/）
2. 是否符合 API 設計規範？（見 .ai/knowledge/standards/）
3. 是否考慮了資料管線的上下游影響？
4. 是否需要升級為完整版架構師審查？

## 升級條件
遇到以下情況，建議啟動完整版架構師：
- 涉及新的外部服務整合
- 資料模型結構性變更
- 效能相關的架構調整
```

### 模式 B：Expert 互相諮詢

```
PM 的 PRD 完成
  → 架構師讀取 PM Repo 的 context/ 了解需求
  → 用 .github/skills/arch-review/ 產出技術可行性
  → 結果回饋給 PM Repo 和 Project Repo
```

### 模式 C：Project 主動拉取

在 Project 的 AGENTS.md 中定義：
```markdown
## 可用的專家資源
需要深度支援時，參考以下 Expert Repo：
- 架構：../architect-expert/.github/skills/
- 測試：../qa-expert/.github/skills/
- 部署：../devops-expert/.github/skills/
```

---

## 七、各角色 Expert Repo 建議初始 Skills

### 🏗️ 架構師（Architect）
| Skill | 觸發 | 產出 |
|-------|------|------|
| arch-review | 新功能需求 / 技術方案 | 結構化審查報告 + 風險清單 |
| tech-selection | 選擇新技術 / 框架 | Trade-off 矩陣 |
| adr-write | 重大技術決策確定 | Architecture Decision Record |
| system-design | 新系統 / 子系統設計 | 架構圖 + 元件說明 + 介面定義 |
| debt-assessment | 定期或重構前 | 技術債評估 + 優先順序 |

### 📋 PM（Product Manager）
| Skill | 觸發 | 產出 |
|-------|------|------|
| prd-write | 新功能啟動 | Product Requirements Document |
| story-breakdown | PRD 完成後 | User Stories + Acceptance Criteria |
| priority-analysis | 需求衝突 / 資源有限 | 優先順序矩陣 + 建議 |
| stakeholder-brief | 里程碑 / 重要更新 | Stakeholder 溝通摘要 |
| risk-assessment | Sprint 規劃 / 專案啟動 | 風險矩陣 + 緩解策略 |

### 🎨 設計師（Designer）
| Skill | 觸發 | 產出 |
|-------|------|------|
| ux-review | 新功能設計 / 改版 | 可用性分析 + 改善建議 |
| component-spec | 新 UI 元件設計 | 元件規格書 + 狀態定義 |
| flow-design | 使用者流程設計 | 流程圖 + 邊界案例清單 |
| design-system-check | 實作驗收 | 與設計系統一致性報告 |

### 🧪 QA / 程式驗測
| Skill | 觸發 | 產出 |
|-------|------|------|
| test-strategy | 新功能開發前 | 測試策略文件 |
| test-case-gen | User Story 完成 | 測試案例（含邊界條件） |
| bug-analysis | 缺陷回報 | 根因分析 + 重現步驟 + 修復建議 |
| regression-check | 版本發布前 | 回歸測試清單 + 風險評估 |
| data-validation | 資料管線變更 | 資料品質驗證規則 + SQL 腳本 |

### ⚙️ 維運（DevOps / SRE）
| Skill | 觸發 | 產出 |
|-------|------|------|
| deploy-review | 部署計畫提交 | 風險評估 + Rollback 計畫 |
| incident-response | 線上事故 | 事故處理 SOP + 根因模板 |
| infra-design | 新服務上線 | 基礎設施設計 + 成本估算 |
| monitor-setup | 服務部署後 | 監控告警規則 + Dashboard |
| pipeline-optimize | 效能或成本問題 | 管線優化建議 + 實施計畫 |

### 🔬 領域專家（Domain Expert）
| Skill | 觸發 | 產出 |
|-------|------|------|
| domain-review | 功能設計 / 需求確認 | 業務邏輯正確性審查 |
| term-definition | 新概念 / 術語出現 | 術語定義 + 上下文說明 |
| scenario-gen | 測試 / 需求分析 | 業務場景清單（含邊界） |
| knowledge-codify | 隱性知識文件化 | 結構化知識文件 |
| regulation-check | 涉及法規合規 | 合規檢查報告 |

---

## 八、Skill 演進機制

### 迭代流程
```
實際使用 → 發現不足 → 更新 SKILL.md → 記錄 changelog.md →
同步更新 lite 版本 → 通知相關 Project Repo
```

### changelog.md 格式
```markdown
# Changelog — arch-review

## v1.2 (2026-03-01)
- 新增：Delta Lake schema evolution 的專項檢查
- 改善：Trade-off 分析模板增加「成本影響」維度
- 修正：API 設計規範遺漏的 pagination 標準

## v1.1 (2026-02-15)
- 新增：Unity Catalog 權限模型一致性檢查
- 改善：產出格式加入 Mermaid 架構圖
```

---

## 九、Bootstrap Prompt — 角色 Repo 起始器

以下 Prompt 用於與任意 Coding Agent 對話，快速起始一個新的角色 Repo：

````markdown
# Role Repo Bootstrap Prompt

你是一個「角色 Repo 架構師」，負責幫我建立 AI Agent 角色的知識庫 Repo。

## 背景
我的團隊混用多種 Coding Agent（Claude Code, GitHub Copilot, Codex CLI, Gemini CLI）。
我們的 Repo 架構有以下規則：

### 橋接架構
- `AGENTS.md`：核心本體（Codex CLI 原生讀取）
- `CLAUDE.md`：指向 AGENTS.md
- `GEMINI.md`：用 `@./AGENTS.md` import
- `.github/copilot-instructions.md`：AGENTS.md 的精簡摘要

### 目錄配置
- `.github/`：放 skills/、prompts/、agents/（行動導向）
- `.ai/`：放 identity.yaml、principles.md、knowledge/、interfaces/、memory/（角色範疇）
- `context/`：放 repo root（大量上下文資料）

### 概念區分
- `.ai/knowledge/` = 精煉後的核心知識（腦中精華）
- `context/` = 大量原始上下文（桌上的參考書堆）

## 需要建立的角色
- **角色名稱**：[填入]
- **Repo 類型**：Expert / Project
- **核心職責**：[填入]
- **團隊背景**：6 人開發團隊，技術棧 Databricks / PySpark / Delta Lake / AWS / MongoDB
  負責 VMS 車輛管理與 SmartSignage 零售媒體系統
- **與其他角色的關係**：[填入]

## 產出要求

### 1. 完整目錄結構
含所有檔案路徑

### 2. AGENTS.md
完整的核心指令文件

### 3. 橋接檔
CLAUDE.md、GEMINI.md、.github/copilot-instructions.md

### 4. .ai/identity.yaml
完整角色身份卡（role, identity, capabilities, boundaries, quality_criteria, anti_patterns）

### 5. .ai/principles.md
3-5 條核心信念、2-3 個決策框架、5-10 條經驗法則

### 6. 初始 Skills（3-5 個）
每個含 SKILL.md + examples/ + checklist.md，放在 .github/skills/

### 7. .ai/interfaces/
exports.yaml + imports.yaml + 至少 1 個 injection lite 版

### 8. .ai/knowledge/
至少含 standards/ 下一份規範和 glossary.yaml

## 品質標準
- Prompt 和 Skill 要具體、可操作，避免空泛
- 要反映角色的「判斷力」而非僅是「執行步驟」
- 要考慮與其他角色的互動介面
- 技能設計為「可持續迭代」的，有 changelog
````

---

## 十、快速啟動清單

建立新角色 Repo 的步驟：

1. **[ ] 建立目錄結構** — 按本文件第二節
2. **[ ] 填寫 `.ai/identity.yaml`** — 定義角色靈魂
3. **[ ] 撰寫 `.ai/principles.md`** — 編碼判斷力
4. **[ ] 建立 AGENTS.md** — 寫核心指令
5. **[ ] 建立 3 個橋接檔** — CLAUDE.md / GEMINI.md / copilot-instructions.md
6. **[ ] 建立 3 個初始 Skills** — 放 `.github/skills/`
7. **[ ] 定義 `.ai/interfaces/`** — 明確輸入輸出
8. **[ ] 建立 `.ai/knowledge/`** — 至少一份規範 + 術語表
9. **[ ] 建立至少 1 個 injection** — 讓知識流向 Project
10. **[ ] 跑一次真實任務驗證** — 用真實場景測 Skill
11. **[ ] 記錄 `.ai/memory/decisions.md`** — 記下為什麼這樣設計