---
name: collab-join
description: Register a role into the collaboration hub and wire up its AGENTS.md. Use when user says "我要加入協作空間", "幫角色設定協作", "和其他角色連線", or "把 [角色] 加入協作中樞".
---

# Skill: collab-join — 協作空間加入

## 用途（Purpose）

將角色登記至 `_collab/_registry.yaml`（協作中樞的唯一資訊來源），並在角色的 `AGENTS.md` 自動生成「跨角色協作」段落，讓角色啟動後立即知道自己的協作環境。

- **輸入**：角色名稱 / alias，以及協作對象與風格偏好
- **輸出**：`_collab/_registry.yaml` 新增條目 + 目標 Repo `AGENTS.md` 更新「跨角色協作」段落

## 何時使用（When to Use）

觸發條件符合以下任一項即啟動本技能：
- 「我要加入協作空間」
- 「幫角色設定協作」
- 「和其他角色連線」
- 「把 [角色] 加入協作中樞」
- `role-bootstrap` 完成後，使用者接受後續建議執行本 Skill

---

## 前置條件（Prerequisites）

- `_collab/_registry.yaml` 存在（協作中樞已初始化）
- 使用者能描述此角色的職責與協作需求

---

## 流程（Process）

### Step 1: 展示協作空間現況 [autonomous]

讀取 `_collab/_registry.yaml`，列出現有參與者：

```
目前協作空間已有 [N] 個角色：

| # | alias | 名稱 | 能處理的任務（摘要）|
|---|-------|------|------------------|
| 1 | ...   | ...  | ...              |

以下幫你完成此角色的加入設定。
```

若 `_collab/_registry.yaml` 尚無任何 participants，顯示：「協作空間目前為空，你將是第一個加入的角色。」

---

### Step 2: 收集協作資訊 [interactive]

詢問 4 個問題（若能從 identity.yaml 自動帶入已知值，先告知使用者並詢問是否確認）：

**Q1. 角色識別**
- alias（英文，小寫 + 連字號）
- name（角色中文名稱）
- repo_path（此 Repo 相對協作中樞的路徑，例如 `../my-role/`）

**Q2. 能處理的任務（can_handle）**
- 至少 1 條任務描述
- 格式：`- task: "[任務說明]"` + `when: "[觸發情境]"`
- 例：`task: "系統架構評審"`, `when: "需要評估技術方案的可行性與一致性時"`

**Q3. 協作對象（collaborates_with）**
- 1–3 條，每條對應 _registry 中現有的 alias
- 格式：`- alias: "[對方 alias]"` + `on: "[協作主題]"`
- 若 registry 為空，可填入預期的協作角色（alias 為暫定值）

**Q4. 偏好的協作溝通風格（preferred_collab_style）**
- 一句話描述，例如：「先給結論再討論細節，不確定時直接問對方」
- 若沒有特別偏好，輸入「無特殊偏好」

---

### Step 3: 雙向產出 [autonomous]

收集完資訊後，執行以下兩個動作（不需使用者額外操作）：

**A. 寫入 `_collab/_registry.yaml`**

在 `participants:` 下新增或更新此角色的條目：

```yaml
  - alias: "[alias]"
    name: "[name]"
    repo_path: "[repo_path]"
    can_handle:
      - task: "[任務說明]"
        when: "[觸發情境]"
    collaborates_with:
      - alias: "[對方 alias]"
        on: "[協作主題]"
    preferred_collab_style: "[一句話風格]"
    joined_at: "[YYYY-MM-DD]"
```

若此 alias 已存在，更新現有條目（不重複新增）。

**B. 在目標 Repo 的 `AGENTS.md` 生成或更新「跨角色協作」段落**

定位至目標 Repo 的 `AGENTS.md`（依據 Step 2 Q1 的 repo_path），在「跨 Repo 協作」區塊（或文件末尾，如無此區塊）插入以下內容：

```markdown
## 跨角色協作

本角色已加入協作中樞：`../_collab/`

### 協作對象
| 角色 | 協作主題 |
|------|---------|
| [alias]（[name]） | [on] |

### 使用方式
- **主動檢查**：執行任務前，查 `../_collab/requests/` 有無發給我的待處理請求
- **發起協作**：在 `../_collab/requests/` 建立請求檔案（格式見 `_collab/README.md`）
- **協作紀律**：只在 `_collab/` 讀寫跨角色訊息，不直接修改他人 Repo
```

若 `AGENTS.md` 已有「## 跨角色協作」段落，更新協作對象表格，不重複建立段落。

---

### 確認輸出

完成後顯示：
```
✅ 已加入協作空間
- _collab/_registry.yaml：已新增/更新 [alias] 條目
- [repo_path]/AGENTS.md：已生成「跨角色協作」段落

協作對象：[alias1] / [alias2]...
此角色現在可以在 _collab/requests/ 接收和發起跨角色協作請求。
```

---

## 品質標準（Quality Gates）

- `_collab/_registry.yaml` 的 alias 必須唯一（重複時更新，不新增）
- `collaborates_with` 的 alias 必須對應 registry 中現有的角色（允許暫定值，但標記 `# 暫定` 注釋）
- 目標 `AGENTS.md` 的「跨角色協作」段落格式必須與本 Skill 定義的模板一致
- `joined_at` 填入執行當日日期

---

## 已知限制（Limitations）

- 若目標 Repo 的 `AGENTS.md` 不存在，會提示使用者先執行 `role-bootstrap`
- 不自動更新協作對象的 registry（對方 Repo 需自行執行 `collab-join`）
- 無法驗證 `repo_path` 路徑的實際存在（僅寫入 registry，不做檔案系統確認）
