# RoleFoundry 設計決策記錄

> 格式：情境 → 選項 → 決策 → 理由 → Trade-off

---

## ADR-001: RoleFoundry 以 Expert Repo 實作，而非 CLI 工具

**日期**：2026-03-02
**狀態**：確定

**情境**：
需要決定 RoleFoundry 的實作形式。可選擇：
A. CLI scaffolding tool（如 Yeoman），自動化產生檔案
B. Expert Repo，透過 Coding Agent 對話引導使用者

**決策**：Expert Repo（選項 B）

**理由**：
- 角色鍛造的核心價值在於「引導思考過程」——幫助使用者想清楚角色定位、能力邊界、決策原則
- Coding Agent 的對話能力比 CLI 更適合這種引導工作
- Expert Repo 可以自我示範 Framework v2 的用法（dog-fooding）
- Skills 可以持續迭代，不需要走版本發布流程
- 未來可以產出 injection lite 版，讓 Project Repo 內建基礎鍛造能力

**Trade-off**：
- 犧牲了 CLI 的純自動化效率
- 換取了更好的引導品質與設計思考的沉澱

---

## ADR-002: templates/ 使用純文字模板而非程式化模板引擎

**日期**：2026-03-02
**狀態**：~~確定~~ 已廢棄（2026-03-04）— `templates/` 目錄已移除

**情境**：
role-bootstrap Skill 需要產生多個標準化檔案。可選擇：
A. 使用程式化模板引擎（如 Handlebars、Jinja2）
B. 使用純文字 .tmpl 檔案，以 `{{PLACEHOLDER}}` 標記佔位

**決策**：純文字模板（選項 B）

**理由**：
- 讓人類和 Coding Agent 都能直接讀懂和修改模板
- 避免引入額外的模板引擎依賴（保持 Repo 的純 Markdown/YAML 特性）
- Coding Agent 本身就是最好的「模板引擎」——它能理解佔位符的語意並智能填充
- 使用 `{{PLACEHOLDER_NAME}}` 格式（雙大括號、全大寫、底線分隔），不與 YAML 語法衝突

**Trade-off**：
- 犧牲了程式化模板的 type-safe 和 validation
- 換取了人類可讀性和零依賴

**後記（2026-03-04）**：`templates/` 目錄已移除。理由：初期維護成本高於收益，且 Coding Agent 可直接依規範產生正確結構，無需 `.tmpl` 作為中介。改為在 SKILL.md 中 inline 產出結構說明。

---

## ADR-003: 範例庫放 context/examples/ 而非獨立 Repo

**日期**：2026-03-02
**狀態**：~~確定~~ 已被 ADR-004 取代

**情境**：
需要決定範例角色 Repo（architect、PM、domain-expert）的存放位置。可選擇：
A. 每個範例放在獨立的 Repo（更接近真實使用情況）
B. 放在 RoleFoundry 的 context/examples/ 目錄下

**決策**：context/examples/（選項 B）

**理由**：
- 執行 role-bootstrap 時，Agent 需要即時參考範例作為品質對照
- 範例需要隨 Framework v2 一起版控（避免版本漂移）
- 大幅降低使用者的認知負擔（不需要 clone 多個 Repo）

**Trade-off**：
- 犧牲了範例的獨立版控和真實的「可 clone 使用」特性
- 換取了即時可取用性和版本一致性
- 緩解方案：每個範例包含 `generated-with.md`，說明如何用 role-bootstrap 產生可獨立使用的完整 Repo

---

## ADR-004: 以 Archetypes 取代 Examples，作為 role-bootstrap 的初始來源

**日期**：2026-03-02
**狀態**：確定

**情境**：
原本 `context/examples/` 放的是「已完成的角色範例」（展示用），但實際使用中發現：
- 範例是完成品，role-bootstrap 需要的是「起點」而非「終點」
- 範例缺少引導問題，Agent 無法用它來引導使用者客製化
- 不同角色需要不同的初始值和發現式問題

**選項**：
A. 保留 examples 並新增 archetypes（兩套並存）
B. 用 archetypes 完全取代 examples

**決策**：選項 B — 用 `context/archetypes/` 完全取代 `context/examples/`

**理由**：
- Archetype 包含 defaults（預設值）+ discovery_questions（引導問題）+ sample-principles（範本），比純 example 更有用
- 避免兩套參考來源造成的混淆（examples 和 archetypes 有重疊）
- role-bootstrap 流程可直接整合 archetype 匹配，提升鍛造效率

**Trade-off**：
- 犧牲了「完整範例可直接抄」的便利性
- 換取了「有引導的客製化起點」和更流暢的 bootstrap 體驗
