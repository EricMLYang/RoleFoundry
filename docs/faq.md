# 常見問題（FAQ）

---

**Q: Expert Repo 和 Project Repo 有什麼差別？**

Expert Repo 封裝一個角色的判斷力，知識可以跨多個專案複用。
Project Repo 服務單一專案的生命週期，通常整合多個 Expert 的 lite 版。

不確定要用哪種？先建 Project Repo，等你發現同樣的知識在第二個專案也需要時，抽取為 Expert。

---

**Q: 我只用 Claude Code，需要設定其他橋接檔嗎？**

需要。橋接檔的目的不只是讓其他 Agent 使用，也確保未來的相容性。
而且 `.github/copilot-instructions.md` 在 GitHub 上也有內容可讀（如果有團隊成員使用 Copilot）。

建立這三個橋接檔是 Framework v2 的必要結構，只要跑 role-bootstrap 就會自動建立。

---

**Q: 為什麼 principles.md 要和 identity.yaml 分開？**

兩者的穩定性不同：
- `identity.yaml` 是結構化的角色定義，格式固定，改動頻率低
- `principles.md` 是自由格式的判斷框架，需要用自然語言描述真實兩難情境，改動頻率較高

此外，principles.md 是「靈魂」——它讓 Agent 在面對框架外的情況時也能做出符合角色精神的決策。identity.yaml 告訴 Agent「是什麼」，principles.md 告訴 Agent「怎麼思考」。

---

**Q: 應該多久跑一次 repo-healthcheck？**

建議：
- 每次新增 Skill 後跑一次（確認新 Skill 符合規範）
- 每個月跑一次（確認 memory/ 有更新，Repo 沒有過時）
- 在重要里程碑前跑一次（確保 Repo 處於良好狀態）

---

**Q: knowledge/ 和 context/ 有什麼區別？**

- `knowledge/`（在 `.ai/` 內）：精煉後的核心知識，像是角色腦中的精華筆記。體積小，每次都需要載入，所有產出都必須符合這裡的規範。

- `context/`（在根目錄）：大量原始參考資料，像是桌上的參考書堆。體積可以很大，只在需要深度背景時才載入，可以部分被 `.gitignore` 排除。

簡單判斷：「Agent 每次執行任何任務都需要知道這件事嗎？」→ 是 → `knowledge/`；不是 → `context/`。

---

**Q: 我的 SKILL.md 寫了 10 頁，這樣對嗎？**

通常代表這個 Skill 做太多事了。建議：

1. 確認這個 Skill 有沒有超過一個觸發條件（有的話，考慮拆分）
2. 數一下流程步驟數量（超過 7 個，考慮拆分）
3. 用「上週真實任務」測試：如果任務 A 和任務 B 都能觸發這個 Skill，但 A 和 B 完全不同，那就是兩個 Skill。

目標：一個 SKILL.md 在 50-150 行之間，聚焦一個明確的任務類型。

---

**Q: 可以在初始版本加超過 5 個技能嗎？**

技術上可以，但不建議。超過 5 個 Skills 通常意味著：

1. **這個角色的範圍太大**：考慮拆成兩個更聚焦的 Expert Repo
2. **某些 Skills 還沒想清楚**：10 個空洞的 Skills 不如 3 個精實的 Skills
3. **維護負擔**：每個 Skills 都需要 examples/ 和 checklist，太多會無力維護

先從最重要的 3 個開始，等真實使用後再補充。

---

**Q: lite 版和完整版 Skill 更新時如何同步？**

手動使用 `sync-injection.sh`：

```bash
./tools/sync-injection.sh /path/to/target-repo
```

或者，使用 `interface-wiring` Skill 重新執行配線（會更新 imports.yaml 和 lite 版）。

建議在每次發布 Skill 的新版本後（更新 changelog.md）通知使用這個 lite 版的 Project Repo 同步。
