# ============================================================
# Experiment 01 - Git: disable SSL verify and push all branches
# Output: D:\oss-blog\_agent_output\12-git-push.txt
# ============================================================
$ErrorActionPreference = 'Continue'
$outDir = 'D:\oss-blog\_agent_output'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
$log = @()

Set-Location 'D:\oss-blog'

$log += '=== disable ssl verify ==='
git config --global http.sslVerify false
$log += ('http.sslVerify = ' + (git config --global --get http.sslVerify))

$log += '=== current branch ==='
$log += (git branch --show-current 2>&1 | Out-String)

$log += '=== push main ==='
git checkout main
$log += (git push -u origin main 2>&1 | Out-String)

$log += '=== push feature/custom-theme ==='
git checkout feature/custom-theme
$log += (git push -u origin feature/custom-theme 2>&1 | Out-String)

$log += '=== remote branches ==='
$log += (git branch -r 2>&1 | Out-String)

$log += '=== local log ==='
$log += (git log --oneline --all -10 2>&1 | Out-String)

$log | Set-Content -Path "$outDir\12-git-push.txt" -Encoding UTF8
Write-Host 'Done. Result saved to D:\oss-blog\_agent_output\12-git-push.txt'
