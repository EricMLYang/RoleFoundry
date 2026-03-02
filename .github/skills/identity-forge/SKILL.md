---
name: identity-forge
description: Design or optimize identity.yaml and principles.md for a role. Use when user says "幫我設計 [角色] 的 identity", "我的 identity.yaml 感覺沒有靈魂", "我想重新定義這個角色的能力邊界", or "幫我優化 principles.md".
---

# Skill: identity-forge — 角色身份鍛造

## 用途（Purpose）

從自然語言角色描述或既有 identity.yaml 出發，產出高品質的 `identity.yaml` + `principles.md`。

比 role-bootstrap 更聚焦：**只管身份設計，不管 Repo 結構**。適合需要重新定義或優化角色定位的情境。

- **輸入**：自然語言角色描述，或既有的 identity.yaml（需要優化時）
- **輸出**：高品質的 identity.yaml + principles.md

## 何時使用（When to Use）

- 「幫我設計 [角色] 的 identity」
- 「我的 identity.yaml 感覺沒有靈魂，幫我重寫」
- 「我想重新定義這個角色的能力邊界」
- 「幫我優化 principles.md，現在的版本太空泛」

---

## 前置條件（Prerequisites）

- 使用者能說出角色的大致職責或目前的痛點
- 如果是優化模式：使用者提供既有的 identity.yaml 路徑

---

## 流程（Process）

### Step 1: 角色定位萃取 [interactive]

同時提問以下 4 個問題（不用逐一問，可以一次列出讓使用者回答）：

**Q1**：這個角色最不能妥協的價值觀是什麼？
（用於生成具體的 anti_patterns）

**Q2**：這個角色的決定和誰的決定最容易衝突？在什麼情況下你會讓步？
（用於定義 defers_to 的具體情境）

**Q3**：用一個比喻描述這個角色的思考方式：
「這個角色像 ___ 的 ___，因為 ___」
（用於形塑 perspective 和 tone）

**Q4**：說 3 個這個角色最近真實做過的決定，以及做決定時主要考量了什麼？
（用於萃取 principles.md 的決策框架，不是發明的，是真實的）

等待使用者回答後，用「一句話確認」每個答案的理解是否正確，再進入 Step 2。

### Step 2: identity.yaml 草稿 [autonomous]

基於 Step 1 的回答，產出完整的 identity.yaml，重點在：

- **perspective**：必須描述「這個角色如何看世界」而非「這個角色的工作職責是什麼」。至少兩句話：第一句說視角，第二句說最在意的事。
- **tone**：必須有具體風格形容詞（例如「直接給結論、先問為什麼」），不能用「專業」這類空泛詞
- **anti_patterns**：必須基於 Q1 的回答和真實情境（不是泛泛的「過度設計」，而是「在無明確需求時就設計可擴展性」這類具體描述）
- **defers_to**：基於 Q2，`on` 欄位必須具體說明是什麼情境下讓步

### Step 3: principles.md 草稿 [autonomous]

從 Q4 的 3 個真實決定中，萃取決策框架。

**規則**：每條原則必須通過此測試：「如果遇到 [真實情境]，這條原則告訴我優先選什麼？」

**結構**：
1. 核心信念（3-5 條，每條附對應的「真實兩難」描述）
2. 決策框架（1-2 個，每個框架是「遇到 X 情況時，依序問 3 個問題」）
3. 經驗法則（可選，快速判斷的簡明規則）

### Step 4: 一致性審查 [interactive]

逐項確認 identity 和 principles 的一致性：

- [ ] anti_patterns 和 principles 相互呼應？（anti_patterns 記錄的問題，principles 應該提供解法）
- [ ] boundaries.owns 的事項，principles 中有對應的決策框架嗎？
- [ ] tone 在 principles.md 的行文中有體現嗎？（引導式 tone → 原則的描述方式是引導式的）
- [ ] one_liner 不超過 20 字？

列出不一致的項目，提供修改建議，等待使用者確認後輸出最終版本。

---

## 品質標準（Quality Gates）

- one_liner 必須在 20 字以內
- perspective 至少兩句話，第一句說視角，第二句說關注點
- principles.md 至少 3 條核心信念 + 1 個決策框架
- anti_patterns 必須基於真實情境描述（避免空泛的標籤式描述）
- defers_to 的 on 欄位必須具體（不能只說「技術決策」）

---

## 已知限制（Limitations）

- 無法替代角色擁有者的真實判斷力——Q4 的真實決定越具體，產出品質越好
- 如果使用者無法提供真實案例，此技能的產出將退化為模板填充，品質有限
