# ============================================================
# Experiment 01 - Commit baseline (gitignore, docs, scripts)
# Usage: powershell -ExecutionPolicy Bypass -File D:\oss-blog\scripts\04-commit-baseline.ps1
# Output: D:\oss-blog\_agent_output\04-commit-baseline.txt
# ============================================================
$ErrorActionPreference = 'Continue'
$outDir = 'D:\oss-blog\_agent_output'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
$log = @()

Set-Location 'D:\oss-blog'
$log += '--- git status (before) ---'
$log += (git status 2>&1 | Out-String)

$log += '--- git add ---'
$log += (git add .gitignore docs/ scripts/ 2>&1 | Out-String)

$log += '--- git commit ---'
$log += (git commit -m "docs(baseline): add baseline doc, config template and helper scripts" 2>&1 | Out-String)

$log += '--- git log ---'
$log += (git log --oneline --decorate -n 5 2>&1 | Out-String)

$log += '--- git status (after) ---'
$log += (git status 2>&1 | Out-String)

$log | Set-Content -Path "$outDir\04-commit-baseline.txt" -Encoding UTF8
Write-Host 'Done. Result saved to D:\oss-blog\_agent_output\04-commit-baseline.txt'
