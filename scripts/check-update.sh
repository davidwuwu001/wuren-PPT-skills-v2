#!/usr/bin/env bash
set -euo pipefail

SKILL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LOCAL_VERSION="$(cat "$SKILL_DIR/VERSION" 2>/dev/null || echo '0.0.0')"
REMOTE_URL="https://skill.wrtyj.cn/ppt/version.txt"

echo "当前版本: $LOCAL_VERSION"
echo "检查更新: $REMOTE_URL"

REMOTE_VERSION="$(curl -fsSL --connect-timeout 5 --max-time 10 "$REMOTE_URL" 2>/dev/null || echo '')"
if [ -z "$REMOTE_VERSION" ]; then
  echo "无法获取云端版本，请稍后再试"
  exit 0
fi
echo "云端版本: $REMOTE_VERSION"

if [ "$LOCAL_VERSION" = "$REMOTE_VERSION" ]; then
  echo "已是最新版本"
  exit 0
fi

echo ""
echo "发现新版本: $REMOTE_VERSION（当前 $LOCAL_VERSION）"
read -r -p "是否现在更新? [y/N] " confirm
if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
  echo "已取消"
  exit 0
fi

UPDATE_URL="https://skill.wrtyj.cn/ppt/install.sh"
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
curl -fsSL "$UPDATE_URL" -o "$TMP/update.sh"
bash "$TMP/update.sh"
echo ""
echo "更新完成，请重启 AI Agent 后使用"
