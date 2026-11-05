$Metadata = Get-Content "$PSScriptRoot/metadata.html" -Raw

Write-Host "$Metadata"

$content = Get-Content "$PSScriptRoot/index.html" -Raw
$content = $content -replace '  <meta charset="utf-8" />', "$Metadata"
$content | Set-Content "$PSScriptRoot/index.html" -Encoding UTF8
