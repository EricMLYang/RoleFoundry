# role-bootstrap 品質驗收清單

> 每次使用 role-bootstrap 完成鍛造後，逐項確認。

---

## 結構完整性

- [ ] 目錄結構符合 Framework v2 規範（三層：.github/ + .ai/ + context/）
- [ ] 三個橋接檔全部建立（CLAUDE.md、GEMINI.md、.github/copilot-instructions.md）
- [ ] .ai/ 五個子目錄全部存在（knowledge/、interfaces/、memory/ 等）
- [ ] AGENTS.md 存在且在 32KB 以內

## Archetype 運用

- [ ] 若有匹配原型，已在 decisions.md 記錄採用了哪個 archetype、客製了哪些欄位
- [ ] 若無匹配原型，已在 decisions.md 記錄原因
- [ ] 若 archetype 有預建內容（has_prebuilt: true），seed 檔案已複製到目標 Repo
- [ ] 若 archetype 有 `repo-seed/`，流程目錄（如 01_inbox、05_product）已複製到目標 Repo
- [ ] glossary.yaml 已填入至少 8 條角色專屬術語
- [ ] 預設技能（skill-expand、copilot-sync）都存在於 .github/skills/

## 身份品質（identity.yaml）

- [ ] 包含全部 8 個頂層 key（schema_version, type, role, identity, capabilities, boundaries, quality_criteria, anti_patterns）
- [ ] one_liner 不超過 20 字
- [ ] perspective 描述的是「視角/世界觀」而非「職責清單」
- [ ] boundaries 包含 owns、advises、defers_to 三個欄位
- [ ] defers_to 至少 1 條，且 on 欄位具體（不是空泛的「技術決策」）
- [ ] anti_patterns 至少 3 條

## 判斷力品質（principles.md）

- [ ] 每條核心信念對應至少一個以「真實兩難」描述的情境
- [ ] 有「決策框架」段落（包含具體的判斷步驟，不只是信念列表）
- [ ] tone 在行文中有體現（不是只在 identity.yaml 中描述）

## 技能品質（skills）

- [ ] .github/skills/_index.yaml 包含所有初始技能
- [ ] 每個技能的觸發條件（trigger）用一句話說清楚，不超過 25 字
- [ ] 每個 SKILL.md 包含：用途、何時使用、流程（含模式標記）、品質標準、已知限制
- [ ] 每個 Skill 目錄有 checklist.md、changelog.md、examples/
- [ ] 初始技能數量符合 archetype 類型（一般 3-5；流程型 6-8）

## 介面品質（interfaces）

- [ ] exports.yaml 不為空（至少定義一個可被使用的 skill 或 knowledge）
- [ ] imports.yaml 存在（即使是空的，也要有說明）

## 記憶初始化（memory）

- [ ] decisions.md 記錄了本次鍛造的至少 1 個設計決策（Expert vs Project 選擇、初始技能選擇等）
- [ ] lessons.md 和 evolution.md 存在
