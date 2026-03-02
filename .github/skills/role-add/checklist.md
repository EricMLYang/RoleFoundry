# role-add 品質驗收清單

> 每次使用 role-add 新增輔助角色後，逐項確認。

---

## Agent 檔案

- [ ] `.github/agents/{alias}.agent.md` 存在
- [ ] 包含 Role 區塊（名稱、alias、one_liner）
- [ ] 包含 Responsibilities 區塊（核心職責）
- [ ] 包含 Constraints 區塊（owns / advises / defers_to）
- [ ] 包含 Relationship 區塊（與主角色的雙向 defer 說明）

## 技能品質

- [ ] 技能目錄名稱有 `{role-b-alias}-` 前綴
- [ ] 每個技能有 SKILL.md + checklist.md + changelog.md + examples/
- [ ] 每個技能的觸發條件用一句話說清楚（不超過 25 字）
- [ ] 技能數量在 1-3 個之間
- [ ] `.github/skills/_index.yaml` 已更新

## AGENTS.md 更新

- [ ] 有「## 輔助角色」段落
- [ ] 輔助角色有摘要（定位 + 與主角色關係）
- [ ] 輔助角色有專屬技能表
- [ ] AGENTS.md 仍在 32KB 以內

## 橋接同步

- [ ] copilot-instructions.md 已反映輔助角色資訊
- [ ] 角色關係描述在 AGENTS.md 和 agent.md 一致

## 協作關係

- [ ] 主角色的 defers_to 已更新（新增對輔助角色的 defer）
- [ ] defer 關係雙向且具體（有明確的 `on` 說明）
