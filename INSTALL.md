# Wuren PPT V2 — 安装指令

> 一句话：**跟 AI 助手说「帮我安装 https://gitee.com/david0077/wuren-PPT-skills-v2.git 这个 skill」，或者自己跑一条命令 `git clone https://gitee.com/david0077/wuren-PPT-skills-v2.git && bash wuren-PPT-skills-v2/install.sh`。**

---

## 一句话指令（念给 AI 助手听）

> 帮我安装 wuren-PPT-skills-v2 这个 skill。仓库地址是 https://gitee.com/david0077/wuren-PPT-skills-v2.git 。请克隆到我的 ~/.skillshub/wuren-PPT-skills-v2，然后运行里面的 install.sh，它会在 .claude、.codex、.agents、.cursor、.trae、.hermes、.pi、.qoder-cn、.qoderworkcn、.qwenworkcn、.workbuddy 这 11 个目录的 skills 子目录里各建一个指向它的软链。已经存在的软链跳过，真实目录绝对不要覆盖。装完把输出贴给我。

助手如果不确定，也可以让它直接照下面「手动安装」做。

---

## 手动安装

### macOS / Linux

```bash
git clone https://gitee.com/david0077/wuren-PPT-skills-v2.git ~/.skillshub/wuren-PPT-skills-v2
bash ~/.skillshub/wuren-PPT-skills-v2/install.sh
```

`install.sh` 会做三件事：建 11 个软链、`npm install` 装 PptxGenJS、检查 python-pptx。**可重复执行** —— 已正确的软链会跳过，指向错的会自动修，遇到真实目录会跳过并提示人工处理，绝不覆盖。

常用参数：

```bash
bash install.sh --no-deps    # 跳过依赖安装（离线或已装好时）
bash install.sh --dir <路径>  # 目录已下载好，只做链接和依赖
```

### Windows（PowerShell）

```powershell
git clone https://gitee.com/david0077/wuren-PPT-skills-v2.git $HOME\.skillshub\wuren-PPT-skills-v2
powershell -ExecutionPolicy Bypass -File $HOME\.skillshub\wuren-PPT-skills-v2\install.ps1
```

**前置条件**：Windows 建软链需要开启「开发者模式」（设置 → 系统 → 开发者选项），或用管理员身份运行终端。脚本遇到权限问题会明确提示并跳过，不影响其他助手。

---

## 准备清单

| 项目 | 要求 | 说明 |
|---|---|---|
| Git | 已安装 | macOS 可用 Xcode 命令行工具；Windows 装 Git for Windows |
| Node.js + npm | 建议 | 生成 PPTX 用 PptxGenJS。没有它只能做 QA，不能生成 |
| Python 3 + pip | 建议 | `qa.py` 质量检查用 python-pptx |
| 网络 | 能访问 gitee.com | 公开仓库，免密 |

依赖装不上也不影响 skill 被加载 —— 缺依赖时脚本会提示具体命令，skill 仍可正常读取，只是生成/质检环节会受限。

---

## 装完怎么用

重启 AI 助手（多数助手只在启动时扫描 skills 目录），然后直接说需求，比如：

- 「帮我做一份全国老师 AI 提效赋能培训的 PPT」
- 「把这份 ppt 检查一下排版有没有越界」
- 「给家长会做个宣讲 PPT，20 页以内」

助手会按 skill 里的规则工作：先出 `deckBrief` 和 `slidePlan`，再按场景选视觉体系和版式，生成后渲染成图做质检。

### 支持的教育场景

内部伙伴培训、学员课堂课件、家长宣讲、结营汇报、工作汇报、年终总结、招商提案、招生招募、大会主题分享、知识分享。

### 视觉体系

武润品牌色板与 11 类场景的风格矩阵都在 `references/scenario-style-matrix.md`，字体、logo 位置、汤圆形象的使用规则写死在 `SKILL.md` 里，不需要额外配置。

---

## 更新

```bash
bash ~/.skillshub/wuren-PPT-skills-v2/install.sh
```

直接重跑安装脚本即可：它检测到源目录是 git 仓库会先 `git pull --ff-only` 拉最新，再刷新软链。有本地改动时会提示拉取失败并继续用本地版本，不会丢东西。

Windows 把上面命令换成 `install.ps1` 的那条。

---

## 故障排查

| 现象 | 原因与处理 |
|---|---|
| 助手里看不到这个 skill | 助手只在启动时扫描 skills 目录，**装完必须重启助手** |
| 重启后仍提示找不到 | 极少数助手按 frontmatter 里的 `name` 查找。该字段已与目录名统一为 `wuren-PPT-skills-v2`，若仍失败请贴报错原文 |
| 装完说「找不到 wuren-PPT-skills-v2」但目录确实存在 | 助手缓存了旧的 skill 名册（改名前叫 `wuren-ppt-v2`），彻底退出重开助手进程 |
| `npm: command not found` | 没装 Node.js。生成 PPTX 需要 PptxGenJS |
| `ModuleNotFoundError: pptx` | 跑 `pip3 install python-pptx`，或 `bash install.sh` 会提示 |
| Windows 链接失败 | 开开发者模式，或用管理员身份运行 PowerShell |
| 软链指向了错误位置 | 重跑 `install.sh`，会自动修复 |
| 目标位置是真实目录 | 脚本会跳过并提示，确认无用可手动删掉该目录后重跑 |
| 生成 PPT 时报图片尺寸错 | 见 `references/pptxgenjs-gotchas.md`，PptxGenJS 的 `sizing.cover` 不是 CSS 的 object-fit |

## 卸载

```bash
for dir in ~/.claude ~/.codex ~/.agents ~/.cursor ~/.trae ~/.hermes ~/.pi \
           ~/.qoder-cn ~/.qoderworkcn ~/.qwenworkcn ~/.workbuddy; do
  link="$dir/skills/wuren-PPT-skills-v2"
  [ -L "$link" ] && rm "$link" && echo "已删除软链: $link"
done
rm -rf ~/.skillshub/wuren-PPT-skills-v2
```

`[ -L ]` 只匹配软链，不会误删真实目录。
