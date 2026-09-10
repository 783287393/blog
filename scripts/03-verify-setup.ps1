# ============================================================
# Experiment 01 - Verify admin setup and baseline state
# Usage: powershell -ExecutionPolicy Bypass -File D:\oss-blog\scripts\03-verify-setup.ps1
# Output: D:\oss-blog\_agent_output\03-verify-setup.txt
# ============================================================
$ErrorActionPreference = 'Continue'
$outDir = 'D:\oss-blog\_agent_output'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
$log = @()

$log += '########## 1. Database file ##########'
$log += ((Get-Item 'D:\oss-blog\runtime\content\data\ghost-local.db' -ErrorAction SilentlyContinue | Select-Object Length,LastWriteTime | Format-List | Out-String))

$log += ''
$log += '########## 2. Log: setup / auth requests (tail 200 lines) ##########'
$logFile = 'D:\oss-blog\runtime\content\logs\http___localhost_2368__development.log'
$log += (Select-String -Path $logFile -Pattern 'authentication/setup|users/me|POST /ghost/api/admin' | Select-Object -Last 20 | ForEach-Object { $_.Line.Substring(0, [Math]::Min(1500, $_.Line.Length)) } | Out-String)

$log += ''
$log += '########## 3. Ghost running state ##########'
Set-Location 'D:\oss-blog\runtime'
$log += (ghost ls 2>&1 | Out-String)

$log += ''
$log += '########## 4. git status ##########'
Set-Location 'D:\oss-blog'
$log += (git status 2>&1 | Out-String)

$log | Set-Content -Path "$outDir\03-verify-setup.txt" -Encoding UTF8
Write-Host 'Done. Result saved to D:\oss-blog\_agent_output\03-verify-setup.txt'
