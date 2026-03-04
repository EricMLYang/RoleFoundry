# Changelog — role-bootstrap

## v1.1 (2026-03-04)

- 新增 `repo-seed/` 複製規則：若 archetype 提供流程骨架，bootstrap 時一併帶入
- 技能數量驗收改為依 archetype 類型判斷（一般 3-5；流程型 6-8）

## v1.0 (2026-03-02)

**初始版本**

- 5 步驟流程：訪談 → 規劃 → 產生 → 審查 → 摘要
- 訪談階段整合 `.github/prompts/role-interview.prompt.md`（6 題結構化問題）
- 產生階段按依賴順序建立 9 類核心檔案
- Step 4 內建品質審查（不需要另外啟動 repo-healthcheck）
- 支援 Expert Repo 和 Project Repo 兩種類型
