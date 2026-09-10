# ============================================================
# Experiment 01 - Environment diagnose script (run manually)
# Usage: powershell -ExecutionPolicy Bypass -File D:\oss-blog\scripts\01-diagnose.ps1
# Output: D:\oss-blog\_agent_output\01-diagnose.txt
# ============================================================
$ErrorActionPreference = 'Continue'
$outDir = 'D:\oss-blog\_agent_output'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
$log = @()

$log += '########## 1. Tool versions ##########'
$log += ('git  : ' + ((git --version 2>&1 | Out-String).Trim()))
$log += ('node : ' + ((node --version 2>&1 | Out-String).Trim()))
$log += ('npm  : ' + ((npm --version 2>&1 | Out-String).Trim()))
$log += ('ghost: ' + ((ghost --version 2>&1 | Out-String).Trim()))

$log += ''
$log += '########## 2. Ghost running state (runtime dir) ##########'
Set-Location 'D:\oss-blog\runtime'
$log += '--- ghost ls ---'
$log += (ghost ls 2>&1 | Out-String)
$log += '--- node processes ---'
$log += ((Get-Process node -ErrorAction SilentlyContinue | Select-Object Id,ProcessName,StartTime | Format-Table -AutoSize | Out-String))

$log += ''
$log += '########## 3. Port 2368 ##########'
$log += ((Get-NetTCPConnection -LocalPort 2368 -ErrorAction SilentlyContinue | Select-Object LocalAddress,LocalPort,State,OwningProcess | Format-Table -AutoSize | Out-String))

$log += ''
$log += '########## 4. Database file ##########'
$log += ((Get-Item 'D:\oss-blog\runtime\content\data\ghost-local.db' -ErrorAction SilentlyContinue | Select-Object Length,LastWriteTime | Format-List | Out-String))

$log += ''
$log += '########## 5. Themes ##########'
$log += ((Get-ChildItem 'D:\oss-blog\runtime\content\themes' -Directory | Select-Object Name | Format-Table -AutoSize | Out-String))

$log += ''
$log += '########## 6. Git state ##########'
Set-Location 'D:\oss-blog'
$log += '--- git log ---'
$log += (git log --oneline --decorate -n 10 2>&1 | Out-String)
$log += '--- git status ---'
$log += (git status 2>&1 | Out-String)
$log += '--- git remote ---'
$log += (git remote -v 2>&1 | Out-String)

$log | Set-Content -Path "$outDir\01-diagnose.txt" -Encoding UTF8
Write-Host 'Diagnose done. Result saved to D:\oss-blog\_agent_output\01-diagnose.txt'
Write-Host 'Please send the file content back to the AI.'
