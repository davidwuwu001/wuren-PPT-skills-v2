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
  "qualityBar": {
    "maxBodyCharsLowDensity": 60,
    "minMarginInches": 0.5,
    "logoRequired": true,
    "renderRequired": true
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

