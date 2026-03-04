# Changelog — repo-healthcheck

## v1.1 (2026-03-04)

- 調整技能數量檢查準則：初始 Repo 建議 3-5，成熟 Repo 可擴展到 6-10
- 降低成熟 Expert Repo 的誤報（避免把 6-10 技能誤判為過多）

## v1.0 (2026-03-02)

**初始版本**

- 5 維度檢查：Structure / Identity / Skills / Interfaces / Memory
- 三級判定：HEALTHY / NEEDS ATTENTION / CRITICAL
- 完全 autonomous 模式，不需要使用者互動
- 每個 FAIL 項附具體修復建議
