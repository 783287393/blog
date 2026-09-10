# ============================================================
# Experiment 01 - Start Ghost and verify
# Usage: powershell -ExecutionPolicy Bypass -File D:\oss-blog\scripts\02-start-ghost.ps1
# Output: D:\oss-blog\_agent_output\02-start-ghost.txt
# ============================================================
$ErrorActionPreference = 'Continue'
$outDir = 'D:\oss-blog\_agent_output'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
$log = @()

Set-Location 'D:\oss-blog\runtime'
$log += '--- ghost start ---'
$log += (ghost start 2>&1 | Out-String)

Start-Sleep -Seconds 10

$log += '--- ghost ls ---'
$log += (ghost ls 2>&1 | Out-String)

$log += '--- port 2368 ---'
$log += ((Get-NetTCPConnection -LocalPort 2368 -ErrorAction SilentlyContinue | Select-Object LocalAddress,LocalPort,State,OwningProcess | Format-Table -AutoSize | Out-String))

$log += '--- log tail (last 40 lines) ---'
$log += ((Get-Content 'D:\oss-blog\runtime\content\logs\http___localhost_2368__development.log' -Tail 40 | Out-String))

$log += '--- db timestamp ---'
$log += ((Get-Item 'D:\oss-blog\runtime\content\data\ghost-local.db' -ErrorAction SilentlyContinue | Select-Object Length,LastWriteTime | Format-List | Out-String))

$log | Set-Content -Path "$outDir\02-start-ghost.txt" -Encoding UTF8
Write-Host 'Done. Result saved to D:\oss-blog\_agent_output\02-start-ghost.txt'
Write-Host 'Now open http://localhost:2368/ghost in your browser to finish setup.'
