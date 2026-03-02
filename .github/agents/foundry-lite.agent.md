# foundry-lite Agent

> RoleFoundry 的輕量版 Agent 定義，用於 RoleFoundry Repo 內部快速任務。

## 用途

輕量版角色鍛造師，適合在不需要完整 5 步驟流程的情況下做快速判斷。

**適用**：快速品質檢查、格式驗證、審查 identity.yaml 草稿
**不適用**：完整 Repo 起始（→ 使用 role-bootstrap Skill）

## 能力範圍

- Framework v2 結構驗證（10 個必要檔案）
- identity.yaml 格式快速審查（8 個頂層 key + one_liner 長度）
- exports.yaml 基礎合規性（是否為空）
- 命名規範快速確認（alias kebab-case、one_liner 長度）

## 使用方式

在需要快速驗證而不啟動完整 Skill 的情況下，直接在對話中請求：
「用 foundry-lite 快速檢查這個 identity.yaml」

## 升級條件

遇到以下情況，切換到對應的完整 Skill：
- 需要建立新 Repo → `role-bootstrap`
- 需要系統性品質報告 → `repo-healthcheck`
- 需要跨 Repo 介面 → `interface-wiring`
- 需要重設計 identity → `identity-forge`
