# Architect 總結：採用方案 B + Sprint 14 一次完成

- **角色**: architect
- **回應對象**: `02_pm_business-impact.md`, `03_qa_test-impact.md`

---

## Delta Lake Schema Evolution 評估

Delta Lake 的 schema evolution（`mergeSchema` option）可以新增欄位，
但 **rename column 需要用 `ALTER TABLE RENAME COLUMN`**（Delta Lake 3.0+）。

我們的環境是 Databricks Runtime 14.x + Delta Lake 3.1，**支援 column rename**。

### 遷移步驟

```sql
-- 1. Rename column
ALTER TABLE vms.vehicles RENAME COLUMN retired TO decommissioned;

-- 2. 歷史資料自動生效（Delta Lake column rename 是 metadata-only operation）
-- 不需要重寫資料
```

**風險**：metadata-only 操作，不影響既有 Parquet 檔案，幾乎零停機。

## 最終決策

綜合三方意見，採用 **Sprint 14 直接改名**（PM 偏好 + QA 評估可行 + 技術風險低）：

| 步驟 | 負責 | 估計 |
|------|------|------|
| Delta Lake schema rename | architect | 0.5hr |
| MongoDB Read Model 更新 | architect | 2hr |
| API response 欄位更新 | architect | 1hr |
| 測試修改 + 回歸 | qa | 4hr |
| Dashboard label 更新 | pm 協調前端 | 1hr |
| 報表使用者通知 | pm | 0.5hr |

**總估計**：1.5 人天，在 Sprint 14 內完成。

## 後續

- 此決策記錄到 `artifacts/2026-03-02_vms-status-rename-decision.md`
- Architect 記錄到自己的 `.ai/memory/decisions.md`（ADR-008）
- 本討論串可歸檔至 `_archive/`
