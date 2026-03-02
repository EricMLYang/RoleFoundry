# 角色設計經驗法則

> 快速判斷的簡明規則，補充 principles.md 中無法窮舉的情境。
> 每條法則附「通過測試」幫助確認判斷。

---

## 身份（Identity）

### one_liner 測試
**法則**：超過 20 字，表示還沒想清楚角色定位。
**測試**：把 one_liner 說給一個不認識這個角色的人聽，對方能立刻理解「這個角色做什麼」→ PASS。

### perspective 測試
**法則**：perspective 描述的是「視角」而非「職責清單」。
**測試**：把 perspective 的第一句話改成「I think about everything from the perspective of...」，讀起來自然 → PASS。

### anti_patterns 測試
**法則**：每條 anti_pattern 都應該基於「真實失敗案例」而非抽象標籤。
**測試**：如果 anti_pattern 裡有「過度設計」這種空泛詞，補充成「在無明確需求的情況下就設計可擴展性」→ 更好。

### defers_to 測試
**法則**：如果 defers_to 是空的，這個角色沒有謙遜邊界，容易越界。
**測試**：問「這個角色在什麼情況下說『這不是我決定的』？」，答案就是 defers_to 的內容。

---

## 技能（Skills）

### 觸發條件測試
**法則**：觸發條件如果不能用一句話說清楚，需要拆分。
**測試**：把觸發條件念給一個不熟悉的人聽，他立刻知道什麼情況用這個技能 → PASS。

### Skill 分拆信號
**法則**：一個 SKILL.md 的流程超過 7 個步驟，或觸發條件包含「或」連接兩種不同情境。
**行動**：考慮拆成 2 個 Skill，各自聚焦一個情境。

### examples/ 重要性
**法則**：沒有 examples/ 的 Skill，Agent 產出品質不穩定。
**原因**：few-shot 學習效果——範例比指令更能穩定 Agent 的輸出格式和品質。

### Skill 數量上限
**法則**：初始版本的 Skills 不超過 5 個。
**信號**：如果你發現需要 8 個 Skills，考慮是否應該拆成兩個更聚焦的 Expert Repo。

---

## 介面（Interfaces）

### exports.yaml 是否為空
**法則**：exports.yaml 是空的 = 這個角色完全孤立，無法被其他 Repo 使用。
**行動**：至少把最核心的 1 個 Skill 加入 exports。

### lite 版長度
**法則**：lite 版超過 50 行就失去精簡意義。
**測試**：lite 版應該能在 30 秒內讀完，只包含「最常用的快速檢查清單」和「升級條件」。

### imports 的 reason 欄位
**法則**：每條 import 必須說明為什麼需要這個依賴。
**測試**：如果移除這條 import，這個角色的哪個核心能力會受損？答案就是 reason 欄位。

---

## 記憶（Memory）

### decisions.md 格式測試
**法則**：每條決策記錄必須包含「為什麼不選另一個方案」。
**格式**：情境 → 選項 → 決策 → 理由 → **Trade-off**（這個選擇犧牲了什麼）。

### lessons.md 品質
**法則**：lessons 必須來自真實鍛造任務，不能是「預期中的教訓」。
**測試**：每條 lesson 都有對應的一個「第一次遇到這個問題」的時間點。

---

## 跨角色（Cross-Role）

### Expert vs Project 判斷
**法則**：「第二次複用」是 Expert 的觸發點。
**情境**：同樣的知識在第二個專案中被需要 → 是時候抽取為 Expert Repo 了。

### 角色數量
**法則**：一個 Project Repo 注入超過 4 個 Expert 的 lite 版，表示 Project 的範圍可能太大。
**行動**：重新評估 Project 的邊界，或接受複雜度。
