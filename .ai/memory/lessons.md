# RoleFoundry 經驗教訓

> 從實際鍛造角色 Repo 的過程中學到的教訓。
> 每次完成真實鍛造任務後，記錄觀察到的問題和改善方向。

---

## 格式

```
## [日期] [任務描述]

**觀察**：[發生了什麼]
**根因**：[為什麼會發生]
**改善**：[對 Skill 或流程的調整建議]
**狀態**：[待處理 / 已改善（見 changelog）]
```

---

## 2026-03-02 初始建立 RoleFoundry Repo

**觀察**：role-bootstrap 的 5 步驟流程設計，Step 4（品質審查）是否應該 inline 還是啟動 repo-healthcheck Skill，有些猶豫。
**根因**：如果依賴 repo-healthcheck，那 repo-healthcheck 必須在 Phase 1 就完成（但它是 Phase 2 的工作）。
**改善**：role-bootstrap Step 4 內聯基本品質審查，repo-healthcheck 提供更完整的 5 維度評分。兩者互補不互斥。
**狀態**：已實作（role-bootstrap Step 4 為 inline 審查）

## 2026-03-02 RoleFoundry 自身的 examples/ 策略

**觀察**：role-bootstrap/examples/ 在初始版本中是空的，但開發計畫要求 M1 要有範例。
**根因**：規範要求「examples/ 必須存在」，但「內容」需要真實使用後才能填充。這是雞蛋問題——要有工具才能產生範例，要有範例工具才能跑好。
**改善**：context/examples/ 已替換為 context/archetypes/，各原型包含預設值、引導問題和 sample-principles，role-bootstrap 可直接整合使用。
**狀態**：已完成（ADR-004）
