# QA 回應：測試影響評估

- **角色**: qa
- **回應對象**: `01_architect_proposal.md`, `02_pm_business-impact.md`

---

## 測試影響範圍

### 硬編碼 `retired` 的測試

| 測試層級 | 數量 | 修改複雜度 |
|---------|------|-----------|
| Unit Tests（PySpark） | 12 個 | 低（字串替換） |
| Integration Tests（API） | 5 個 | 低（字串替換） |
| E2E Tests（Dashboard） | 3 個 | 中（含 UI assertion） |
| Data Validation Rules | 2 條 | 低（Delta Lake schema check） |

**合計**：22 個測試需修改，估計 0.5 天工作量

### 回歸測試建議

改名後需要執行的回歸測試：
1. ✅ Delta Lake 讀寫測試（新舊資料相容性）
2. ✅ API 回傳值驗證（所有包含 status 欄位的 endpoint）
3. ✅ Dashboard 車輛狀態篩選功能
4. ✅ 月報產出（確認 label 正確顯示）

## 結論

**支持直接改名（不需過渡期）**，理由：
- 測試修改量小（0.5 天）
- 沒有外部 API 消費者
- 一次改完比雙寫過渡期的長期維護成本更低

但 **前提** 是 architect 確認 Delta Lake schema evolution 可以在同一個 Sprint 完成。
