# 快速上手指南

> 從零到建立第一個角色 Repo，預計 30 分鐘完成。

---

## 什麼是 RoleFoundry？

RoleFoundry 協助你快速建立符合 Agent Role Repo Framework v2 規範的角色 Repo。
每個角色 Repo 封裝了一個角色的身份、判斷力和技能，讓 Coding Agent 能以這個角色的視角工作。

---

## 前置條件

- 安裝了至少一個 Coding Agent（Claude Code、Copilot、Codex CLI 或 Gemini CLI）
- 有 Git（可以 clone/commit）

---

## Step 1：開啟 RoleFoundry

**Claude Code**：

在 RoleFoundry 目錄中開啟 Claude Code，CLAUDE.md 會自動載入指向 AGENTS.md 的橋接。

**GitHub Copilot Chat**：

```
請讀取這個 Repo 的 AGENTS.md，然後告訴我你是誰以及你能做什麼。
```

**Codex CLI**：

在 RoleFoundry 目錄中執行，AGENTS.md 會自動載入。

**Gemini CLI**：

GEMINI.md 中的 `@./AGENTS.md` 會自動展開完整指令。

---

## Step 2：請 Agent 建立新角色 Repo

複製以下提示語，貼上給你的 Coding Agent：

```
幫我鍛造一個全新的角色 Repo。
角色：[你的角色名稱，例如：架構師]
類型：Expert Repo（跨專案複用）
核心職責：[一句話描述，例如：負責技術選型和架構審查]
```

Agent 會自動觸發 **role-bootstrap** Skill，開始引導流程。

---

## Step 3：回答訪談問題

Agent 會問你 6 個問題（`role-interview.prompt.md` 的結構化訪談）：

1. **角色基本資料**：名稱、英文代號、Expert 或 Project 類型
2. **一句話定位**：這個角色存在的原因
3. **能力邊界**：owns（決策權）/ advises（只給建議）/ defers_to（尊重誰的決定）
4. **視角與風格**：用比喻描述思考方式
5. **初始技能**：最常被叫去做的 3-5 件事
6. **反模式**：表現不佳時最容易犯什麼錯

用對話方式回答即可，不需要正式格式。

---

## Step 4：確認目錄結構

Agent 產出「角色訪談摘要」後，會提出目錄結構規劃，等你確認。

確認後，Agent 自動產生所有檔案（9 類）：
1. `.ai/identity.yaml`
2. `.ai/principles.md`
3. `AGENTS.md`
4. 三個橋接檔
5. `.github/skills/_index.yaml`
6. 每個初始 Skill 的目錄
7. `.ai/interfaces/exports.yaml` + `imports.yaml`
8. `.ai/knowledge/glossary.yaml`
9. `.ai/memory/decisions.md`

---

## Step 5：驗收品質

Agent 完成後會自動做品質審查（role-bootstrap 的 Step 4）。

你也可以另外跑完整健康檢查：

```
幫我檢查這個新建 Repo 的健康狀況
```

Agent 會執行 **repo-healthcheck** Skill，產出 5 維度評分報告。

---

## 後續：迭代 Repo

### 加入新技能

```
幫我為 [角色名] 新增一個 [技能描述] 的 Skill
```

Agent 觸發 **skill-author** Skill，引導你完成。

### 優化角色身份

```
我覺得 [角色名] 的 identity.yaml 太空泛，幫我重新設計
```

Agent 觸發 **identity-forge** Skill。

### 連接到 Project Repo

```
幫我把 [Expert Repo 名] 注入到 [Project Repo 名]
```

Agent 觸發 **interface-wiring** Skill。

---

## 驗證工具

### 快速結構驗證（CI 友好）

```bash
./tools/validate-repo.sh /path/to/your-new-repo
```

exit 0 = 10 個必要檔案全部存在；exit 1 = 有缺失。

### 建立空骨架（補救用）

```bash
./tools/scaffold.sh /path/to/new-repo
```

---

## 角色原型參考

- [PM 原型](../context/archetypes/pm/) — 產品經理預設值與引導問題
- [架構師原型](../context/archetypes/architect/) — 系統架構師預設值與引導問題
- [領域專家原型](../context/archetypes/domain-expert/) — 領域專家預設值與引導問題
- [考試輔助師原型](../context/archetypes/exam-tutor/) — 考試輔助師預設值與引導問題
