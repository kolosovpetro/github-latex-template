Write-Output "Setting working directory to PSScriptRoot: $PSScriptRoot"
Set-Location -Path $PSScriptRoot

Write-Output "=============================================================================="

Write-Output "Determining the root latex file to build ..."
$LatexFileName = (Get-ChildItem -Filter "*.tex" | Select-Object -First 1).BaseName
Write-Output "Latex file: $LatexFileName"

Write-Output "=============================================================================="

Write-Output "Determining the root bibtex file ..."
$BibtexFileName = (Get-ChildItem -Filter "*.bib" | Select-Object -First 1).BaseName
Write-Output "Bibtex file: $BibtexFileName"

Write-Output "=============================================================================="

Write-Output "Determining New name for TeX and BibTeX files ..."
Write-Output "New name is the root of Git repository ..."
$GitRootDirectory = (Get-Item $PSScriptRoot).Parent.Name
Write-Output "New name for TeX and BibTeX files: $GitRootDirectory"

Write-Output "=============================================================================="

Write-Output "Renaming TeX root file ..."
Write-Output "Old name: $LatexFileName.tex"
Rename-Item -Path "$LatexFileName.tex" -NewName "$GitRootDirectory.tex"
Write-Output "New name: $GitRootDirectory.tex"

Write-Output "=============================================================================="

Write-Output "Renaming BibTeX root file ..."
Write-Output "Old name: $BibtexFileName.bib"
Rename-Item -Path "$BibtexFileName.bib" -NewName "$GitRootDirectory.bib"
Write-Output "New name: $GitRootDirectory.bib"

Write-Output "=============================================================================="

Write-Output "Updating TeX root file with new BibTeX file name ..."
$LatexFileContent = Get-Content -Path "$GitRootDirectory.tex"
Write-Output "Old BibTeX file name: $BibtexFileName"
Write-Output "New BibTeX file name: $GitRootDirectory"
$LatexFileContent = $LatexFileContent -replace "$BibtexFileName", "$GitRootDirectory"
$LatexFileContent| Set-Content "$GitRootDirectory.tex"

Write-Output "=============================================================================="

Write-Output "Changing Powershell Directory... "
cd ..
