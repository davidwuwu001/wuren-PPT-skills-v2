# PptxGenJS 行为陷阱（GOTCHAS）

在 wuren-PPT 制作中**最常踩坑**的 PptxGenJS 4.x 行为差异。**在写脚本前先读这一页**。

## 1. `sizing.cover` ≠ CSS `object-fit: cover`

**PptxGenJS 的 `sizing.type: 'cover'` 实际行为是"拉伸图片到指定 w/h"**，不是裁剪。

```js
// ❌ 错误：原图 0.67 比例会被强制拉伸到 3.8x5.0（0.76 比例）→ 人物被拉扁
s.addImage({
  path: 'teacher.jpg', x: 0.6, y: 1.7, w: 3.8, h: 5.0,
  sizing: { type: 'cover', w: 3.8, h: 5.0 },
  rounding: true,
});
```

**正确做法 1（推荐）**：让图片框的 `w/h` 等于原图比例。

```js
// 原图 3744x5616，比例 0.667
// 想要 3.4 宽 → 高度 = 3.4 / 0.667 ≈ 5.1
s.addImage({
  path: 'teacher.jpg', x: 0.8, y: 1.5, w: 3.4, h: 5.1,
  rounding: true,  // 直接加 rounding，图片按原图比例缩放
});
```

**正确做法 2**：需要裁剪时用 `sizing.type: 'crop'` + 显式 x/y 偏移。

```js
// 把原图顶部 0.5 inch 裁掉（避免头顶）
s.addImage({
  path: 'teacher.jpg', x: 0.8, y: 1.5, w: 3.4, h: 5.1,
  sizing: { type: 'crop', x: 0, y: 0.5, w: 3.4, h: 5.1 },
});
```

**正确做法 3**：在卡片里允许裁剪用 `sizing.type: 'cover'` 也可以，但**前提是图片框比例与原图差异不大**（如 1:1 vs 0.67 裁切，丢掉一些背景 OK）。

## 2. 获取原图比例的脚本

写脚本前用 Python 一次性拿到所有图片的宽高比：

```python
from PIL import Image
import os, json

# 替换为你的素材目录
BASE = '/path/to/photos'

result = {}
for root, _, files in os.walk(BASE):
    for f in files:
        if f.lower().endswith(('.jpg', '.jpeg', '.png')):
            p = os.path.join(root, f)
            with Image.open(p) as im:
                w, h = im.size
                result[f] = {'w': w, 'h': h, 'ratio': round(w/h, 3)}

# 按比例排序
for f, info in sorted(result.items(), key=lambda x: x[1]['ratio']):
    print(f"{info['ratio']:>6.3f}  {f}")
```

输出示例：

```
  0.456  IMG_1771.png       # 竖向长截图（好评/聊天）
  0.667  老师照片/李华昌.jpg  # 老师大头照（标准）
  0.706  蓝色简洁简历.png     # 简历模板
  2.700  wurenlogo_1.png    # logo（横长）
  4.050  tangzai.png        # tangzai 装饰（一行 5 球）
```

## 3. 老师大头照的"安全框"推荐尺寸

12 张老师照片统一为 3744×5616（0.667）。

| 用途 | 推荐 w×h (in) | 比例 | 备注 |
|------|---------------|------|------|
| 封面全身 / 半身 | 3.5 × 5.25 | 0.667 | 不裁切 |
| 内页大图 | 3.4 × 5.1 | 0.667 | 不裁切 |
| 团队卡 4 张 | 2.4 × 1.7 | 1.412 | 大量裁切 OK（保留中间人像）|
| 伙伴画像 4 张 | 1.7 × 1.9 | 0.895 | 适度裁切 |
| 头像小圆 | 1.0 × 1.0 | 1.000 | 大量裁切 OK |

## 4. 圆角 + cover 的组合

`rounding: true` + `sizing.cover` 拉伸 = **拉歪后再被圆角裁剪** → 更糟。

正确：保持原图比例 + `rounding: true`（圆角对原图起作用，效果干净）。

## 5. 其他常见坑

| 现象 | 原因 | 解决 |
|------|------|------|
| 文字显示为衬线/默认字体 | 没设 `fontFace` | 每段 text 必须指定 `fontFace: 'Yuanti SC'` 或 `'PingFang SC'` |
| 圆角矩形看起来像直角 | `rectRadius` 太大或太小 | 卡片推荐 `0.08-0.15`，标签推荐 `0.22` |
| 透明 shape 露出背景 | `transparency` 单位是 %，不是 0-1 | `transparency: 30` = 30% 透明 |
| 形状 z-order 反了 | 后加的在上面 | 同页内元素添加顺序就是 z-order，重叠时调整 |
| PNG 透明背景变成白色 | LibreOffice 渲染 | 不要紧，PPTX 客户端（PowerPoint）会保持透明 |
| logo 模糊 | 用了 `wurenlogo_1.png` 但需要浅色 | 浅底用 `wurenlogo_2.png`，深底用 `wurenlogo_1.png` |
| tangzai 重复使用 | 没规划"哪些页用 tangzai" | 见 SKILL.md Tangzai 章节规则 |

## 6. 验证清单

写完脚本后用这段快速验证图片是否变形：

```bash
# 用 python-pptx 提取每张图片的显示尺寸，与原图比较
python3 -c "
from pptx import Presentation
from PIL import Image
import os
p = Presentation('output.pptx')
for i, s in enumerate(p.slides, 1):
    for sh in s.shapes:
        if sh.shape_type == 13:  # PICTURE
            # 显示尺寸（EMU → inches）
            disp_w = sh.width / 914400
            disp_h = sh.height / 914400
            disp_ratio = disp_w / disp_h
            # 原图比例
            try:
                with Image.open(sh.image.filename if hasattr(sh.image,'filename') else '') as im:
                    src_ratio = im.size[0] / im.size[1]
                if abs(disp_ratio - src_ratio) > 0.05:
                    print(f'  ⚠ slide {i}: {os.path.basename(sh.image.filename)} 显示 {disp_ratio:.2f} vs 原图 {src_ratio:.2f}')
            except: pass
"
```
