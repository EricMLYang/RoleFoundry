const pptxgen = require("pptxgenjs");

const pres = new pptxgen();
pres.layout = "LAYOUT_16x9";
pres.author = "RoleFoundry";
pres.title = "RoleFoundry — 角色鍛造師";

// ── Color Palette (Ocean Gradient) ──
const C = {
  navy:     "21295C",
  deep:     "065A82",
  teal:     "1C7293",
  white:    "FFFFFF",
  offWhite: "F0F4F8",
  lightGray:"CBD5E1",
  darkText: "1E293B",
  mutedText:"64748B",
};

// ── Typography ──
const FONT_H = "Georgia";
const FONT_B = "Calibri";

// ── Helpers ──
const makeShadow = () => ({
  type: "outer", color: "000000", blur: 6, offset: 2, angle: 135, opacity: 0.12
});

// ============================================================
// SLIDE 1: Title
// ============================================================
{
  const slide = pres.addSlide();
  slide.background = { color: C.navy };

  // Accent shape — tall vertical bar
  slide.addShape(pres.shapes.RECTANGLE, {
    x: 0.0, y: 0, w: 0.12, h: 5.625, fill: { color: C.teal }
  });

  // Icon emoji as large text
  slide.addText("🔨", {
    x: 0.7, y: 0.9, w: 2, h: 1.2, fontSize: 60, fontFace: FONT_B, margin: 0
  });

  // Title
  slide.addText("RoleFoundry", {
    x: 0.7, y: 2.0, w: 8, h: 1.0,
    fontSize: 44, fontFace: FONT_H, color: C.white, bold: true, margin: 0
  });

  // Subtitle
  slide.addText("角色鍛造師 — 快速鍛造高品質角色 Repo", {
    x: 0.7, y: 3.0, w: 8, h: 0.6,
    fontSize: 20, fontFace: FONT_B, color: C.teal, margin: 0
  });

  // Tagline
  slide.addText("讓 Coding Agent 真正理解角色的思考方式", {
    x: 0.7, y: 3.8, w: 8, h: 0.5,
    fontSize: 14, fontFace: FONT_B, color: C.lightGray, italic: true, margin: 0
  });
}

// ============================================================
// SLIDE 2: The Problem
// ============================================================
{
  const slide = pres.addSlide();
  slide.background = { color: C.offWhite };

  slide.addText("為什麼需要 RoleFoundry？", {
    x: 0.7, y: 0.4, w: 9, h: 0.8,
    fontSize: 32, fontFace: FONT_H, color: C.navy, bold: true, margin: 0
  });

  // Three pain-point cards
  const cards = [
    { title: "模板填充症", desc: "Agent 角色設定只填了欄位，但缺乏靈魂與判斷力" },
    { title: "孤島角色", desc: "角色無法與其他 Repo 協作，缺少介面定義" },
    { title: "品質不穩定", desc: "Skill 沒有 examples，Agent 產出像開盲盒" },
  ];

  cards.forEach((c, i) => {
    const cardX = 0.7 + i * 3.05;
    const cardY = 1.7;
    const cardW = 2.7;
    const cardH = 2.8;

    // Card background
    slide.addShape(pres.shapes.RECTANGLE, {
      x: cardX, y: cardY, w: cardW, h: cardH,
      fill: { color: C.white }, shadow: makeShadow()
    });

    // Top accent bar
    slide.addShape(pres.shapes.RECTANGLE, {
      x: cardX, y: cardY, w: cardW, h: 0.06,
      fill: { color: C.deep }
    });

    // Card title
    slide.addText(c.title, {
      x: cardX + 0.25, y: cardY + 0.35, w: cardW - 0.5, h: 0.5,
      fontSize: 18, fontFace: FONT_H, color: C.navy, bold: true, margin: 0
    });

    // Card desc
    slide.addText(c.desc, {
      x: cardX + 0.25, y: cardY + 1.0, w: cardW - 0.5, h: 1.5,
      fontSize: 13, fontFace: FONT_B, color: C.mutedText, margin: 0
    });
  });
}

// ============================================================
// SLIDE 3: Solution — Repo Architecture
// ============================================================
{
  const slide = pres.addSlide();
  slide.background = { color: C.white };

  slide.addText("Framework v2 角色 Repo 架構", {
    x: 0.7, y: 0.4, w: 9, h: 0.8,
    fontSize: 32, fontFace: FONT_H, color: C.navy, bold: true, margin: 0
  });

  // Two-column layout
  // Left column: directory structure
  const dirs = [
    { dir: ".ai/",             desc: "identity · principles · knowledge · memory" },
    { dir: ".github/skills/",  desc: "技能定義 + examples + checklist" },
    { dir: ".github/agents/",  desc: "Agent 精簡注入" },
    { dir: "catalog/",         desc: "角色原型 + 預設技能素材" },
    { dir: "_collab/",         desc: "跨角色協作中樞" },
  ];

  dirs.forEach((d, i) => {
    const rowY = 1.6 + i * 0.72;

    // Dir name (monospace-like)
    slide.addText(d.dir, {
      x: 0.7, y: rowY, w: 2.5, h: 0.45,
      fontSize: 14, fontFace: "Consolas", color: C.teal, bold: true,
      margin: 0, valign: "middle"
    });

    // Description
    slide.addText(d.desc, {
      x: 3.3, y: rowY, w: 3.2, h: 0.45,
      fontSize: 13, fontFace: FONT_B, color: C.darkText,
      margin: 0, valign: "middle"
    });
  });

  // Right column: key insight box
  slide.addShape(pres.shapes.RECTANGLE, {
    x: 6.8, y: 1.6, w: 2.8, h: 3.2,
    fill: { color: C.navy }
  });

  slide.addText("設計哲學", {
    x: 7.0, y: 1.8, w: 2.4, h: 0.5,
    fontSize: 16, fontFace: FONT_H, color: C.teal, bold: true, margin: 0
  });

  slide.addText([
    { text: "角色 = 思考方式", options: { breakLine: true, bold: true } },
    { text: "", options: { breakLine: true, fontSize: 8 } },
    { text: "不只是模板填充，\n而是封裝角色獨特的\n判斷框架與決策原則。", options: {} },
  ], {
    x: 7.0, y: 2.4, w: 2.4, h: 2.2,
    fontSize: 13, fontFace: FONT_B, color: C.white, margin: 0
  });
}

// ============================================================
// SLIDE 4: Core Skills
// ============================================================
{
  const slide = pres.addSlide();
  slide.background = { color: C.offWhite };

  slide.addText("內建技能一覽", {
    x: 0.7, y: 0.4, w: 9, h: 0.8,
    fontSize: 32, fontFace: FONT_H, color: C.navy, bold: true, margin: 0
  });

  // 2x3 grid of skills
  const skills = [
    { name: "role-bootstrap",    desc: "從零建立角色 Repo" },
    { name: "identity-forge",    desc: "鍛造角色身份與原則" },
    { name: "skill-author",      desc: "結構化撰寫新技能" },
    { name: "repo-healthcheck",  desc: "Repo 品質自動檢查" },
    { name: "interface-wiring",  desc: "跨 Repo 介面配線" },
    { name: "catalog-update",    desc: "更新角色原型目錄" },
  ];

  skills.forEach((s, i) => {
    const col = i % 3;
    const row = Math.floor(i / 3);
    const cardX = 0.7 + col * 3.05;
    const cardY = 1.6 + row * 1.7;
    const cardW = 2.7;
    const cardH = 1.35;

    // Card
    slide.addShape(pres.shapes.RECTANGLE, {
      x: cardX, y: cardY, w: cardW, h: cardH,
      fill: { color: C.white }, shadow: makeShadow()
    });

    // Left accent bar
    slide.addShape(pres.shapes.RECTANGLE, {
      x: cardX, y: cardY, w: 0.06, h: cardH,
      fill: { color: C.teal }
    });

    // Skill name
    slide.addText(s.name, {
      x: cardX + 0.25, y: cardY + 0.2, w: cardW - 0.5, h: 0.4,
      fontSize: 14, fontFace: "Consolas", color: C.deep, bold: true, margin: 0
    });

    // Description
    slide.addText(s.desc, {
      x: cardX + 0.25, y: cardY + 0.7, w: cardW - 0.5, h: 0.4,
      fontSize: 12, fontFace: FONT_B, color: C.mutedText, margin: 0
    });
  });
}

// ============================================================
// SLIDE 5: Core Principles
// ============================================================
{
  const slide = pres.addSlide();
  slide.background = { color: C.white };

  slide.addText("五大核心信念", {
    x: 0.7, y: 0.4, w: 9, h: 0.8,
    fontSize: 32, fontFace: FONT_H, color: C.navy, bold: true, margin: 0
  });

  const principles = [
    { num: "01", title: "角色先於技能",       desc: "先確立思考方式，再設計能做什麼" },
    { num: "02", title: "具體勝過完整",       desc: "3 個具體 Skill 好過 10 個空泛 Skill" },
    { num: "03", title: "迭代是設計",         desc: "初始目標是「能跑」，不是「完美」" },
    { num: "04", title: "判斷力不可模板化",   desc: "principles.md 必須量身打造" },
    { num: "05", title: "介面即契約",         desc: "exports/imports 發布後不可任意修改" },
  ];

  principles.forEach((p, i) => {
    const rowY = 1.5 + i * 0.76;

    // Number circle
    slide.addShape(pres.shapes.OVAL, {
      x: 0.7, y: rowY, w: 0.5, h: 0.5,
      fill: { color: C.deep }
    });
    slide.addText(p.num, {
      x: 0.7, y: rowY, w: 0.5, h: 0.5,
      fontSize: 13, fontFace: FONT_B, color: C.white, bold: true,
      align: "center", valign: "middle", margin: 0
    });

    // Title
    slide.addText(p.title, {
      x: 1.45, y: rowY, w: 3, h: 0.5,
      fontSize: 16, fontFace: FONT_H, color: C.navy, bold: true,
      margin: 0, valign: "middle"
    });

    // Description
    slide.addText(p.desc, {
      x: 4.5, y: rowY, w: 5, h: 0.5,
      fontSize: 13, fontFace: FONT_B, color: C.mutedText,
      margin: 0, valign: "middle"
    });
  });
}

// ============================================================
// SLIDE 6: Get Started
// ============================================================
{
  const slide = pres.addSlide();
  slide.background = { color: C.navy };

  // Accent bar
  slide.addShape(pres.shapes.RECTANGLE, {
    x: 0.0, y: 0, w: 0.12, h: 5.625, fill: { color: C.teal }
  });

  slide.addText("開始鍛造你的角色", {
    x: 0.7, y: 1.2, w: 8, h: 1.0,
    fontSize: 36, fontFace: FONT_H, color: C.white, bold: true, margin: 0
  });

  // Steps
  const steps = [
    "1.  執行 role-bootstrap 技能，建立角色 Repo 骨架",
    "2.  用 identity-forge 鍛造角色身份與決策原則",
    "3.  用 skill-author 撰寫第一個可執行技能",
    "4.  用 repo-healthcheck 驗證產出品質",
  ];

  steps.forEach((s, i) => {
    slide.addText(s, {
      x: 0.9, y: 2.5 + i * 0.55, w: 8, h: 0.45,
      fontSize: 16, fontFace: FONT_B, color: C.lightGray, margin: 0
    });
  });

  slide.addText("本 Repo 同時是工具與示範 — 每次鍛造都是框架的活見證", {
    x: 0.7, y: 4.7, w: 9, h: 0.4,
    fontSize: 12, fontFace: FONT_B, color: C.teal, italic: true, margin: 0
  });
}

// ── Write file ──
pres.writeFile({ fileName: "output/RoleFoundry-Intro.pptx" })
  .then(() => console.log("✅ Created: output/RoleFoundry-Intro.pptx"))
  .catch(err => console.error("❌ Error:", err));
