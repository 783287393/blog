# ============================================================
# Experiment 01 - Git: create feature branch, commit, push
# Output: D:\oss-blog\_agent_output\11-git-feature.txt
# ============================================================
$ErrorActionPreference = 'Continue'
$outDir = 'D:\oss-blog\_agent_output'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
$log = @()

Set-Location 'D:\oss-blog'

$log += '=== git status (before) ==='
$log += (git status 2>&1 | Out-String)

$log += '=== create feature branch ==='
$log += (git checkout -b feature/custom-theme 2>&1 | Out-String)

$log += '=== add all changes ==='
git add -A
$log += '--- staged files ---'
$log += (git diff --cached --name-only 2>&1 | Out-String)

$log += '=== commit ==='
$msg = @"
feat(theme): custom theme oss-blog-theme with related posts

- Fork from TryGhost/Source 1.7.4 (MIT)
- Navigation: add tag quick links
- Post card: add reading time
- Post header: show all tags
- Feature: related posts by primary tag with fallback to latest
- Add README, NOTICE, acceptance test docs
- Add helper scripts for local development
"@
$log += (git commit -m $msg 2>&1 | Out-String)

$log += '=== push to origin ==='
$log += (git push -u origin feature/custom-theme 2>&1 | Out-String)

$log += '=== recent commits ==='
$log += (git log --oneline -5 2>&1 | Out-String)

$log | Set-Content -Path "$outDir\11-git-feature.txt" -Encoding UTF8
Write-Host 'Done. Result saved to D:\oss-blog\_agent_output\11-git-feature.txt'
