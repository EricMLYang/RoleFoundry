---
name: pm-move-backlog-to-handoff
description: 將 Backlog 項目移交工程，產出完整 Product Brief。適用於「移交工程」「handoff」「產出 Product Brief」「準備 PDR」。
---

# Skill: 移動項目 Backlog → Handoff

## 目標
將 Backlog 項目移交工程，產出 Product Brief 供工程團隊進行 PDR 與開任務。

## 輸入
- `item_id`：例如 `RQ-001` 或對應 OPP ID
- `title`：項目標題
- `reason`：移動原因
- `handoff_date_actual`：YYYY-MM-DD

## 執行前檢查
1. 讀取 `05_product/03_backlog/00_backlog_list.md`，確認該項狀態可移交（`ready`）。
2. 檢查是否具備足夠證據（驗證摘要、風險、範圍建議）。
3. 必讀 `00_context/01_north_star.md`、`00_context/02_stakeholders.md`、`00_context/04_system_architecture.md`。
4. 選讀 `00_context/05_data_flows.md`、`00_context/06_constraints.md`、`00_context/03_users.md`（充實 Product Brief 內容）。

## 執行動作

### 1. 更新 Backlog 清單
在 `05_product/03_backlog/00_backlog_list.md` 將狀態更新為 `handed-off`，填入實際 Handoff Date。

### 2. 產出 Product Brief
在 `05_product/03_backlog/product_brief/` 建立檔案，命名為 `{item_id}_{簡短英文標題}.md`（例如 `RQ-001_permission_boundary.md`）。

一個需求一個檔案，內容依 [Product Brief 模板](templates/product-brief.md) 撰寫。

### 3. 決策記錄
若有關鍵取捨，追加到 `00_context/07_decisions.md`。

## 撰寫原則
- 內容要足夠讓工程團隊在 PDR 中理解需求全貌並做技術評估。
- User Stories 需具體到可拆 Task，避免模糊描述。
- 技術背景引用 `04_system_architecture.md`、`05_data_flows.md` 的資訊，不重複貼上但標明相關段落。
- 標註「待 PM 確認」的項目，不替 PM 最終拍板。
- 語言：繁體中文（技術名詞可保留英文）。

## 輸出格式
```markdown
### Move Result
- Item: [item_id] [title]
- Move: backlog -> handoff
- Status: handed-off
- Handoff Date (Actual): [YYYY-MM-DD]

### Updated Files
1. `05_product/03_backlog/00_backlog_list.md` - 狀態更新為 handed-off
2. `05_product/03_backlog/product_brief/{item_id}_{title}.md` - 新增 Product Brief
3. `00_context/07_decisions.md` - [若有更新]

### Checks
- Product Brief Ready: pass/fail
- User Stories 可拆 Task: pass/fail
- Decision Log Needed: yes/no
- Missing Fields: [無 / 欄位列表]

### PM Notes
- [需 PM 確認事項]
```

## 禁止事項
- 沒有 Product Brief 不算完成 handoff。
- Product Brief 是工程 PDR 的主要輸入，內容要完整可執行。
- 一個需求一個檔案，不合併。
- 任何取捨都需可追溯。


## 執行模式
[hybrid]



## 用途（Purpose）
- 本技能用於處理 pm-move-backlog-to-handoff 對應的工作流程，並產出可追溯結果。

## 何時使用（When to Use）
- 當任務符合 pm-move-backlog-to-handoff 的觸發情境時啟用。

## 品質標準（Quality Gates）
- 輸入來源明確且可追溯。
- 輸出包含下一步或決策依據。

