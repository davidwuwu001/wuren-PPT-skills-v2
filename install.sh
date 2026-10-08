#!/usr/bin/env bash
# wuren-PPT-skills-v2 一键安装：克隆仓库、建软链、装依赖。
# 可重复执行，不会覆盖已有内容。
#
#   bash install.sh                    # 安装到 ~/.skillshub 并链接到各 AI 助手
#   bash install.sh --no-deps          # 跳过依赖安装（离线或已装好时用）
#   bash install.sh --dir /path/to/repo # 已在目标目录时，跳过克隆只做链接

set -u

SKILL_NAME="wuren-PPT-skills-v2"
REPO_URL="${WUREN_PPT_REPO:-https://gitee.com/david0077/wuren-PPT-skills-v2.git}"
SOURCE_DIR="$HOME/.skillshub/$SKILL_NAME"
SKIP_DEPS=0
CLONE_DIR=""

while [ $# -gt 0 ]; do
  case "$1" in
    --no-deps) SKIP_DEPS=1; shift ;;
    --dir) CLONE_DIR="${2:-}"; shift 2 ;;
    -h|--help) sed -n '2,8p' "$0"; exit 0 ;;
    *) echo "未知参数: $1" >&2; exit 2 ;;
  esac
done

AGENT_DIRS="
$HOME/.claude/skills
$HOME/.codex/skills
$HOME/.agents/skills
$HOME/.cursor/skills
$HOME/.trae/skills
$HOME/.hermes/skills
$HOME/.pi/skills
$HOME/.qoder-cn/skills
$HOME/.qoderworkcn/skills
$HOME/.qwenworkcn/skills
$HOME/.workbuddy/skills
"

link_count=0
skipped_count=0

link_skill() {
  target_dir="$1"
  mkdir -p "$target_dir" 2>/dev/null || return 0
  link="$target_dir/$SKILL_NAME"
  if [ -L "$link" ]; then
    # 软链已存在：指向正确就跳过，指向错误就修
    current="$(readlink "$link")"
    if [ "$current" = "$SOURCE_DIR" ]; then
      echo "  已正确链接，跳过: $link"
      skipped_count=$((skipped_count + 1))
    else
      rm "$link" && ln -s "$SOURCE_DIR" "$link" \
        && echo "  已修复失效链接: $link" && link_count=$((link_count + 1)) || true
    fi
  elif [ -e "$link" ]; then
    # 真实目录：绝不覆盖，交给人处理
    echo "  跳过真实目录（需人工确认）: $link"
    skipped_count=$((skipped_count + 1))
  else
    ln -s "$SOURCE_DIR" "$link" 2>/dev/null \
      && echo "  已链接: $link" && link_count=$((link_count + 1)) \
      || echo "  链接失败: $link"
  fi
}

echo "==> 1/3 获取 skill 源"
if [ -n "$CLONE_DIR" ]; then
  SOURCE_DIR="$CLONE_DIR"
  echo "  使用已有目录: $SOURCE_DIR"
elif [ -d "$SOURCE_DIR/.git" ]; then
  echo "  已存在 git 仓库，跳过克隆: $SOURCE_DIR"
  git -C "$SOURCE_DIR" pull --ff-only 2>&1 | sed 's/^/  /' || echo "  拉取失败，继续用本地版本"
else
  mkdir -p "$HOME/.skillshub"
  git clone "$REPO_URL" "$SOURCE_DIR" 2>&1 | sed 's/^/  /' \
    || { echo "克隆失败，请检查网络或手动下载后用 --dir 指定目录" >&2; exit 1; }
fi

if [ ! -f "$SOURCE_DIR/SKILL.md" ]; then
  echo "错误: $SOURCE_DIR 下没有 SKILL.md，不是有效的 skill 目录" >&2
  exit 1
fi

echo "==> 2/3 链接到各 AI 助手"
for dir in $AGENT_DIRS; do
  link_skill "$dir"
done

echo "==> 3/3 运行时依赖"
if [ "$SKIP_DEPS" = "1" ]; then
  echo "  已按参数跳过"
else
  if command -v npm >/dev/null 2>&1; then
    if (cd "$SOURCE_DIR" && npm install --silent --no-audit --no-fund 2>&1 | sed 's/^/  /'); then
      echo "  PptxGenJS 已就绪"
    else
      echo "  npm install 失败；生成 PPTX 时需要 PptxGenJS，请手动在该目录执行 npm install"
    fi
  else
    echo "  未找到 npm，跳过 PptxGenJS 安装（生成 PPTX 时需要）"
  fi
  if command -v python3 >/dev/null 2>&1; then
    if python3 -c "import pptx" >/dev/null 2>&1; then
      echo "  python-pptx 已就绪"
    else
      echo "  提示: qa.py 需要 python-pptx，可执行 pip3 install python-pptx"
    fi
  fi
fi

echo
echo "安装完成。"
echo "  源目录: $SOURCE_DIR"
echo "  新建/修复链接: $link_count   已存在跳过: $skipped_count"
echo "  重启 AI 助手后即可用「${SKILL_NAME}」这个 skill。"
echo "  详细说明见 ${SOURCE_DIR}/INSTALL.md"
