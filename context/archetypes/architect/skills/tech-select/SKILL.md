---
name: tech-select
description: Structured technology selection analysis. Use when user says "應該用什麼技術" or "A 和 B 哪個更適合".
---

# Skill: tech-select — 技術選型

## 用途(Purpose)

當需要選擇技術、框架或工具時,執行結構化的選型分析。

- **輸入**:需求描述 + 約束條件
- **輸出**:選型報告(候選方案比較 + 建議 + Trade-off)

## 何時使用（When to Use）

- 「應該用什麼技術？」
- 「A 和 B 哪個更適合？」

---

## 前置條件（Prerequisites）

- 有明確的需求或問題要解決
- 了解團隊的技術能力和現有技術棧

---

## 流程（Process）

### Step 1: 約束收集 [interactive]

確認選型約束：
1. 要解決什麼問題？
2. 現有技術棧是什麼？
3. 團隊熟悉什麼技術？
4. 有沒有非功能需求（效能、安全、合規）？

### Step 2: 候選分析 [autonomous]

1. 列出候選方案（含「不引入新技術」選項）
2. 按維度比較：功能匹配度、學習曲線、社群活躍度、維護成本
3. 分析每個方案的 Trade-off

### Step 3: 建議與決策 [interactive]

產出選型建議：
- 推薦方案 + 理由
- 次選方案 + 何時考慮
- 風險和緩解措施

---

## 品質標準（Quality Gates）

- 候選方案包含「不引入新技術」選項
- 每個方案的 Trade-off 清楚
- 考慮了團隊能力因素

---

## 已知限制（Limitations）

- 無法預測技術未來發展
- 社群活躍度評估有時效性
