# _collab/ — 跨角色協作中樞

> 本資料夾是多個角色 Repo 之間的中立溝通區域。
> 所有角色可在此發起請求、回應、討論與產出共同成果。
> **任何角色不應直接修改其他角色 Repo 的檔案。**

---

## 設計原則

1. **中立地帶**：不屬於任何角色，所有角色平等使用
2. **檔案即訊息**：每個檔案就是一次溝通，用檔名協議取代複雜路由
3. **非侵入性**：各角色 Repo 保持完全自治，`_collab/` 只是橋樑
4. **可追溯**：所有協作過程都是 Markdown 檔案，天然版控

---

## 資料夾結構

```
_collab/
├── README.md              ← 你正在讀的這份文件
├── _registry.yaml         ← 參與者註冊表（誰在、能做什麼）
│
├── requests/              ← 任務請求（委派、請求協助、請求審查）
│   └── {date}_{from}-to-{to}_{topic}.md
│
├── responses/             ← 任務回應（產出、建議、回饋）
│   └── {date}_{from}-to-{to}_{topic}.md
│
├── discussions/           ← 多輪討論（一個子資料夾 = 一個討論串）
│   └── {date}_{topic}/
│       ├── 01_{role}_{action}.md
│       ├── 02_{role}_{action}.md
│       └── ...
│
├── artifacts/             ← 協作產出物（共同完成的成果，穩定後搬回各自 Repo）
│   └── {date}_{topic}.md
│
└── _archive/              ← 已結案的請求與討論（保持工作區乾淨）
```

---

## 檔名規範

### requests/ 與 responses/

```
{YYYY-MM-DD}_{發起方alias}-to-{接收方alias}_{主題slug}.md
```

範例：
- `2026-03-02_arch-to-pm_review-api-design.md`
- `2026-03-02_pm-to-arch_api-design-feedback.md`

### discussions/

```
{YYYY-MM-DD}_{主題slug}/
  {序號2位}_{角色alias}_{動作}.md
```

範例：
- `2026-03-02_data-pipeline-strategy/01_architect_proposal.md`
- `2026-03-02_data-pipeline-strategy/02_pm_questions.md`

### artifacts/

```
{YYYY-MM-DD}_{主題slug}.md
```

---

## 協作流程

### 發起請求

1. 在 `requests/` 建立一個 `.md` 檔案（參考 request 模板）
2. 填寫 from、to、type、priority、status
3. 清楚描述需要什麼協助、提供相關上下文

### 回應請求

1. 讀取 `requests/` 中寫給自己的待處理請求（`status: open`）
2. 在 `responses/` 建立對應的回應檔案
3. 完成後將原始 request 的 `status` 更新為 `resolved`

### 發起討論

1. 在 `discussions/` 建立一個主題子資料夾
2. 用序號前綴確保順序：`01_`、`02_`、`03_`...
3. 每個參與者每次發言一個檔案，不修改他人的檔案

### 歸檔

- request/response 配對在 `status: resolved` 後，可整組搬到 `_archive/`
- discussion 在結論明確後，將結論摘要寫入 `artifacts/`，原始討論搬到 `_archive/`

---

## 與 Framework v2 的關係

```
Layer 1: .ai/interfaces/     靜態契約 — 我能提供什麼、我需要什麼
Layer 2: _collab/             動態協作 — 這次需要你幫忙做什麼 ★
Layer 3: 各 Repo 自治         執行細節 — 我自己的知識和技能
```

- **Layer 1**（`exports.yaml` / `imports.yaml`）定義的是「能力目錄」，不會頻繁變動
- **Layer 2**（`_collab/`）處理的是「即時任務流轉」，是活的溝通管道
- 兩者互補：先查 registry 知道誰能做什麼，再透過 request 委派具體任務

---

## 各角色 Repo 的配置

每個參與協作的角色 Repo 需在 `AGENTS.md` 加入以下段落：

```markdown
## 跨角色協作

本角色參與 workspace 層級的協作中樞：`../_collab/`

### 主動檢查
執行任務前，先檢查 `../_collab/requests/` 是否有發給本角色的待處理請求。

### 發起協作
需要其他角色協助時，在 `../_collab/requests/` 建立請求檔案，
格式見 `../_collab/README.md`。

### 協作紀律
- ✅ 在 _collab/ 中讀寫溝通檔案
- ✅ 引用自己 Repo 的檔案路徑作為上下文
- ❌ 直接修改其他角色 Repo 的任何檔案
- ❌ 在 _collab/ 以外的地方放跨角色產出
```
