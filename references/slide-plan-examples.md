# Slide Plan Examples

Use these as shape references. Do not copy the content blindly; copy the decision pattern.

## Example 1: Internal Partner Training

User says: "做一份成长营顾问赋能培训 PPT，教顾问怎么做家长面谈。"

```json
{
  "deckBrief": {
    "purpose": "Train consultants to conduct parent interviews with a consistent method.",
    "scenario": "internal_training",
    "audience": "成长营顾问",
    "tone": "practical",
    "styleProfile": {
      "fontStrategy": "hybrid",
      "colorStrategy": "purple structure, blue method pages, orange action checklist",
      "layoutDensity": "medium"
    },
    "assumptions": ["用户未给页数，默认 12-16 页。"]
  },
  "slides": [
    {
      "type": "cover",
      "intent": "建立培训主题和专业感",
      "contentDensity": "low",
      "colorRole": "brand",
      "fontRole": "hybrid",
      "title": "家长面谈顾问赋能",
      "payload": {
        "subtitle": "从听见问题到形成信任"
      }
    },
    {
      "type": "compare",
      "intent": "让顾问理解普通聊天与专业面谈的差异",
      "contentDensity": "medium",
      "colorRole": "learning",
      "fontRole": "professional",
      "title": "面谈不是问答，而是建立判断",
      "payload": {
        "leftTitle": "普通聊天",
        "rightTitle": "专业面谈",
        "points": ["目标不同", "追问方式不同", "输出结果不同"]
      }
    },
    {
      "type": "summaryAction",
      "intent": "形成可执行清单",
      "contentDensity": "medium",
      "colorRole": "action",
      "fontRole": "professional",
      "title": "下一次面谈，请带着这 4 个动作",
      "payload": {
        "actions": ["先共情", "再澄清", "找证据", "给下一步"]
      }
    }
  ],
  "designConstraints": {
    "maxBodyCharsLowDensity": 60,
    "minMarginInches": 0.5,
    "logoRequired": true,
    "minTangzaiSlides": 0
  }
}
```

## Example 2: Student Lesson

User says: "做一份面向学生的爱情课工作坊 PPT。"

Decision:

- Scenario: `student_lesson`
- Tone: `warm`
- Font: `Yuanti SC`
- Density: `low`
- More `activity`, `quote`, `caseStory`; avoid report charts.

Recommended slide rhythm:

1. `cover`: topic and safe atmosphere
2. `quote`: one question that opens curiosity
3. `activity`: quick self-check or discussion
4. `caseStory`: relatable student situation
5. `compare`: healthy vs unhealthy relationship signals
6. `cards`: 3 principles
7. `activity`: scenario choice
8. `summaryAction`: what to remember and do

## Example 3: Parent Talk

User says: "做一份家长宣讲，讲孩子学习动力不足怎么办。"

Decision:

- Scenario: `parent_talk`
- Tone: `warm`
- Font: `Yuanti SC`
- Density: `low`
- Color: warm purple + soft yellow insight + blue proof.

Recommended slide rhythm:

1. `cover`: parent-facing promise
2. `quote`: "孩子不是不想好，而是暂时找不到力气"
3. `compare`: 表面问题 vs 底层原因
4. `caseStory`: 一个家庭沟通场景
5. `cards`: 三个可观察信号
6. `timeline`: 从理解到行动的陪伴路径
7. `testimonial`: parent/student voice if available
8. `summaryAction`: tonight's first small step

## Example 4: Leadership Report

User says: "做人事部年终总结和明年规划。"

Decision:

- Scenario: `annual_summary`
- Tone: `executive`
- Font: `PingFang SC`
- Density: `medium` or `high`
- Color: blue achievements, orange gaps, yellow future plans.

Recommended slide rhythm:

1. `cover`: department and year
2. `bigNumber`: annual headline metrics
3. `cards`: three achievements
4. `chart`: key data changes
5. `compare`: goal vs actual / issue vs cause
6. `timeline`: next-year plan
7. `summaryAction`: decisions or resources needed


## Example 5: Same Brand, Content-Led IP Selection

For teacher training on child relationships, retain every source page’s content during re-theming. A discussion page can use this composition; the same section’s method page should use a different learning or process composition, rather than another identical card grid.

```json
{
  "type": "activity",
  "layoutVariant": "question-left-ip-right",
  "intent": "引导老师依据具体事实讨论孩子需要",
  "contentDensity": "low",
  "colorRole": "emotion",
  "fontRole": "warm",
  "title": "这个孩子此刻最需要什么？",
  "payload": {
    "questions": ["你观察到了什么？", "你的依据是什么？"]
  },
  "assetHint": {
    "useTangzai": true,
    "tangzaiKey": "think",
    "selectionReason": "汤仔抱胸歪头思考，与这一页的推测和讨论任务相符。",
    "placement": {"x": 10.2, "y": 3.0, "w": 1.2, "h": 2.198757763975155}
  }
}
```

The existing shorter examples show decision patterns only. New complete plans must include `layoutVariant` for every slide and explicit IP selection/placement fields for IP slides. Use `assets/tangzai-catalog.json` to resolve keys to actual files. A method-learning page may choose `study` with a learning illustration area; a strength or breakthrough page may choose `superhero` with a result composition. Do not put the same five-ball strip into all three pages.


## Example 6: Assess IP, Then Intentionally Omit It

A slide showing original evidence or a dense chart can omit IP when no pose adds useful meaning or the image would compete with the evidence. This is an intentional per-slide decision, not a failure to load the catalog. An entire deck can omit IP if the same assessment applies throughout.

```json
{
  "type": "caseStory",
  "layoutVariant": "original-evidence-image",
  "intent": "完整展示案例的现场手写记录",
  "contentDensity": "medium",
  "colorRole": "proof",
  "fontRole": "professional",
  "title": "现场梳理记录",
  "payload": { "imageNeed": "沿用用户原图，保持比例完整展示" },
  "assetHint": {
    "useTangzai": false,
    "selectionReason": "原始记录是画面重点；额外 IP 会挤占图片阅读空间，且不增加有效信息。"
  }
}
```

## Example 7: Direction and Rhythm Before Drawing

For a new teacher-training deck, the following fragment shows concrete design decisions. Expand the original examples with these fields for newly authored plans. Older plans remain readable; do not rewrite archived decks just to add fields.

```json
{
  "deckBrief": {
    "purpose": "训练老师基于事实识别孩子需要",
    "scenario": "internal_training",
    "audience": "住家老师与顾问",
    "tone": "practical",
    "styleProfile": {
      "fontStrategy": "hybrid",
      "colorStrategy": "白底与品牌紫标题，蓝色用于方法关系",
      "layoutDensity": "medium",
      "designDirection": "以孩子原话与观察线索展开的清晰推演",
      "designRationale": "重点是建立判断方法，选用问题与关系图推进；避免把训练内容全部处理为情感海报。",
      "motif": "线索、假设与核实的连接关系",
      "rhythm": "先用问题聚焦，再用浅底流程展开；遇到案例原图时让证据成为主角。"
    },
    "assumptions": ["此示例为新课件内容；转换现有课件时保留原文、顺序及原图。"]
  },
  "slides": [
    {
      "type": "activity",
      "intent": "让老师区分观察到的事实与推测",
      "narrativeRole": "提问与思考",
      "visualFocus": "你看到了什么，哪些只是你的猜测？",
      "layoutVariant": "large-question-with-side-ip",
      "contentDensity": "low",
      "colorRole": "insight",
      "fontRole": "warm",
      "title": "你看到了什么，哪些只是你的猜测？",
      "payload": {"questions": ["先说事实，再说推测。"]},
      "assetHint": {
        "useTangzai": true,
        "tangzaiKey": "think",
        "selectionReason": "思考姿态呼应辨别事实的任务，问题侧边有明确的插图区。",
        "placement": {"x": 10.2, "y": 3.0, "w": 1.2, "h": 2.198757763975155}
      }
    },
    {
      "type": "timeline",
      "intent": "建立可以重复练习的判断过程",
      "narrativeRole": "方法展开",
      "visualFocus": "从事实到假设再到核实的顺序关系",
      "layoutVariant": "connected-horizontal-steps-with-annotations",
      "contentDensity": "medium",
      "colorRole": "learning",
      "fontRole": "professional",
      "title": "让判断回到孩子的反馈里",
      "payload": {"steps": ["记录具体事实", "提出需要假设", "向孩子核实"]},
      "assetHint": {
        "useTangzai": false,
        "selectionReason": "步骤连接是主体，IP没有额外解释价值；为文字与流程保留空间。"
      }
    }
  ],
  "designConstraints": {
    "maxBodyCharsLowDensity": 60,
    "minMarginInches": 0.5,
    "logoRequired": true
  }
}
```
