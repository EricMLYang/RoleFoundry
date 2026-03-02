---
name: knowledge-capture
description: Structure domain knowledge from experts into knowledge base. Use when user says "把這條規則記下來" or "整理一下這個領域的知識".
---

# Skill: knowledge-capture — 知識擷取

## 用途(Purpose)

當需要將領域專家腦中的知識結構化記錄到知識庫時使用。

- **輸入**:非結構化的領域知識(口述、討論、文件片段)
- **輸出**:結構化的知識文件(含規則、案例、邊界條件)

## 何時使用（When to Use）

- 「把這條規則記下來」
- 「整理一下這個領域的知識」

---

## 前置條件（Prerequisites）

- 有領域專家可以諮詢或已有非結構化資料

---

## 流程（Process）

### Step 1: 知識訪談 [interactive]

引導萃取知識：
1. 這條知識的核心規則是什麼？
2. 有什麼前提條件？
3. 有什麼例外或邊界案例？
4. 為什麼是這樣（歷史原因、法規要求）？

### Step 2: 結構化記錄 [autonomous]

產出結構化文件：
1. 規則摘要（一句話版本）
2. 詳細說明（含前提條件）
3. 邊界案例列表
4. 具體案例（正例 + 反例）
5. 相關術語連結

### Step 3: 驗證與歸檔 [interactive]

請領域專家確認：
- 規則描述是否正確
- 案例是否涵蓋重要情境
- 歸檔位置是否合適

---

## 品質標準（Quality Gates）

- 每條規則有至少 1 個正例和 1 個反例
- 邊界案例已識別
- 規則背後的原因已記錄

---

## 已知限制（Limitations）

- 知識品質取決於訪談深度
- 隱性知識可能需要多次迭代才能完整萃取
