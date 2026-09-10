# ============================================================
# Experiment 01 - Check member details for comment debugging
# Output: D:\oss-blog\_agent_output\09-check-members.txt
# ============================================================
$ErrorActionPreference = 'Continue'
$outDir = 'D:\oss-blog\_agent_output'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

$env:NODE_PATH = 'D:\oss-blog\runtime\versions\6.63.0\node_modules'

$out = node 'D:\oss-blog\scripts\09-check-members.js' 2>&1 | Out-String
Set-Content -Path "$outDir\09-check-members.txt" -Value $out -Encoding UTF8

Write-Host 'Done. Result saved to D:\oss-blog\_agent_output\09-check-members.txt'
