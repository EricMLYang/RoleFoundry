# Product Brief 模板

在 `05_product/03_backlog/product_brief/` 建立檔案，命名為 `{item_id}_{簡短英文標題}.md`。

```md
# Product Brief: {item_id} — {標題}

- 狀態: handed-off
- Handoff Date: {YYYY-MM-DD}
- 來源 OPP: {OPP ID}
- 對齊 OUT: {OUT ID}
- RICE: {分數}
- CoD Flag: {High/Medium/Low}

---

## 1. Problem Statement
- 要解決什麼問題／把握什麼機會
- 目前現況與痛點描述
- 不做會怎樣（影響範圍）

## 2. Target Users & Scope
- 目標使用者角色與人數
- 影響的事業群（DSBG / AMSC / ADP）
- 本次交付範圍（In Scope / Out of Scope）

## 3. Outcome & Success Metrics
- 對齊的 Outcome（引用 OUT 編號）
- 成功指標（可量化，例如「至少 X% 的 Y 會 Z」）
- 如何衡量（資料來源、頻率）

## 4. Evidence Summary
- 驗證方法與結果摘要（引用 OPP 編號）
- 關鍵數據或使用者回饋
- 信心水準（High / Medium / Low）與依據

## 5. User Stories / 功能需求
- 以使用者故事或功能點條列
- 格式：「身為 {角色}，我希望 {功能}，以便 {價值}」
- 標註優先級（Must / Should / Could）

## 6. 技術背景與限制
- 相關系統架構（參考 `04_system_architecture.md`）
- 資料流與介接點
- 已知技術限制或相依性
- 需要的基礎建設或環境準備

## 7. Assumptions & Risks
- 尚未驗證的假設（標註影響程度）
- 已識別風險與建議緩解方式
- 相依項目或外部因素

## 8. Recommended Scope & 階段建議
- 建議的 MVP 範圍
- 可拆分的階段（Phase 1 / 2 / ...）
- 每階段預期交付物

## 9. Open Questions for Engineering
- 需要工程團隊在 PDR 釐清的問題
- 需要 Technical Spike 的項目
- 架構或方案選擇建議（如有）

## 10. 相關資源
- 相關文件連結（OPP、驗證紀錄、Prototype 等）
- 參考的 `07_decisions.md` 條目
```
