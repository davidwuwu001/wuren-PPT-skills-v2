# wuren-PPT-skills-v2 一键安装（Windows PowerShell）
# 可重复执行，不会覆盖已有内容。
#
#   .\install.ps1                # 安装并链接到各 AI 助手
#   .\install.ps1 -NoDeps        # 跳过依赖安装
#   powershell -ExecutionPolicy Bypass -File .\install.ps1

param(
  [switch]$NoDeps,
  [string]$Dir = "",
  [string]$RepoUrl = $(if ($env:WUREN_PPT_REPO) { $env:WUREN_PPT_REPO } else { "https://gitee.com/david0077/wuren-PPT-skills-v2.git" })
)

$ErrorActionPreference = "Continue"
$SkillName = "wuren-PPT-skills-v2"
$SourceDir = if ($Dir) { $Dir } else { Join-Path $HOME ".skillshub\$SkillName" }

$AgentDirs = @(
  "$HOME\.claude\skills", "$HOME\.codex\skills", "$HOME\.agents\skills",
  "$HOME\.cursor\skills", "$HOME\.trae\skills", "$HOME\.hermes\skills",
  "$HOME\.pi\skills", "$HOME\.qoder-cn\skills", "$HOME\.qoderworkcn\skills",
  "$HOME\.qwenworkcn\skills", "$HOME\.workbuddy\skills"
)

$linked = 0; $skipped = 0

Write-Host "==> 1/3 获取 skill 源"
if ($Dir) {
  Write-Host "  使用已有目录: $SourceDir"
} elseif (Test-Path (Join-Path $SourceDir ".git")) {
  Write-Host "  已存在 git 仓库，尝试更新"
  git -C $SourceDir pull --ff-only 2>&1 | ForEach-Object { Write-Host "  $_" }
} else {
  New-Item -ItemType Directory -Force -Path (Join-Path $HOME ".skillshub") | Out-Null
  git clone $RepoUrl $SourceDir 2>&1 | ForEach-Object { Write-Host "  $_" }
  if (-not (Test-Path $SourceDir)) { Write-Host "克隆失败，请检查网络" -ForegroundColor Red; exit 1 }
}

if (-not (Test-Path (Join-Path $SourceDir "SKILL.md"))) {
  Write-Host "错误: $SourceDir 下没有 SKILL.md，不是有效的 skill 目录" -ForegroundColor Red
  exit 1
}

Write-Host "==> 2/3 链接到各 AI 助手"
foreach ($dir in $AgentDirs) {
  try { New-Item -ItemType Directory -Force -Path $dir | Out-Null } catch { continue }
  $link = Join-Path $dir $SkillName
  if (Test-Path $link) {
    $item = Get-Item $link -Force
    if ($item.LinkType -eq "SymbolicLink") {
      if ($item.Target -eq $SourceDir) { Write-Host "  已正确链接，跳过: $link"; $skipped++ }
      else {
        Remove-Item $link -Force
        New-Item -ItemType SymbolicLink -Path $link -Target $SourceDir | Out-Null
        Write-Host "  已修复失效链接: $link"; $linked++
      }
    } else {
      Write-Host "  跳过真实目录（需人工确认）: $link"; $skipped++
    }
  } else {
    try {
      New-Item -ItemType SymbolicLink -Path $link -Target $SourceDir | Out-Null
      Write-Host "  已链接: $link"; $linked++
    } catch {
      Write-Host "  链接失败（需开启开发者模式）: $link" -ForegroundColor Yellow
    }
  }
}

Write-Host "==> 3/3 运行时依赖"
if ($NoDeps) {
  Write-Host "  已按参数跳过"
} else {
  if (Get-Command npm -ErrorAction SilentlyContinue) {
    Push-Location $SourceDir
    npm install --silent --no-audit --no-fund 2>&1 | ForEach-Object { Write-Host "  $_" }
    Pop-Location
    Write-Host "  PptxGenJS 安装流程结束"
  } else {
    Write-Host "  未找到 npm，跳过 PptxGenJS 安装（生成 PPTX 时需要）"
  }
  if (Get-Command python -ErrorAction SilentlyContinue) {
    python -c "import pptx" 2>$null
    if ($LASTEXITCODE -ne 0) { Write-Host "  提示: qa.py 需要 python-pptx，可执行 pip install python-pptx" }
    else { Write-Host "  python-pptx 已就绪" }
  }
}

Write-Host ""
Write-Host "安装完成。"
Write-Host "  源目录: $SourceDir"
Write-Host "  新建/修复链接: $linked   已存在跳过: $skipped"
Write-Host "  重启 AI 助手后即可用「$SkillName」这个 skill。"
