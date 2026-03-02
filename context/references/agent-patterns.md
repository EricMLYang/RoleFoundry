# Agent 設計模式參考

> 在 Agent Role Repo Framework v2 中常用的多 Agent 協作模式。

---

## 模式 A：Expert → Project 注入（最常用）

**情境**：Project Repo 需要某個 Expert 角色的能力，但不想每次都打開完整的 Expert Repo。

**做法**：
1. Expert Repo 在 `.ai/interfaces/injections/` 維護一個 lite 版
2. 使用 `interface-wiring` Skill 將 lite 版注入到 Project Repo 的 `.github/agents/`
3. Project Repo 的 AGENTS.md 中引用這個 lite 版

**範例**：
```
role-foundry/.ai/interfaces/injections/foundry-lite.md
    ↓ interface-wiring
project-vms/.github/agents/foundry-lite.agent.md
```

**適用**：Expert 的部分能力（快速檢查清單）在 Project 中頻繁使用

---

## 模式 B：Expert 互相諮詢

**情境**：兩個 Expert 角色需要協作，例如架構師需要 PM 的需求背景。

**做法**：
1. 一個 Agent 主動讀取另一個 Repo 的 context/
2. 在當前 Repo 的 imports.yaml 中記錄依賴關係
3. 不需要注入 lite 版（Expert 之間直接對話）

**範例**：
```
architect-expert 讀取 pm-expert 的 context/
  → 了解業務需求背景
  → 產出技術可行性報告
  → 結果更新到 project-vms 的 context/
```

---

## 模式 C：Project 主動拉取

**情境**：Project 需要在特定任務時調用 Expert 的完整能力。

**做法**：在 Project AGENTS.md 中列出可用 Expert 的路徑：
```markdown
## 可用的專家資源
需要深度支援時，參考以下 Expert Repo：
- 角色鍛造：../role-foundry/.github/skills/
- 架構設計：../architect-expert/.github/skills/
```

---

## Skill 執行模式選擇指南

| 情境 | 建議模式 | 理由 |
|------|---------|------|
| 需要蒐集使用者資訊才能開始 | interactive | 缺少輸入無法進行 |
| 有明確輸入，可自主完成 | autonomous | 減少使用者負擔 |
| 某些步驟需要確認，某些不需要 | hybrid | 平衡效率和準確性 |
| 批次處理或 CI/CD | autonomous | 無互動環境 |

---

## 上下文視窗管理策略

**問題**：角色 Repo 的內容可能超過 Agent 的上下文視窗限制。

**策略**：
1. **AGENTS.md 瘦身**：AGENTS.md 用 `see:` 引用，不嵌入大量內容（目標 < 32KB）
2. **按需載入**：context/ 下的文件按需載入，不是一次全讀
3. **knowledge vs context 分層**：.ai/knowledge/ 放精煉知識（需常駐）；context/ 放原始資料（需要時才讀）
4. **lite 版控制大小**：injection lite 版嚴格限制 ≤ 50 行
