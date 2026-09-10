# ============================================================
# Experiment 01 - Git: sync main, tag v1.0-lab, push tag
# Output: D:\oss-blog\_agent_output\13-git-tag.txt
# ============================================================
$ErrorActionPreference = 'Continue'
$outDir = 'D:\oss-blog\_agent_output'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
$log = @()

Set-Location 'D:\oss-blog'

$log += '=== checkout main ==='
$log += (git checkout main 2>&1 | Out-String)

$log += '=== pull latest main ==='
$log += (git pull origin main 2>&1 | Out-String)

$log += '=== create tag v1.0-lab ==='
$log += (git tag -a v1.0-lab -m "Experiment 01 delivery: custom theme + related posts + demo content" 2>&1 | Out-String)

$log += '=== push tag ==='
$log += (git push origin v1.0-lab 2>&1 | Out-String)

$log += '=== tags ==='
$log += (git tag -l 2>&1 | Out-String)

$log += '=== recent log (graph) ==='
$log += (git log --oneline --graph -10 2>&1 | Out-String)

$log | Set-Content -Path "$outDir\13-git-tag.txt" -Encoding UTF8
Write-Host 'Done. Result saved to D:\oss-blog\_agent_output\13-git-tag.txt'
