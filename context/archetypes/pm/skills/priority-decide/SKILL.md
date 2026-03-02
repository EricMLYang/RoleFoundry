---
name: priority-decide
description: Structured priority decision for competing requirements. Use when user says "這些需求怎麼排順序" or "Sprint 塞不下,要砍哪個".
---

# Skill: priority-decide — 優先順序決策

## 用途(Purpose)

當多個需求或功能競爭有限資源時,引導進行結構化的優先順序決策。

- **輸入**:待排序的需求清單
- **輸出**:排序結果(含理由與 Trade-off 說明)

## 何時使用（When to Use）

- 「這些需求怎麼排順序？」
- 「Sprint 塞不下，要砍哪個？」

---

## 前置條件（Prerequisites）

- 至少 2 個以上的待排序需求
- 有基本的業務目標或 OKR 可參照

---

## 流程（Process）

### Step 1: 需求盤點 [interactive]

列出所有待排序需求，確認每一項：
1. 需求名稱與一句話描述
2. 提出者 / 來源
3. 粗估工程成本（T-shirt size: S/M/L/XL）

### Step 2: 框架評分 [autonomous]

對每個需求套用決策框架：
1. **影響範圍** — 影響多少用戶？影響程度？（高/中/低）
2. **戰略對齊** — 是否符合本季 OKR / 產品願景？（直接/間接/無關）
3. **時間敏感** — 有沒有時間窗口？（急/一般/不急）
4. **依賴關係** — 是否 block 其他重要事項？（是/否）

產出排序矩陣表格。

### Step 3: 決策確認 [interactive]

呈現排序結果與理由，確認：
- P0 不超過 2 個
- 被降級的需求有明確理由
- Trade-off 已記錄

---

## 品質標準（Quality Gates）

- P0 同時不超過 2 個
- 每個排序決策有明確理由（不是「感覺」）
- Trade-off 有記錄（犧牲了什麼換取了什麼）

---

## 已知限制（Limitations）

- 無法量化政治因素對優先順序的影響
- 工程成本為粗估，最終需工程團隊確認
