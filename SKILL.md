---
name: wuren-PPT-skills-v2
description: Use when creating, editing, reading, or quality-checking PPTX files for Wuren education-company scenarios, including training, student-facing lessons, parent talks, reports, summaries, proposals, enrollment, camps, workshops, and public presentations.
license: Proprietary
---

# Wuren PPT V2

## Core Principle

Do not directly improvise PPT pages from the user's text. First convert the content into a structured deck brief and slide plan, then generate slides from approved page patterns. Flexibility is allowed only through the scenario, audience, tone, content density, layout type, color role, and font role fields.

The goal is consistent Wuren visual quality across different AI models while still adapting layout, color, and typography to the content.

## Required Workflow

1. Identify the education-company scenario and audience.
2. Produce a `deckBrief` and `slidePlan` JSON before creating slides.
3. Select one visual system from [references/scenario-style-matrix.md](references/scenario-style-matrix.md).
4. Select each slide layout from the content signals, not from a fixed page order.
5. Create or reuse a dedicated project folder for the deck before writing files.
6. Generate PPTX with PptxGenJS unless the user explicitly requires another route.
7. Render the PPTX to images/PDF and run quality checks before reporting completion.

If information is missing, make a reasonable assumption and state it in `deckBrief.assumptions`. Ask the user only when missing information changes the PPT's purpose, audience, or confidentiality.

Before creating a deck for a new scenario, compare the request with [references/slide-plan-examples.md](references/slide-plan-examples.md) and reuse the closest decision pattern.

## Project Folder and File Organization

Every deck must be saved inside a dedicated project folder under the current PPT workspace. Do not leave generated PPTX, PDF, preview folders, slide-plan JSON, or generation scripts loose in the workspace root.

Default project folder name:

```text
YYYY-MM-DD 中文主题
```

Examples:

- `2026-07-08 全国老师AI提效赋能`
- `2026-07-03 教研组长AI赋能`
- `2026-06-26 线上系统升级汇报2.0`

If the folder does not exist, create it first. Use this structure:

```text
YYYY-MM-DD 中文主题/
  generate.js
  slide-plan.json
  output/
    主题_版本.pptx
    主题_版本.pdf
  preview/
    版本名/
      slide-01.png
      slide-02.png
      overview.png
```

Rules:

- `generate.js` and any helper scripts for this deck belong in the project folder.
- `slide-plan.json` belongs in the project folder.
- PPTX/PDF exports belong in `output/`.
- Rendered slide images and montage previews belong in `preview/<版本名>/`.
- For multiple deck versions, keep each preview in its own version folder, e.g. `preview/第一版`, `preview/第二版`, `preview/第二版_含讲稿备注`.
- Existing user-provided source files may stay where the user put them unless copying them into the project folder is necessary for reproducibility.
- Root-level generated files are allowed only for shared reusable assets or dependencies, not per-deck artifacts.

## Education Scenario Taxonomy

Use one primary scenario. Add a secondary scenario only when the deck genuinely mixes purposes.

| Scenario ID | Common user wording | Audience | Primary job |
|---|---|---|---|
| `internal_training` | 内部伙伴培训、老师赋能、顾问培训、面谈官培训、招募培训 | 内部伙伴、老师、顾问、城市团队 | Teach method, unify action, improve execution |
| `student_lesson` | 面向学生、课堂课件、成长营课程、工作坊课程 | 学生、营员、青少年 | Keep attention, simplify concepts, create participation |
| `parent_talk` | 家长宣讲、公开课、家长会、教育理念分享 | 家长、家庭用户、潜在客户 | Build trust, create empathy, explain value |
| `camp_closing` | 结营汇报、成长营总结、学员成果展示 | 学生、家长、老师、项目团队 | Show change, celebrate progress, preserve emotion |
| `leadership_report` | 工作汇报、项目复盘、数据分析、月报、经营汇报 | 老板、领导层、管理团队 | Expose facts, show judgment, drive decision |
| `annual_summary` | 年终总结、年度复盘、部门总结、来年规划 | 部门、公司管理层 | Review results, explain gaps, set plan |
| `proposal_sales` | 招商方案、合作方案、客户提案、产品介绍、课程介绍 | 客户、合作方、渠道、城市合伙人 | Communicate value, reduce doubt, prompt action |
| `enrollment_recruitment` | 招生说明、招募宣讲、顾问转化材料 | 家长、学生、潜在伙伴 | Clarify offer, prove credibility, convert |
| `public_keynote` | 大会演讲、发布会、品牌宣讲、主题分享 | 大会观众、外部公众 | Leave memory points, strengthen brand |
| `knowledge_share` | 知识分享、读书笔记、方法论分享 | 内部或外部学习者 | Explain ideas clearly and memorably |

## Dynamic Style Selection

Choose style by scenario and audience. Never use a single fixed template for every deck.

| Scenario | Font strategy | Color strategy | Layout density | Visual mood |
|---|---|---|---|---|
| `internal_training` | `PingFang SC` for structure, `Yuanti SC` for warm prompts | Purple base + blue learning accents + orange action accents | Medium | Clear, practical, energetic |
| `student_lesson` | `Yuanti SC` preferred; larger body text | Bright blue/yellow/orange accents, lower dark-purple ratio | Low | Playful, warm, simple |
| `parent_talk` | `Yuanti SC` strongly preferred | Warm purple + soft yellow/orange highlights, avoid harsh contrast | Low | Empathetic, reassuring, spacious |
| `camp_closing` | `Yuanti SC` for emotion, `PingFang SC` for data | Purple base + celebration orange/yellow + photo-friendly white pages | Low-medium | Warm, celebratory, story-driven |
| `leadership_report` | `PingFang SC` preferred | Dark purple headers + white pages + blue data + orange risks | High but controlled | Crisp, evidence-based |
| `annual_summary` | `PingFang SC` preferred | Purple base + blue achievements + orange gaps + yellow plans | Medium-high | Structured, reflective, decisive |
| `proposal_sales` | `PingFang SC` for credibility, `Yuanti SC` for user empathy | Purple brand authority + blue proof + orange call-to-action | Medium | Trustworthy, polished, persuasive |
| `enrollment_recruitment` | `Yuanti SC` for families, `PingFang SC` for partner recruitment | Warm purple + yellow hope + blue capability proof | Low-medium | Trust-building, clear, encouraging |
| `public_keynote` | Large `PingFang SC` or `Yuanti SC` depending on topic | High-contrast purple/orange hero pages + simple white pages | Low | Memorable, bold |
| `knowledge_share` | Match audience: `Yuanti SC` for families/students, `PingFang SC` for professionals | Balanced purple + one concept accent per section | Medium | Thoughtful, legible |

## Brand Tokens

Use these exact colors unless adapting contrast for accessibility.

```json
{
  "PRIMARY": "4C12A1",
  "DARK_BG": "3A0D7A",
  "LIGHT_BG": "F0E6FF",
  "SENSE_BLUE": "2DCCD3",
  "THINK_YELLOW": "FFA300",
  "SOCIAL_PURPLE": "C964CF",
  "ADMIN_ORANGE": "FC4C02",
  "BLACK": "1F1F1F",
  "GRAY": "6B7280",
  "LIGHT_GRAY": "F3F4F6",
  "WHITE": "FFFFFF",
  "SUBTITLE": "C4B5E0"
}
```

Color roles:

| Content meaning | Color role |
|---|---|
| Brand, authority, section headers | `PRIMARY` or `DARK_BG` |
| Learning, capability, positive data | `SENSE_BLUE` |
| Attention, insight, future plan | `THINK_YELLOW` |
| Urgency, pain point, action, conversion | `ADMIN_ORANGE` |
| Social/emotional/relationship content | `SOCIAL_PURPLE` |
| Body text | `BLACK` |
| Notes and secondary labels | `GRAY` |

## Slide Plan Contract

Before generating PPTX, produce JSON matching [schemas/slide-plan.schema.json](schemas/slide-plan.schema.json). The AI may compress the JSON in the conversation, but the generated script must follow this contract.

Required top-level fields:

- `deckBrief`: purpose, scenario, audience, tone, assumptions, styleProfile
- `slides`: ordered slide objects
- `qualityBar`: measurable constraints

Slide object fields:

- `type`: one of the approved layout types
- `intent`: what this slide must make the audience understand or feel
- `contentDensity`: `low`, `medium`, or `high`
- `colorRole`: dominant semantic color role
- `fontRole`: `warm`, `professional`, or `hybrid`
- `title`
- `payload`: layout-specific structured content
- `assetHint`: Tangzai or image guidance. For required Tangzai slides, set `useTangzai: true` and choose a `tangzaiKey`.

## Layout Selection Rules

Pick layouts from content signals:

| Content signal | Use layout type |
|---|---|
| Opening promise, topic, event info | `cover` |
| Agenda with 3-5 parts | `agenda` |
| New major section | `sectionDivider` |
| One core sentence, belief, slogan | `quote` |
| One or two important metrics | `bigNumber` |
| 3-4 peer points | `cards` |
| Cause-effect, before-after, A-vs-B | `compare` |
| Process, timeline, stages | `timeline` |
| Data trend, ranking, percentage comparison | `chart` |
| Student/parent/teacher voice | `testimonial` |
| Case story with background-action-result | `caseStory` |
| Lesson exercise or classroom interaction | `activity` |
| Summary and next action | `summaryAction` |
| Thanks, contact, closing phrase | `closing` |

## Content Density Rules

Use density to adapt layout, not to shrink everything.

| Density | Trigger | Rules |
|---|---|---|
| `low` | Parent talk, student lesson, keynote, emotional story | 1 main idea, max 60 Chinese characters of body text, font 28pt+ |
| `medium` | Training, proposal, camp closing | 1 main idea + 3-4 support points, body 18-24pt |
| `high` | Leadership report, annual summary, data-heavy proposal | Structured table/chart allowed, body 13-18pt, must preserve margins |

If a slide exceeds density limits, split it into multiple slides.

## Typography Rules

- `fontRole: warm`: use `Yuanti SC`; if unavailable, use `PingFang SC`.
- `fontRole: professional`: use `PingFang SC`; if unavailable, use `Microsoft YaHei`.
- `fontRole: hybrid`: titles use `PingFang SC`, emotional or audience-facing statements use `Yuanti SC`.
- Parent-facing and student-facing pages default to `Yuanti SC`.
- Leadership, annual summary, and data pages default to `PingFang SC`.
- Never use default Office fonts accidentally. Always specify `fontFace`.

## Logo and Asset Rules

- Put Wuren logo on every slide except when the user provides a strict external template that already has logo placement.
- Use `wurenlogo_1.png` on dark backgrounds and `wurenlogo_2.png` on light backgrounds.
- Logo position: `x: 11.5, y: 0.2, w: 1.35, h: 0.5`.
- Tangzai is part of the Wuren visual identity, not an optional decoration. Every newly generated deck must include Tangzai on at least 3 slides unless the user explicitly says not to use it.
- Default Tangzai target: 3-5 slides per deck. For student lessons, parent talks, camp closing decks, workshops, and warm public talks, target 4-6 slides.
- Keep the maximum at 7 Tangzai slides unless the deck is explicitly student-facing and the user asks for a more illustrated style.
- **Tangzai 禁用场景（硬性规则）**：
  - `cover` 封面：使用主图 + 大标题，**不放 tangzai**
  - `sectionDivider` 过渡页：连续的 part divider 最多 1 张用 tangzai
  - `closing` 尾页：用 5 个单色球 shape 装饰（不要重复贴 tangzai.png）
  - 连续 2 张及以上 page 都用 tangzai → 改为间隔使用
  - 与 Logo 同侧时让出 logo 位置
- Use Tangzai only where it supports meaning. Do not decorate every slide.
- Required slide plan behavior: mark enough slides with `assetHint.useTangzai: true` to satisfy `qualityBar.minTangzaiSlides`.
- Best Tangzai slide types: `agenda`, `quote`, `activity`, `caseStory`, `testimonial`, `summaryAction`, and selected low-density `cards` slides.
- Avoid Tangzai on `cover`, `sectionDivider`, dense `chart`, dense tables, and slides where it would compete with core text.
- Place Tangzai in a clear empty area: lower right, lower left, side margin beside text, or a dedicated illustration zone. Never overlap title, body text, charts, cards, footer, or logo.
- Use explicit image dimensions. Do not rely on default image sizing.
- **tangzai.png 是一个 4:1 横向长图（5 个汤圆排成一行）**，不是单球。尾页若要"5 球"装饰应画 shape 而不是贴图。
- If only local `assets/tangzai.png` is available, use it. If the richer Tangzai OSS catalog is available, choose the image that best matches the slide intent.

Tangzai semantic matching:

| Slide intent | Preferred key |
|---|---|
| Welcome, invitation, relationship building | `hello` |
| Thinking, reflection, uncertainty, discussion | `think` |
| Learning, concept explanation, classroom moment | `study` |
| Celebration, completion, growth outcome | `cheer` |
| Exploration, discovery, self-awareness | `explore` |
| Time, plan, process, next step | `time` |
| Technology or digital topic | `coding` |
| Confidence, courage, breakthrough | `superhero` |
| Closing thanks or warm goodbye | `leisure3d` |

## Quality Bar

The final deck must pass these checks:

- 16:9 wide layout.
- No placeholder text remains.
- No slide has text or assets outside the page.
- No title/body overlap.
- Minimum outer margin is 0.5 inch unless using intentional full-bleed background.
- Each content slide has a clear single main idea.
- Font face is specified on all text.
- Brand colors are used semantically, not randomly.
- Parent/student pages remain readable from the back row.
- Data/report pages prioritize evidence over decoration.
- Tangzai appears on at least `qualityBar.minTangzaiSlides` slides. Default minimum is 3.
- Tangzai placement is meaningful and non-overlapping.

## Spacing & Layout Rules (CRITICAL)

Common failure modes from earlier decks. **Follow these without exception.**

### Title + Accent Bar

- Title block: `y: 0.85, h: 0.7` (occupies 0.85–1.55), or `h: 0.9` occupying 0.85–1.75
- Accent bar **must sit BELOW title bottom + 0.15 inch gap**, never inside title
  - For 0.9h title → bar at `y: 1.9` or later
  - For 0.7h title → bar at `y: 1.7` or later
- If page has a section subtitle (PART XX label) above title → move title down to `y: 1.0`, bar at `y: 1.95`

### Image Box vs Source Ratio

**Read `references/pptxgenjs-gotchas.md` first.** PptxGenJS `sizing.cover` is **NOT** CSS `object-fit: cover` — it stretches.

- Teacher photo (0.667 source ratio): box must be `w/h = 0.667` (e.g., 3.4×5.1, 1.7×2.55)
- Never use `sizing.cover` for standalone portraits. Use it only for crop-within-card where the loss is acceptable.
- Always verify with the snippet in `references/pptxgenjs-gotchas.md` §6

### Logo / Page Number / Footer

- Logo top-right: `x: 11.5, y: 0.2, w: 1.35, h: 0.5`
- Page number bottom-right: `x: 12.0, y: 7.05, w: 1.0, h: 0.3`
- Footer tag bottom-left: `x: 0.5, y: 7.1, w: 8, h: 0.3`
- These three must never overlap body content. Reserve these zones.

### Tangzai Placement

- **DO NOT** use tangzai on `cover` or `sectionDivider` (see Logo & Asset Rules)
- For other slides: place in clear empty area, **minimum 0.3 inch** away from text edges, logo, page number
- Do not place above the title (looks like header bar)

## Completion Standard

Do not say the PPT is complete until:

1. PPTX generation succeeds.
2. Text extraction confirms content is present.
3. PDF or image rendering succeeds.
4. At least one visual QA pass has been performed.
5. Tangzai count is checked. If fewer than 3 Tangzai slides are present and the user did not opt out, the deck is incomplete.
6. Any discovered issues are fixed or explicitly reported.
