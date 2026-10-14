# IP 选图与内容构图

## 生成前的选择顺序

1. 每次制作 PPT 都读取素材索引，不依赖用户额外提醒。逐页读全部内容，判断它是在提问、解释、呈现证据、练习，还是表达情绪与结果，并评估画面是否有合适的位置。
2. 同时满足“形象与内容场景相符”和“画面可容纳且不干扰阅读”才使用 IP。需要使用时，从 `assets/tangzai-catalog.json` 的可用 `assets` 选图；不满足时不插。不要从旧脚本猜文件名或添加未核实的地址。
3. 下载本次选中的素材到当前课件项目 `assets/`，看实际形象再确定选图；不要只看 key 名称。根据原图宽高计算尺寸，不拉伸、不裁剪。
4. 每页在 `slidePlan` 写出 `layoutVariant`、`assetHint.useTangzai` 与 `selectionReason`。使用时再写 `tangzaiKey` 和 `placement`；不使用时写省略理由，不填写素材键或坐标。不要设最低页数或比例；整份不适合时可以完全不插 IP。给合适的 IP 留出空间，选择与文字的关系，再落坐标。
5. 生成脚本读取这些字段。不同 key 必须解析到对应文件，禁止把所有 IP 都映射到同一张 `tangzai.png`。

## 品牌统一，构图随内容变化

统一品牌色、字体角色、Logo 与安全边距；允许文字区域、图片区域、信息流向和留白随页面目的变化。不要为了显得不同随机换色或随意换 IP。

| 内容信号 | 构图示例 | IP 如何参与 |
|---|---|---|
| 开场提问、反思 | 左侧问题，右侧思考区；或大问题居中，IP 在旁 | `think` 与问题相邻，像在一起思考 |
| 方法学习、概念解释 | 主概念＋展开说明；横向步骤；图解＋旁注 | `study` 配合学习区，步骤页按含义选 `time` |
| 平级观点 | 列表、分栏、关系图或卡片 | 只有明确支持观点时使用，卡片不是默认答案 |
| 孩子兴趣与需要探索 | 线索→假设→核实；探索路径；故事＋观察旁注 | `explore` 呼应发现与探索 |
| 孩子原话、关系体验 | 大引语＋留白；对话式分区 | 根据实际情绪选图；讨论可用 `think`，轻松陪伴可用 `leisure3d` |
| 进步、完成与信心 | 结果大字＋证据；变化前后；行动落点 | `cheer` 呼应完成，`superhero` 呼应力量，`climb` 呼应坚持 |
| 现场练习 | 任务区＋讨论区；问题清单＋IP | `think` 或 `study`，给作答内容留空间 |
| 图表与原始插图 | 证据主体＋简短标注 | 默认不放 IP，避免挤占证据 |

同一 layout type 可以采用不同构图。`cards` 不强制二维卡片网格；`timeline` 必须表达顺序或过程，不能直接画成无关联卡片。连续页面不要机械复用同一种构图；内容确实一致时可维持有意的系列节奏。封面、过渡页与尾页遵守主技能的 IP 禁用规则。

## 最小执行示例

下面只示范“计划的 key → 实际 OSS 图 → 计划坐标”。在课件项目的生成代码里使用标准 `fetch` 和已安装的 PptxGenJS，不需要添加下载依赖。对当前计划选中的素材分别读取；出错时按主技能规则换用合适的可用素材，不能静默换成群像。

```js
const catalog = JSON.parse(fs.readFileSync(catalogPath, 'utf8'));
const hint = slidePlan.assetHint;
if (hint.useTangzai) {
const asset = catalog.assets[hint.tangzaiKey];
if (!asset) throw new Error(`Unknown IP key: ${hint.tangzaiKey}`);
const response = await fetch(asset.url);
if (!response.ok) throw new Error(`IP retrieval failed: ${response.status}`);
const bytes = Buffer.from(await response.arrayBuffer());
// 生成前确认下载结果是图片并查看实际形象；placement 按原图比例制定。
const filePath = path.join(projectAssets, asset.filename);
fs.writeFileSync(filePath, bytes);
slide.addImage({ path: filePath, ...hint.placement });
}
```

## 不可用地址

索引里的 `unavailable` 仅记录旧地址的检查结果，不代表对应 IP 从 OSS 全部删除。文件可能更名或迁移；只有通过已有目录或用户提供的准确地址找到资源后才更新索引，不猜路径、不擅自重新上传。
