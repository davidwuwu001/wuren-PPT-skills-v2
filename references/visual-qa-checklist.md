# Visual QA Checklist for Wuren PPT

Run this checklist **before declaring a deck complete**. Each item is something that previously slipped through manual review.

## Pre-render (script side)

- [ ] 图片框 w/h = 原图比例 — 老师照源比例 0.667，框必须是 0.667
- [ ] 没有 `sizing.cover` 拉伸人像 — `grep -n "sizing.*cover" generate.js` 后逐一审视
- [ ] Tangzai 计数 = 3-5 张 — 不要在 cover / sectionDivider / closing 上用
- [ ] Logo 路径正确 — 深底用 `wurenlogo_1.png`，浅底用 `wurenlogo_2.png`
- [ ] 每个 text shape 都有 `fontFace` — 否则会渲染为宋体/Arial
- [ ] accent bar 位于标题底 + 0.15 inch — 不要穿标题字

## Post-render (视觉侧)

- [ ] 没有图片被拉扁/拉歪
- [ ] 没有装饰条/线穿过文字
- [ ] 没有两张连续页用相同的 tangzai 装饰
- [ ] 没有文字与底部页码 (12.0, 7.05) 重叠
- [ ] 没有文字与右上角 logo (11.5, 0.2) 重叠
- [ ] 没有文字溢出页边 (slide 是 13.33 x 7.5 inch)
- [ ] 同色块在相邻页不撞色
- [ ] 标题字号在浅底页 >= 28pt，深底页可 32-48pt
- [ ] 底色 + 文字色对比度 — 深紫底用白字，浅紫底用深紫字
- [ ] 圆角卡片 radius 风格统一 — 推荐 0.08-0.15

## 自动化检查

```bash
python3 scripts/qa.py output.pptx
```

输出示例：

```
=== deck.pptx ===
  15 slides, 13.33 x 7.50 inch
[slide 3]
  accent bar (y=1.40) may overlap title bottom (y=1.75)
[slide 12]
  image stretched: display 0.76 vs source 0.67
[slide 7]
  tangzai used 3 consecutive slides
Found 3 issue(s).
```
