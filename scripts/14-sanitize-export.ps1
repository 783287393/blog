# ============================================================
# Experiment 01 - Sanitize Ghost export file
# Output: D:\oss-blog\_agent_output\14-sanitize.txt
# ============================================================
$ErrorActionPreference = 'Continue'
$outDir = 'D:\oss-blog\_agent_output'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

$env:NODE_PATH = 'D:\oss-blog\runtime\versions\6.63.0\node_modules'

$out = node 'D:\oss-blog\scripts\14-sanitize-export.js' 2>&1 | Out-String
Set-Content -Path "$outDir\14-sanitize.txt" -Value $out -Encoding UTF8

Write-Host 'Done. Result saved to D:\oss-blog\_agent_output\14-sanitize.txt'
