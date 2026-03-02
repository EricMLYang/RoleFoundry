---
name: interface-wiring
description: Establish or update collaboration interfaces between two repos. Use when user says "幫我把 [Expert Repo] 的 [skill-name] 注入到 [Project Repo]", "建立 [角色 A] 和 [角色 B] 之間的介面", or "更新 [Repo] 的 imports.yaml".
---

# Skill: interface-wiring — 跨 Repo 介面配線

## 用途(Purpose)

在兩個 Repo 之間建立或更新協作介面,確保 exports/imports 對齊,並產生或更新 injection lite 版。

- **輸入**:來源 Expert Repo 路徑 + 目標 Repo 路徑(或描述)
- **輸出**:更新後的 exports/imports 定義 + lite 版注入檔

## 何時使用（When to Use）

- 「幫我把 [Expert Repo] 的 [skill-name] 注入到 [Project Repo]」
- 「建立 [角色 A] 和 [角色 B] 之間的介面」
- 「更新 [Repo] 的 imports.yaml」
- 「同步 foundry-lite 到我們的 Project Repo」

---

## 前置條件（Prerequisites）

- 來源 Expert Repo 的 `.ai/interfaces/exports.yaml` 已定義（有內容可輸出）
- 目標 Repo 存在（可以是 Project Repo 或另一個 Expert Repo）

---

## 流程（Process）

### Step 1: 掃描來源 Repo [autonomous]

讀取來源 Expert Repo 的：
- `.ai/interfaces/exports.yaml`：確認可提供的能力清單
- `.ai/interfaces/injections/`：確認是否已有現成的 lite 版

輸出：可用能力列表，供 Step 2 使用者選擇。

### Step 2: 比對目標 Repo 需求 [interactive]

讀取目標 Repo 的 `.ai/interfaces/imports.yaml`（如果存在）。

詢問使用者：「你需要來源 Repo 的哪些能力？」（列出 Step 1 的可用選項）

確認：
- 要注入哪些 Skills？
- 要引用哪些 Knowledge？
- 要使用哪些 Prompts？

### Step 3: 產生或更新 lite 版 [autonomous]

**如果來源 Repo 有現成 lite 版**：
複製 `source/.ai/interfaces/injections/[source]-lite.md` 到目標 Repo 的 `.github/agents/[source]-lite.md`。

**如果沒有現成 lite 版**：
基於 exports.yaml 中選定的 skills，產生新的 lite 版，規則：
- 總長度 ≤ 50 行
- 包含快速檢查清單（3-5 項，從 SKILL.md 的品質標準中萃取）
- 包含「升級條件」段落（什麼情況需要啟動完整版）
- 開頭標明來源（「來自 [source-alias] Expert Repo」）

### Step 4: 更新目標 Repo 的 imports.yaml [autonomous]

在目標 Repo 的 `.ai/interfaces/imports.yaml` 中，加入或更新來源 Repo 的依賴記錄：

```yaml
- from: "[source-alias]"
  needs:
    - "[引用的能力描述]"
  reason: "[為什麼需要這個依賴]"
  injection_path: ".github/agents/[source]-lite.md"
```

### Step 5: 一致性驗證 [autonomous]

確認以下項目：
- [ ] 目標 Repo 的 imports.yaml 中的每個依賴，.github/agents/ 下都有對應的 lite 版？
- [ ] lite 版的長度 ≤ 50 行？
- [ ] lite 版有「升級條件」段落？
- [ ] imports.yaml 每條依賴都有 reason 欄位？

輸出驗證結果，如有問題提供具體修復建議。

---

## 品質標準（Quality Gates）

- Lite 版必須在 50 行以內
- imports.yaml 的每條依賴必須有 reason 欄位
- Lite 版必須有「升級條件」段落
- 目標 Repo 的 .github/agents/ 目錄必須有對應的 lite 檔案

---

## 已知限制（Limitations）

- 無法自動判斷「什麼時候應該使用完整版而非 lite 版」——升級條件需要使用者提供輸入
- Lite 版是手動同步的；如果來源 Repo 的 Skill 更新，需要重新執行本技能（或使用 sync-injection.sh）
