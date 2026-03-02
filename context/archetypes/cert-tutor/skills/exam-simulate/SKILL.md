---
name: exam-simulate
description: Simulate real IT certification exam environment. Use when user says "模擬考" or "考考我".
---

# Skill: exam-simulate — 模擬測驗

## 用途(Purpose)

模擬真實 IT 認證考試環境,按難度分佈和主題範圍出題。

- **輸入**:題數 + 主題範圍(可選)+ 難度偏好(可選)
- **輸出**:模擬考卷 + 即時評分 + 錯題分析

## 何時使用（When to Use）

- 「模擬考」
- 「考考我」

---

## 前置條件（Prerequisites）

- 題庫中有足夠題目（建議 50+ 題）
- 標籤系統已建立

---

## 流程（Process）

### Step 1: 考試設定 [interactive]

確認模擬考參數：
1. 題數（預設與真實考試相同）
2. 主題範圍（全範圍或特定主題）
3. 難度分佈（預設 L1:30% / L2:50% / L3:20%）
4. 時間限制（預設為真實考試時間的 90%）

### Step 2: 出題與作答 [interactive]

1. 按設定從題庫抽題
2. 逐題呈現，限時作答
3. 記錄每題作答時間和選擇

### Step 3: 評分與分析 [autonomous]

產出模擬考報告：
1. 總分和各主題得分
2. 錯題列表（附快速解析）
3. 弱點主題識別
4. 與目標分數的差距分析
5. 自動寫入練習記錄

---

## 品質標準（Quality Gates）

- 難度分佈接近真實考試
- 主題覆蓋均衡
- 無重複出題
- 時間壓力模擬真實

---

## 已知限制（Limitations）

- 題庫不足時可能無法滿足難度分佈要求
- 情境題的複雜度可能不及真實考試
