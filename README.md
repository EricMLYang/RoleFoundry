# RoleFoundry — 角色 Repo 鍛造工坊 🔨

> 快速鍛造高品質角色 Repo

---

## 是什麼

RoleFoundry 是一個 **Expert Repo**，封裝了「角色 Repo 架構師」的知識與技能。

它解決一個常見問題：建立一個新的 AI Agent 角色 Repo 需要撰寫 20+ 個結構化檔案，過程繁瑣、容易遺漏關鍵設計，且團隊成員對框架的理解程度不一，導致各 Repo 品質參差不齊。

RoleFoundry 透過結構化的 Skills，引導使用者在 30 分鐘內完成從角色定義到初始驗證的全流程，並確保產出符合 **Agent Role Repo Framework v2** 規範。

**特別之處**：RoleFoundry 本身就是 Framework v2 的示範實作——它既是工具，也是活的參考範例。

---

## 快速開始

**Step 1：在你的 Coding Agent 中開啟本 Repo**

```
# Claude Code
claude --project /path/to/role-foundry

# Codex CLI
# 直接在 role-foundry 目錄執行，AGENTS.md 自動載入

# Gemini CLI
gemini  # GEMINI.md 會自動展開 AGENTS.md
```

**Step 2：請 Agent 開始鍛造**

```
幫我鍛造一個全新的角色 Repo
```
或更具體：
```
幫我建立一個「架構師」Expert Repo，用於 6 人開發團隊，主要負責技術選型和架構審查
```

**Step 3：回答訪談問題，確認產出**

Agent 會透過 `role-bootstrap` Skill 引導你完成 6 個步驟：
0. 目錄瀏覽（選擇原型與路徑）
1. 角色訪談（收集必要資訊）
2. 結構規劃（確認目錄設計）
3. 核心檔案產生（自動產出所有檔案）
4. 品質審查（自動檢查品質）
5. 產出摘要（告知後續步驟）

---

## Repo 地圖

```
.github/skills/     技能定義（5 個核心技能）
.github/prompts/    可複用的 Prompt 模板
.ai/                角色身份、原則、知識、介面、記憶
catalog/            可直接複製的鍛造素材（角色原型 + 預設技能）
context/            Framework v2 完整規範、參考資料
tools/              輔助腳本（scaffold.sh/.ps1, validate-repo.sh/.ps1, sync-injection.sh/.ps1）
docs/               快速上手指南、常見問題
```

---

## 五個核心技能

| 技能 | 用途 |
|------|------|
| `role-bootstrap` | 完整角色 Repo 起始（旗艦技能）|
| `identity-forge` | 單獨設計或優化角色身份 |
| `skill-author` | 為既有 Repo 新增技能 |
| `repo-healthcheck` | 掃描 Repo 品質，產出健康報告 |
| `interface-wiring` | 建立跨 Repo 協作介面 |

---

## 適用對象

- **需要快速起始新角色 Repo 的開發團隊**
- **想確保 Repo 符合 Framework v2 規範的架構師**
- **需要在多個 Repo 間建立協作介面的 AI 平台工程師**

---

## 進一步了解

- **快速上手**：[docs/getting-started.md](docs/getting-started.md)
- **常見問題**：[docs/faq.md](docs/faq.md)
- **框架規範**：[context/framework/agent-role-repo-framework-v2.md](context/framework/agent-role-repo-framework-v2.md)
- **角色原型**：[catalog/archetypes/](catalog/archetypes/)
- **完整指令**：[AGENTS.md](AGENTS.md)（Coding Agent 入口）
