---
name: pm-move-inbox-to-opp-exp
description: 將 Inbox 信號升級為 OPP，含 Outcome 對齊檢查。適用於「建 OPP」「這個信號要升級」「move to opp」「信號升級」。
---

# Skill: 移動項目 Inbox → OPP+EXP（含 Outcome 對齊）

## 目標
將一筆 Inbox 信號直接移到 `0_OPP.md`，中間包含 Outcome 對齊檢查。

## 核心原則
- `Outcomes` 是相對穩定內容，預設不修改。
- 只有在「現有 Outcome 無法涵蓋」時，才更新 `05_product/01_outcomes/01_outcomes.md`。

## 輸入
- `signal_id`：例如 `SIG-20260224-012`
- `opp_id`：例如 `OPP-008`
- `title`：項目標題
- `owner`：負責人（可空）
- `reason`：移動原因

## 執行前檢查
1. 讀取 `00_context/01_north_star.md`，確認方向一致。
2. 讀取 `05_product/01_outcomes/01_outcomes.md`，找出可對齊的 `OUT-###`。
3. 讀取 `05_product/02_opp_and_exp/0_OPP.md`，避免 OPP 編號重複。
4. 選讀 `00_context/03_users.md`、`00_context/06_constraints.md`（有助判斷 OPP 方向）。

## 執行動作
1. Outcome 對齊：
   - 優先使用既有 `OUT-###`，不改 Outcomes。
   - 若現有 Outcome 無法涵蓋，才更新 `05_product/01_outcomes/01_outcomes.md`（最小必要修改）。
2. 更新 Inbox（`01_inbox/`）：在來源信號加註 `狀態: promoted`，並標註對應 `OUT-###`、`OPP-###`。
3. 更新 OPP：在 `05_product/02_opp_and_exp/0_OPP.md` 依對應 Outcome 分組插入新 OPP 區塊（`### OPP-XXX`）。
   - 若該 Outcome 分組不存在，先新增 `## OUT-XXX：[標題]`。
   - 同時更新末尾「信號覆蓋率確認」表格。
   - 使用 [OPP 區塊模板](templates/opp-block.md) 填寫內容。
4. 狀態預設為 `identified` 或 `experimenting`（依 reason 判定）。

## 輸出格式
```markdown
### Move Result
- Signal: [signal_id]
- OPP: [opp_id] [title]
- Move: inbox -> opp_exp
- Outcome Link: [OUT-###]
- Outcome Changed: yes/no
- Status: [identified/experimenting]

### Updated Files
1. [path] - [變更摘要]
2. [path] - [變更摘要]
3. [path] - [變更摘要] （若未改 Outcome 可省略）

### Checks
- Goal Alignment: pass/fail
- Outcome Match: pass/fail
- Duplicate ID: pass/fail
- Missing Fields: [無 / 欄位列表]

### PM Notes
- [需 PM 確認事項]
```

## 禁止事項
- 不要為了單一信號頻繁改 Outcome。
- 若需要改 Outcome，僅做最小修改並說明原因。
- 優先維持單檔瀏覽：OPP 只更新 `05_product/02_opp_and_exp/0_OPP.md`。
- 若信號是對既有 OPP 的「小補充」（非新 OPP），改走「直接更新 0_OPP.md」路徑（見 review-opp-status 規則），不建新 OPP 編號。


## 執行模式
[hybrid]



## 用途（Purpose）
- 本技能用於處理 pm-move-inbox-to-opp-exp 對應的工作流程，並產出可追溯結果。

## 何時使用（When to Use）
- 當任務符合 pm-move-inbox-to-opp-exp 的觸發情境時啟用。

## 品質標準（Quality Gates）
- 輸入來源明確且可追溯。
- 輸出包含下一步或決策依據。

