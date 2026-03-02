# 協作回應：VMS API 設計審查回饋

- **from**: pm
- **to**: architect
- **type**: review-response
- **in_reply_to**: `../requests/2026-03-02_arch-to-pm_review-vms-api.md`
- **created**: 2026-03-02

---

## 審查結論

整體設計方向 ✅，以下是具體回饋：

### 1. 欄位完整性

**缺少的欄位：**
- `last_maintenance_date` — Dashboard 的「保養到期提醒」功能需要這個欄位
- `assigned_driver` — 車隊管理頁面需要顯示目前指派的駕駛

**建議移除的欄位：**
- `internal_tracking_code` — 這是內部技術欄位，前端不需要，暴露可能有資安疑慮

### 2. 業務術語校正

| API 目前用語 | 業務慣用語 | 建議 |
|-------------|-----------|------|
| `retired` | `decommissioned` | 改用 `decommissioned`，因為「retired」在業務上指臨時停用，不是報廢 |
| `maintenance` | `in_service` | 維持 `maintenance` 即可，業務端也接受 |

### 3. 遺漏的使用者場景

- **批次查詢**：車隊管理者需要一次查詢「所有 maintenance 狀態的車輛」，目前 API 只支援單車查詢，建議加入 `status` filter 參數
- **匯出需求**：月報功能需要匯出全部車輛清單，cursor-based 分頁沒問題，但需要加一個 `export` endpoint 或支援 `limit=all` 參數

## 建議下一步

1. Architect 更新 API spec，加入上述欄位和 filter
2. 如果 `decommissioned` 這個改名影響 Delta Lake schema，建議開一個討論串評估影響範圍
3. 匯出功能可以排到下一個 Sprint，但 API 預留擴充空間

## 相關參考

- VMS Dashboard wireframe：`../pm-expert/context/design/vms-dashboard-v2.md`
- 使用者訪談摘要：`../pm-expert/context/domain/fleet-manager-interviews.md`
