---
name: wuren-PPT-skills-v2
description: Use when creating, editing, or reading PPTX files for Wuren education-company scenarios, including training, student-facing lessons, parent talks, reports, summaries, proposals, enrollment, camps, workshops, and public presentations.
license: Proprietary
---

# Wuren PPT V2

## Core Principle

Do not directly improvise PPT pages from the user's text. First convert the content into a structured deck brief and slide plan, then generate slides from approved page patterns. Keep brand colors, typography, logo and spacing consistent. Adapt composition and IP selection to each slide’s content; approved layout types describe information structure, not a single fixed drawing template.

The goal is consistent Wuren visual quality across different AI models while still adapting layout, color, and typography to the content.

## Required Workflow

1. Identify the scenario, audience, purpose and whether the source is a new deck or an existing-deck conversion. Read enough source content and original images to understand the available design material.
2. Read [references/design-direction-and-rhythm.md](references/design-direction-and-rhythm.md). Unless the current request already names a concrete design direction or explicitly says to proceed without questions, present 2-3 concise, content-specific design directions and ask the user to choose or combine them. Explain each option’s visual hierarchy, composition and mood; recommend one and say why. Wait for the choice before writing the `deckBrief`, `slidePlan` or generating slides. Do not ask the user to invent a style or select from a generic fixed template catalog.
3. After the direction is chosen, produce `deckBrief` and `slidePlan` JSON before creating slides, including the selected design direction, rationale, motif and rhythm. Select one visual system from [references/scenario-style-matrix.md](references/scenario-style-matrix.md). Read [references/ip-and-composition.md](references/ip-and-composition.md) and [assets/tangzai-catalog.json](assets/tangzai-catalog.json) for every PPT request, even when the user does not mention IP. Loading the catalog is mandatory; inserting IP is conditional on scene and composition fit.
4. Plan narrative roles, visual focus and reading rhythm across the deck; select each slide layout and `layoutVariant` from content signals, not a single renderer for every page type. Assess IP suitability on every slide and record `assetHint.useTangzai` plus `selectionReason` for both use and omission. If suitable, resolve a real catalog asset and plan its position. If no slide is suitable, a deck with no IP is valid; do not add it to meet a quota.
5. Create or reuse a dedicated project folder for the deck before writing files.
6. Retrieve selected OSS assets into the deck project’s `assets/` before generation, inspect their actual appearance, then generate PPTX with PptxGenJS unless the user explicitly requires another route. Read the selected key and placement from the slide plan when adding IP images; never hardcode one generic image for all IP slides.
7. Once PPTX generation succeeds, provide its file link immediately and say: “PPT生成好了，你自己检查一下。” Do not run text extraction, PDF/image rendering, visual QA, boundary/overlap checks, or Tangzai count checks. Do not create PDF or previews unless the user explicitly requests those deliverables. Never claim the deck has been checked.

If information is missing, make a reasonable assumption and state it in `deckBrief.assumptions`. Ask the user only when missing information changes the PPT's purpose, audience, or confidentiality.

Before creating a deck for a new scenario, compare the request with [references/slide-plan-examples.md](references/slide-plan-examples.md) and reuse the closest decision pattern.

## Design Direction Checkpoint

The user should be able to choose a meaningful visual direction before production. After inspecting the source, show at most 3 distinct options tailored to this deck; recommend one. Each option must explain the visible hierarchy and page compositions, not merely color names or mood adjectives. Ask one concise question and wait for the answer. Then write the plan and produce the deck without another style-approval checkpoint.

Use this short format:

> 我看了课件内容，建议从这几个方向里选：
> **A · [方向]（推荐）**：[页面层级与典型构图]，适合[本课件的原因]。
> **B · [方向]**：[不同的层级与构图]，适合[原因]。
> **C · [方向]**：[明显不同的呈现]，适合[原因]。
> 你选 A、B、C，或告诉我想混合哪两种？

Base each option on the audience, purpose, density and supplied visual material. In a PPT conversion, make the original content and imagery part of the recommendation. Carry forward a visual preference the user has explicitly stated in the current request. If the user says to decide and proceed, choose the strongest fit and state the assumption. A request that already specifies a concrete design direction counts as the choice and does not need reconfirmation.

## Project Folder and File Organization

Every deck must be saved inside a dedicated project folder under the current PPT workspace. Do not leave generated PPTX, slide-plan JSON, or generation scripts loose in the workspace root.

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
```

Rules:

- `generate.js` and any helper scripts for this deck belong in the project folder.
- `slide-plan.json` belongs in the project folder.
- PPTX exports belong in `output/`. User-requested PDF exports also belong there.
- Only when the user explicitly requests preview images, save them in `preview/<版本名>/`.
- Do not generate previews as a completion gate.
- Existing user-provided source files may stay where the user put them unless copying them into the project folder is necessary for reproducibility.
- Root-level generated files are allowed only for shared reusable assets or dependencies, not per-deck artifacts.

## Existing Deck Conversion

For re-theming a supplied deck, preserve every page’s substantive text, facts, qualifiers, quotes, images and order unless the user explicitly requests editing. Reorganize visible content without shortening it or moving omitted text only into notes. Read the source before planning. Preserve source image bytes and aspect ratios; do not recolor, crop or redraw them when the user says images must stay unchanged. Density targets guide organization, not deletion. Preserve page count by default; split only when authorized or necessary for readability and disclose the change.

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

Choose style by scenario, audience, material and use context. Scenario narrows suitable moods; it does not select a fixed template. Read [references/design-direction-and-rhythm.md](references/design-direction-and-rhythm.md) on every deck task. Do not automatically reuse the last deck’s composition or force a different style when the content calls for continuity.

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

## Content-Led Design Decisions

- Preserve brand identity through the approved assets, color roles, fonts and alignment discipline. Vary the composition, visual emphasis, whitespace and background treatment according to the chosen direction.
- For newly authored plans, add `designDirection`, `designRationale`, `motif` and `rhythm` to `deckBrief.styleProfile`; add `narrativeRole` and `visualFocus` to each slide alongside `layoutVariant`.
- Identify what the audience should notice first. A quotation, original photo, relationship diagram, important number, comparison or question may be the visual focus. Large typography alone is valid when it carries the message; never add filler imagery to satisfy a visual quota.
- Do not default every page to title + accent bar + equal rounded cards. Use cards for truly peer items; use linked steps for a process, aligned counterparts for a comparison and a scene/evidence-first composition for a story.
- Treat title coordinates below as a reference composition for standard content pages. Quote, hero, image and data pages may use different title positions while preserving readability and the brand/footer zones. Accent bars are optional, not a required brand signature.
- Reuse semantic content and brand helpers in generation code, but implement the planned `layoutVariant` and visual hierarchy. Merely changing a layout name or IP key while drawing the same grid does not satisfy the plan.
- Plan variation before generation. Keep the existing direct-delivery/no-post-generation-QA workflow; generate visual alternatives or previews only when requested.

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
- `designConstraints`: generation-time design guidance; not a validation gate

Slide object fields:

- `type`: one of the approved layout types
- `layoutVariant`: describe the actual composition, e.g. `question-with-ip`, `horizontal-steps`, `story-with-side-note`; type alone does not determine the drawing
- `intent`: what this slide must make the audience understand or feel
- `contentDensity`: `low`, `medium`, or `high`
- `colorRole`: dominant semantic color role
- `fontRole`: `warm`, `professional`, or `hybrid`
- `title`
- `payload`: layout-specific structured content
- `assetHint`: record `useTangzai` and `selectionReason` on every newly planned slide. If true, also provide a real catalog `tangzaiKey` and `placement` with `x`, `y`, `w`, `h` in inches, preserving the image aspect ratio. If false, state why omission suits the content or composition and omit key/placement.

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
- Every PPT task must consult the scene IP catalog and consider it during slide planning without requiring extra user prompting. Use IP only when its actual pose, expression and scene support the message and a suitable position exists.
- Do not impose a minimum, target count or percentage of IP slides. Zero IP slides is valid when no scene is suitable. Do not add filler IP or shrink useful content to fit it. Follow explicit user requests about IP usage.
- **Tangzai 禁用场景（硬性规则）**：
  - `cover` 封面：使用主图 + 大标题，**不放 tangzai**
  - `sectionDivider` 过渡页：不放 tangzai
  - `closing` 尾页：用 5 个单色球 shape 装饰（不要重复贴 tangzai.png）
  - 连续 2 张及以上 page 都用 tangzai → 改为间隔使用
  - 与 Logo 同侧时让出 logo 位置
- Use Tangzai only where it supports meaning. Do not decorate every slide.
- Required slide plan behavior: record a use/omit decision and reason for every slide. `designConstraints.minTangzaiSlides` is a legacy compatibility field: omit it in new plans or set it to 0; a positive minimum is only appropriate when explicitly requested by the user.
- Best Tangzai slide types: `agenda`, `quote`, `activity`, `caseStory`, `testimonial`, `summaryAction`, and selected low-density `cards` slides.
- Avoid Tangzai on `cover`, `sectionDivider`, dense `chart`, dense tables, and slides where it would compete with core text.
- Place Tangzai in a clear empty area: lower right, lower left, side margin beside text, or a dedicated illustration zone. Never overlap title, body text, charts, cards, footer, or logo.
- Use explicit image dimensions. Do not rely on default image sizing.
- **tangzai.png 是一个 4:1 横向长图（5 个汤圆排成一行）**，不是单球。尾页若要"5 球"装饰应画 shape 而不是贴图。
- Use [assets/tangzai-catalog.json](assets/tangzai-catalog.json) as the scene IP source. It contains real OSS URLs, poses, scene tags and original dimensions. Select from `assets`; entries in `unavailable` are old failed paths, not usable candidates.
- Retrieve the selected asset and inspect its appearance before placing it. An old successful status is not a current availability guarantee; current retrieval must succeed and produce an image.
- If retrieval fails, choose another accessible asset only when its pose still fits the meaning. Report unavailable assets briefly. Use `assets/tangzai.png` only as a disclosed fallback when appropriate scene assets cannot be retrieved; do not silently replace all chosen IP with the five-ball strip.
- Let IP support the question, action, emotion or result, with a reserved illustration area. Do not always reduce it to a tiny lower-right ornament. Prefer 2D/3D consistency within a section; vary poses according to meaning, not at random.

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
| Warm relationship or relaxed companionship on content pages | `leisure3d` |
| Work execution or team collaboration | `office` |
| Persistence or step-by-step challenge | `climb` |
| Time management with a 3D visual section | `time3d` |

## Design Constraints

Apply these rules while composing slides. They do not require a post-generation inspection:

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
- IP inclusion follows per-slide scene and composition fit, with no default minimum. Leave it out when it competes with evidence, text readability or the intended mood.
- Tangzai placement is meaningful and non-overlapping.

## Spacing & Layout Rules (CRITICAL)

Keep these safety principles for every composition; the coordinates below are reference values for conventional content pages, not a universal page skeleton.

### Title and Optional Accent Bar

- Choose title position and size from the narrative role, visual focus and content length. Do not mechanically place every title at the same coordinates.
- Standard content-page reference: `y: 0.85, h: 0.7` or `h: 0.9`; when a section label sits above it, `y: 1.0` can work. Other compositions may differ.
- Do not add an accent bar by default. If a meaningful divider is used, place it below the actual title bottom with at least 0.15 inch clearance; never calculate it from a fixed title height that the current slide does not use.
- Preserve all source text during re-theming; create hierarchy and space through grouping and layout rather than deletion.

### Image Box vs Source Ratio

**Read `references/pptxgenjs-gotchas.md` first.** PptxGenJS `sizing.cover` is **NOT** CSS `object-fit: cover` — it stretches.

- Teacher photo (0.667 source ratio): box must be `w/h = 0.667` (e.g., 3.4×5.1, 1.7×2.55)
- Never use `sizing.cover` for standalone portraits. Use it only for crop-within-card where the loss is acceptable.

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

PPTX generation success is the completion condition. Provide the generated PPTX link immediately and say:

> PPT生成好了，你自己检查一下。

Do not perform or require post-generation text extraction, schema validation, PDF/image rendering, visual QA, boundary/overlap checks, image-ratio validation, or Tangzai counting. Do not delay delivery for any inspection. The layout, font, color, and asset rules above guide generation only.

If generation fails, resolve the generation error or report it accurately; do not say a file was generated when it was not. Export PDF or preview images only when the user explicitly requests those files.
