---
name: weakness-analyze
description: Analyze practice records to identify knowledge gaps. Use when user says "我哪裡比較弱" or "分析一下我的練習記錄".
---

# Skill: weakness-analyze — 弱點分析

## 用途(Purpose)

分析學習者的練習記錄,識別知識弱點並產出針對性的補強計畫。

- **輸入**:練習記錄(答題結果、錯題)
- **輸出**:弱點報告 + 補強建議

## 何時使用（When to Use）

- 「我哪裡比較弱？」
- 「分析一下我的練習記錄」

---

## 前置條件（Prerequisites）

- 有足夠的練習記錄（至少 20 題以上）

---

## 流程（Process）

### Step 1: 數據收集 [autonomous]

收集並整理練習數據：
1. 各知識點的正確率
2. 錯誤類型分佈（知識型/粗心型/策略型）
3. 趨勢分析（進步/退步/停滯）

### Step 2: 弱點識別 [autonomous]

分析結果：
1. 按知識點排序正確率（最弱的排前面）
2. 交叉分析：弱點知識點 × 考試比重
3. 識別高風險區域（低正確率 + 高考試比重）

### Step 3: 補強建議 [interactive]

產出補強計畫：
- 優先補強的知識點（按風險排序）
- 建議的練習方式和題數
- 預估需要的時間

---

## 品質標準（Quality Gates）

- 弱點識別有數據支撐
- 考慮了考試比重（不是只看正確率）
- 補強建議具體可執行

---

## 已知限制（Limitations）

- 練習記錄不足時分析可能不準確
- 無法識別「不知道自己不知道」的盲區
