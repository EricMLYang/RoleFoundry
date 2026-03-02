# 提議：VMS 車輛狀態欄位改名 `retired` → `decommissioned` 的影響評估

- **發起者**: architect
- **參與者**: pm, qa
- **狀態**: concluded
- **結論摘要**: 採用方案 B（雙寫過渡期），詳見 `../../artifacts/2026-03-02_vms-status-rename-decision.md`

---

## 背景

在 VMS API 審查中，PM 建議將車輛狀態 `retired` 改為 `decommissioned`。
由於 Delta Lake 已有歷史資料使用 `retired`，需要評估改名的影響範圍。

## 希望討論

1. 改名對 Delta Lake schema evolution 的影響
2. 下游消費者（Dashboard、報表、MongoDB Read Model）的遷移成本
3. 過渡期策略
