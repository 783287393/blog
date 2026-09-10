# ============================================================
# Experiment 01 - Final commit and push
# Output: D:\oss-blog\_agent_output\15-final-commit.txt
# ============================================================
$ErrorActionPreference = 'Continue'
$outDir = 'D:\oss-blog\_agent_output'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
$log = @()

Set-Location 'D:\oss-blog'

$log += '=== git status (before) ==='
$log += (git status 2>&1 | Out-String)

$log += '=== add all changes ==='
git add -A
$log += '--- staged files ---'
$log += (git diff --cached --name-only 2>&1 | Out-String)

$log += '=== commit ==='
$msg = @"
docs: finalize experiment deliverables

- Update tests/acceptance.md: all 45 test cases passed
- Add docs/backup/ghost-export-sanitized.json (private keys and passwords removed)
- Add helper scripts: git push/tag, export sanitizer, SMTP test server
- Update .gitignore: exclude sensitive Ghost export files
- Experiment 01 delivery complete
"@
$log += (git commit -m $msg 2>&1 | Out-String)

$log += '=== push to origin main ==='
$log += (git push origin main 2>&1 | Out-String)

$log += '=== final log ==='
$log += (git log --oneline -6 2>&1 | Out-String)

$log += '=== tags ==='
$log += (git tag -l 2>&1 | Out-String)

$log | Set-Content -Path "$outDir\15-final-commit.txt" -Encoding UTF8
Write-Host 'Done. Result saved to D:\oss-blog\_agent_output\15-final-commit.txt'
