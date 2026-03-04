# collab-join — 執行 Checklist

## Step 1: 展示現況
- [ ] 讀取 `_collab/_registry.yaml` 成功
- [ ] 列出現有參與者（alias、name、can_handle 摘要）
- [ ] 若 registry 為空，顯示適當提示

## Step 2: 收集協作資訊
- [ ] Q1：取得 alias、name、repo_path
- [ ] Q2：至少 1 條 can_handle（含 task + when）
- [ ] Q3：1–3 條 collaborates_with（alias + on）
- [ ] Q4：preferred_collab_style（一句話）
- [ ] 若 identity.yaml 可讀，自動帶入已知值並詢問確認

## Step 3A: 寫入 registry
- [ ] 在 participants 下新增或更新條目
- [ ] alias 唯一性確認（不重複新增）
- [ ] joined_at 填入今日日期
- [ ] collaborates_with 的 alias 若為暫定，標記 `# 暫定` 注釋

## Step 3B: 更新 AGENTS.md
- [ ] 定位至目標 Repo 的 AGENTS.md
- [ ] 生成或更新「## 跨角色協作」段落
- [ ] 協作對象表格格式正確（含 alias + name + on）
- [ ] 使用方式三條說明齊全
- [ ] 不重複建立段落（已有時只更新表格）

## 確認輸出
- [ ] 顯示 ✅ 成功訊息
- [ ] 列出 registry 更新結果
- [ ] 列出 AGENTS.md 更新結果
- [ ] 列出協作對象清單
