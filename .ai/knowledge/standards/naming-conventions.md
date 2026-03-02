# 命名規範

> Framework v2 中所有檔案、目錄、欄位的命名規則。

---

## 目錄命名

| 類型 | 規則 | 範例 |
|------|------|------|
| Skill 目錄 | kebab-case | `role-bootstrap/`、`arch-review/` |
| 角色 alias | kebab-case（名詞）| `architect`、`product-manager`、`domain-expert` |
| Agent 目錄 | kebab-case | `.github/agents/`、`.ai/interfaces/injections/` |

---

## 檔案命名

| 檔案類型 | 規則 | 說明 |
|---------|------|------|
| 核心指令檔 | SCREAMING_CASE.md | `AGENTS.md`、`CLAUDE.md`、`GEMINI.md` |
| 技能指令 | SCREAMING_CASE.md | `SKILL.md` |
| 品質清單 | lowercase.md | `checklist.md`、`changelog.md` |
| YAML 設定 | lowercase.yaml | `identity.yaml`、`_index.yaml`、`glossary.yaml` |
| 模板 | `<name>.tmpl` | `identity.yaml.tmpl`、`AGENTS.md.tmpl` |
| 注入檔（injections/） | `<role>-lite.md` | `foundry-lite.md`、`architect-lite.md` |
| GitHub Copilot Prompt | `<name>.prompt.md` | `role-interview.prompt.md`（`.github/prompts/` 下） |
| GitHub Copilot Agent | `<name>.agent.md` | `foundry-lite.agent.md`（`.github/agents/` 下） |

---

## 模板佔位符

| 規則 | 格式 | 範例 |
|------|------|------|
| 佔位符語法 | 雙大括號、全大寫、底線分隔 | `{{ROLE_NAME}}`、`{{ONE_LINER}}` |
| 多行佔位符 | 同格式，附說明注釋 | `{{PERSPECTIVE}}  # 兩句話：視角 + 關注點` |

佔位符命名規則：
- 使用描述性名稱（`{{ROLE_NAME_ZH}}` 而非 `{{N}}`）
- 語意清楚（`{{OWNS_SUMMARY}}` 而非 `{{OS}}`）

---

## YAML 欄位命名

| 規則 | 範例 |
|------|------|
| snake_case | `schema_version`、`one_liner`、`defers_to` |
| 列表鍵 | 複數形（`skills`、`imports`、`anti_patterns`）|
| 布林值 | lowercase（`true`、`false`）|

---

## Skill alias 命名

格式：`動詞-名詞`（kebab-case）

| 好的命名 | 不好的命名 | 原因 |
|---------|----------|------|
| `arch-review` | `review` | 太模糊，哪種 review？ |
| `role-bootstrap` | `bootstrap` | 加角色前綴更清楚 |
| `prd-write` | `writing` | 動詞用原形，不用進行式 |
| `repo-healthcheck` | `check-repo` | 受詞在前更符合 kebab 慣例 |

---

## 禁止的命名

- 空格（使用 kebab-case）
- camelCase（JavaScript 風格，不適用）
- 全大寫 alias（AGENTS.md 是例外，因為是根目錄核心檔案）
- 混合語言（alias 只用英文；`name` 欄位用中文）
