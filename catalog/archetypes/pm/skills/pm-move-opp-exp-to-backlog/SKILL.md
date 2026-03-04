---
name: pm-move-opp-exp-to-backlog
description: 將驗證完成的 OPP 移入 Backlog，補齊 RICE 與 CoD 評分。適用於「移到 backlog」「OPP 驗證完了」「move to backlog」。
---

# Skill: 移動項目 OPP+EXP → Backlog

## 目標
將驗證完成的 OPP 移入 Backlog，並補齊評分與日期欄位。

## 輸入
- `item_id`：例如 `OPP-003`
- `title`：項目標題
- `outcome_link`：例如 `OUT-001`
- `reason`：移動原因（必須是驗證證據）
- `rice`：RICE 分數
- `cod_flag`：High | Medium | Low
- `created_date`：YYYY-MM-DD
- `handoff_date_plan`：YYYY-MM-DD（可空）

## 執行前檢查
1. 讀取 `00_context/01_north_star.md`，確認方向一致。
2. 讀取 `05_product/02_opp_and_exp/0_OPP.md`，確認該項有驗證結論。
3. 確認狀態可更新為 `validated`。
4. 檢查 Backlog 必填欄位是否齊全。
5. 選讀 `00_context/06_constraints.md`（確認無阻擋因素）。

## 執行動作
1. 在 `0_OPP.md` 清單與該區塊將狀態改為 `validated`。
2. 追加到 `05_product/03_backlog/00_backlog_list.md`（含 Created Date / Handoff Date / RICE / CoD）。
3. 如有詳細長文，移至 `05_product/02_opp_and_exp/history/`。

## 輸出格式
```markdown
### Move Result
- Item: [item_id] [title]
- Move: opp_exp -> backlog
- Outcome Link: [OUT-###]
- Status: validated

### Updated Files
1. [path] - [變更摘要]
2. [path] - [變更摘要]

### Checks
- Evidence Ready: pass/fail
- Backlog Required Fields: pass/fail
- Missing Fields: [無 / 欄位列表]

### PM Notes
- [需 PM 確認事項]
```

## 禁止事項
- 不可跳過驗證直接進 Backlog。
- 若驗證不足，輸出缺漏項，不要執行移動。


## 執行模式
[hybrid]



## 用途（Purpose）
- 本技能用於處理 pm-move-opp-exp-to-backlog 對應的工作流程，並產出可追溯結果。

## 何時使用（When to Use）
- 當任務符合 pm-move-opp-exp-to-backlog 的觸發情境時啟用。

## 品質標準（Quality Gates）
- 輸入來源明確且可追溯。
- 輸出包含下一步或決策依據。

