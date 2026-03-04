---
name: rule-validate
description: Validate system implementation against business rules. Use when user says "這個實作符合業務規則嗎" or "幫我檢查這段邏輯對不對".
---

# Skill: rule-validate — 規則驗證

## 用途(Purpose)

當需要驗證系統實作是否正確反映業務規則時使用。

- **輸入**:系統實作(程式碼、流程、設定)+ 對應的業務規則
- **輸出**:驗證報告(一致/不一致項目 + 修正建議)

## 何時使用（When to Use）

- 「這個實作符合業務規則嗎？」
- 「幫我檢查這段邏輯對不對」

---

## 前置條件（Prerequisites）

- 有明確的業務規則文件
- 有待驗證的系統實作

---

## 流程（Process）

### Step 1: 規則盤點 [autonomous]

列出相關的業務規則清單，每條標註來源。

### Step 2: 逐條比對 [autonomous]

對每條規則：
1. Happy Path — 正常流程是否一致？
2. 邊界案例 — 邊界值處理是否正確？
3. 例外狀況 — 錯誤處理是否合理？
4. 術語一致 — 程式碼命名是否反映業務語意？

### Step 3: 報告與建議 [interactive]

產出驗證報告：
- 通過的規則（✅）
- 不一致的規則（❌）+ 具體描述
- 修正建議

---

## 品質標準（Quality Gates）

- 每條規則都有驗證結果
- 不一致項有具體描述（不只是「不對」）
- 有修正建議

---

## 已知限制（Limitations）

- 無法驗證程式碼的執行時行為（需要實際測試）
- 隱含的業務規則可能未被記錄
