# collab-join — Changelog

## v1.0.0 — 2026-03-04

### 新增
- 初始版本：3 步驟流程（展示現況 → 收集資訊 → 雙向產出）
- Step 1：讀取 `_collab/_registry.yaml` 展示現有參與者
- Step 2：4 個問題收集協作資訊（alias、can_handle、collaborates_with、collab_style）
- Step 3A：寫入 `_collab/_registry.yaml`（新增或更新）
- Step 3B：在目標 `AGENTS.md` 生成「跨角色協作」段落
- alias 唯一性保護（重複時更新，不新增）
- 支援從 identity.yaml 自動帶入已知值
