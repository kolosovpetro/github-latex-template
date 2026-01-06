$CurrentPath = Get-Location
cd $PSScriptRoot

$LatexFileName = (Get-ChildItem -Filter "*.tex" | Select-Object -First 1).BaseName
Write-Host "Latex file: $LatexFileName"  -ForegroundColor Magenta

pandoc "$LatexFileName.tex" --mathjax --standalone --citeproc `
    --bibliography="$LatexFileName.bib" `
    --csl=chicago-author-date.csl -o index.html

cd $CurrentPath