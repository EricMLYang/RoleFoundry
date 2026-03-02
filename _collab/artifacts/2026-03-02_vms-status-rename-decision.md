# 決策紀錄：VMS 車輛狀態欄位改名

- **日期**: 2026-03-02
- **討論串**: `../discussions/2026-03-02_vms-status-rename/`
- **參與者**: architect, pm, qa
- **決策**: 將 `retired` 改名為 `decommissioned`，Sprint 14 一次完成

---

## 決策摘要

| 項目 | 內容 |
|------|------|
| **變更** | Delta Lake + API + MongoDB 的車輛狀態欄位 `retired` → `decommissioned` |
| **原因** | 業務慣用語為「除役」（decommissioned），統一用語降低溝通成本 |
| **方案** | 直接改名（不做雙寫過渡期），Sprint 14 內完成 |
| **估計** | 1.5 人天 |
| **風險** | 低 — Delta Lake column rename 是 metadata-only，無外部 API 消費者 |

## 各角色行動項目

- [ ] **architect**：執行 Delta Lake rename + MongoDB + API 更新 → 完成後記錄 ADR-008
- [ ] **qa**：修改 22 個測試 + 執行回歸測試
- [ ] **pm**：協調前端 Dashboard 更新 + 通知報表使用者

## 歸屬

此產出物待各角色行動完成後：
- Architect 將 ADR-008 記錄到 `architect-expert/.ai/memory/decisions.md`
- QA 將回歸測試結果記錄到 `qa-expert/.ai/memory/lessons.md`
- 本檔案與相關討論串搬到 `_archive/`
