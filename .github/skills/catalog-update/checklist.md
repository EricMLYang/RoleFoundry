# catalog-update 品質驗收清單

> 每次使用 catalog-update 更新或新增原型後，逐項確認。

---

## 流程合規

- [ ] Step 3 已取得使用者明確確認後才執行修改
- [ ] 變更提案清單中，每項都標明了影響的檔案、現有內容與建議內容
- [ ] 涉及領域知識正確性的項目已標記 ⚠️ 警告

## 原型更新（操作 A）

- [ ] `archetype.yaml` 的 `last_updated` 欄位已更新
- [ ] `catalog/archetypes/_index.yaml` 中對應原型的 `last_updated` 已更新
- [ ] 修改的技能 `changelog.md` 已記錄本次變更
- [ ] `defaults.*` 修改後欄位結構仍符合 Framework v2 規範

## 新增原型（操作 B）

- [ ] 新建了完整的 `{alias}/` 目錄
- [ ] `archetype.yaml` 包含 `defaults` + `discovery_questions` + `common_anti_patterns`
- [ ] `sample-principles.md` 存在且有實質內容（非空白）
- [ ] `.ai/identity.yaml` 存在
- [ ] `.ai/principles.md` 存在
- [ ] `.ai/knowledge/glossary.yaml` 存在（至少 5 條術語）
- [ ] `.ai/interfaces/exports.yaml` 存在
- [ ] `skills/_index.yaml` 存在且至少有 1 個技能
- [ ] 每個技能目錄有三件套：`SKILL.md` + `changelog.md` + `checklist.md`
- [ ] `catalog/archetypes/_index.yaml` 已新增此原型的條目

## 技能新增（適用 A 和 B）

- [ ] 新技能有完整三件套：`SKILL.md` + `changelog.md` + `checklist.md`
- [ ] `examples/` 目錄已建立（可為空）
- [ ] 觸發條件用一句話說清楚（不超過 25 字）
- [ ] `skills/_index.yaml` 已更新

## 演進記錄

- [ ] `.ai/memory/evolution.md` 已補充本次 catalog 演進記錄
- [ ] 記錄包含：日期、原型名稱、來源、變更摘要、影響的檔案
