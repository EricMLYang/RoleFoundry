# RoleFoundry 演進記錄

> 記錄 RoleFoundry 自身能力的演進軌跡。

---

## Phase 0 完成（2026-03-02）— M0: Self-hosted

**建立的核心檔案**：
- `.ai/identity.yaml`（角色鍛造師身份定義）
- `.ai/principles.md`（5 個核心信念 + 3 個決策框架）
- `AGENTS.md`（所有 Agent 的核心指令源）
- `CLAUDE.md`、`GEMINI.md`、`.github/copilot-instructions.md`（三個橋接檔）
- `.ai/knowledge/glossary.yaml`（24 個核心術語）
- `README.md`（人類入口）

**驗收狀態**：M0 基礎架構就緒

---

## Phase 1 完成（2026-03-02）— M1: First Forge

**新增的核心技能**：
- `role-bootstrap`（旗艦技能：5 步驟完整 Repo 起始）
- `identity-forge`（角色身份設計：4 步驟）
- `skill-author`（技能撰寫：6 步驟）

**新增的支援檔案**：
- `.github/skills/_index.yaml`（技能目錄）
- `.github/prompts/`（3 個 Prompt 模板）
- `templates/`（9 個 .tmpl 模板，已於 2026-03-04 移除）
- `context/framework/agent-role-repo-framework-v2.md`（Framework v2 完整規範）

**待完成**（Phase 1 尾段）：
- `role-bootstrap/examples/`（需要第一次真實鍛造後補充）

---

## Phase 2 完成（2026-03-02）— M2: Quality Gate

**新增的品質機制**：
- `repo-healthcheck` Skill（5 維度，autonomous 模式，三級判定）
- `tools/scaffold.sh`（冪等目錄骨架建立，附說明提示）
- `tools/validate-repo.sh`（CI 友好，exit 0/1）
- `.ai/knowledge/standards/` 三個規範文件
- `.ai/knowledge/heuristics.md`（角色設計快速判斷法則）

---

## Phase 3 完成（2026-03-02）— M3: Multi-Repo

**新增的介面配線能力**：
- `interface-wiring` Skill（5 步驟，含 lite 版產生）
- `.ai/interfaces/exports.yaml`（定義 2 個 skills、2 個 knowledge、2 個 prompts）
- `.ai/interfaces/imports.yaml`（無依賴，含說明）
- `.ai/interfaces/injections/foundry-lite.md`（≤50 行，5 項快速檢查 + 升級條件）
- `.github/agents/foundry-lite.agent.md`（Agent 定義版）
- `tools/sync-injection.sh`（lite 版同步工具）
- `.github/agents/_index.yaml`、`.github/prompts/_index.yaml`

---

## Phase 4 完成（2026-03-02）— M4: Battle-tested

**新增的範例與文件**：
- `context/archetypes/`（取代原 context/examples/，含 pm/architect/domain-expert/exam-tutor 四個原型）
- `context/references/agent-patterns.md`
- `context/references/prompt-engineering.md`
- `docs/getting-started.md`（5 步驟快速上手 + 驗證工具）
- `docs/faq.md`（8 個常見問題）

**全部里程碑達成（M0-M4）**

---

## Round 4（2026-03-04）— catalog/ 重組 + role-bootstrap 快速路徑

**目錄重組**：
- 建立 `catalog/` 頂層目錄，語意為「可直接複製的鍛造素材」
- `context/archetypes/` → `catalog/archetypes/`（git mv）
- `context/default-skills/` → `catalog/default-skills/`（git mv）
- `context/` 恢復為純參考資料目錄（僅剩 framework/ 和 references/）

**role-bootstrap 流程改造**：
- 新增 Step 0（目錄瀏覽與路徑選擇），總步驟數從 5 變 6（0–5）
- 路徑 (a) 直接複製：最小輸入（名稱 + alias + 路徑），無訪談
- 路徑 (b) 微調：精簡訪談（僅 differentiation + principles 兩組）
- 路徑 (c) 完整訪談：原有流程不變

**路徑引用更新**：
- `catalog/archetypes/_index.yaml`：5 個 `path:` 欄位更新
- `catalog/default-skills/_defaults.yaml`：2 個 `source:` 欄位 + 注釋更新
- `.github/skills/role-add/SKILL.md`：2 處引用更新
- `.github/skills/role-bootstrap/SKILL.md`：6 處引用更新

**文件同步**：
- `AGENTS.md`、`README.md`、`copilot-instructions.md`、`docs/getting-started.md` 全部同步更新

---

## Round 5（2026-03-04）— 流程全修（健康檢查修正 + Windows 工具鏈）

**健康檢查修正**：
- `.ai/identity.yaml` 的 `one_liner` 精簡至 20 字以內
- `.github/skills/_index.yaml` 中過長 trigger 已縮短（`copilot-sync`、`catalog-update`）
- `repo-healthcheck` 的技能數量準則調整為「初始 3-5、成熟 6-10」

**一致性修正**：
- `.github/copilot-instructions.md` 補上 `collab-join` 技能
- `_collab/_registry.yaml` 新增 `role-foundry` 參與者條目
- `tools/scaffold.sh` 路徑由 `context/archetypes` 修正為 `catalog/archetypes` 參考語意

**跨平台工具補強**：
- 新增 `tools/validate-repo.ps1`
- 新增 `tools/scaffold.ps1`
- 新增 `tools/sync-injection.ps1`
- `AGENTS.md`、`README.md`、`docs/getting-started.md`、`docs/faq.md` 更新雙腳本用法
