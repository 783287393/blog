# ============================================================
# Experiment 01 - Prepare Ghost import file
# Merge demo-content.json into the exported JSON
# Usage: powershell -ExecutionPolicy Bypass -File D:\oss-blog\scripts\05-prepare-import.ps1
# Output: D:\oss-blog\docs\ghost-import.json
# ============================================================
$ErrorActionPreference = 'Continue'
$outDir = 'D:\oss-blog\_agent_output'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
$log = @()

$exportFile = Get-ChildItem 'D:\oss-blog\scripts' -Filter '*.json' | Where-Object { $_.Name -like '*.ghost.*.json' } | Select-Object -First 1
if (-not $exportFile) {
    Write-Host 'ERROR: Ghost export json not found in D:\oss-blog\scripts'
    exit 1
}
$log += ('export file : ' + $exportFile.Name)

$export = Get-Content $exportFile.FullName -Raw -Encoding UTF8 | ConvertFrom-Json
$demo   = Get-Content 'D:\oss-blog\docs\demo-content.json' -Raw -Encoding UTF8 | ConvertFrom-Json

$data = $export.db[0].data

$before = 'posts=' + @($data.posts).Count + ' tags=' + @($data.tags).Count + ' posts_tags=' + @($data.posts_tags).Count + ' posts_authors=' + @($data.posts_authors).Count
$log += ('before -> ' + $before)

$data.posts         = @($data.posts) + @($demo.posts)
$data.tags          = @($data.tags) + @($demo.tags)
$data.posts_tags    = @($data.posts_tags) + @($demo.posts_tags)
$data.posts_authors = @($data.posts_authors) + @($demo.posts_authors)

$after = 'posts=' + @($data.posts).Count + ' tags=' + @($data.tags).Count + ' posts_tags=' + @($data.posts_tags).Count + ' posts_authors=' + @($data.posts_authors).Count
$log += ('after  -> ' + $after)

$json = $export | ConvertTo-Json -Depth 100
$outPath = 'D:\oss-blog\docs\ghost-import.json'
[System.IO.File]::WriteAllText($outPath, $json, (New-Object System.Text.UTF8Encoding($false)))
$log += ('written: ' + $outPath + ' (' + (Get-Item $outPath).Length + ' bytes)')

$log | Set-Content -Path "$outDir\05-prepare-import.txt" -Encoding UTF8
Write-Host 'Done. Import file: D:\oss-blog\docs\ghost-import.json'
