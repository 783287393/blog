# ============================================================
# Experiment 01 - Verify imported content in database
# Usage: powershell -ExecutionPolicy Bypass -File D:\oss-blog\scripts\06-verify-content.ps1
# Output: D:\oss-blog\_agent_output\06-verify-content.txt
# ============================================================
$ErrorActionPreference = 'Continue'
$outDir = 'D:\oss-blog\_agent_output'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

$env:NODE_PATH = 'D:\oss-blog\runtime\versions\6.63.0\node_modules'

$out = node 'D:\oss-blog\scripts\06-check-db.js' 2>&1 | Out-String
Set-Content -Path "$outDir\06-verify-content.txt" -Value $out -Encoding UTF8

Write-Host 'Done. Result saved to D:\oss-blog\_agent_output\06-verify-content.txt'
