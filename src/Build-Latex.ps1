param (
    [string]$OutputDirectory = "../out"
)

Write-Output "Setting working directory to PSScriptRoot: $PSScriptRoot"
Set-Location -Path $PSScriptRoot

Write-Output "=============================================================================="

Write-Output "Determining the root latex file to build ..."
$LatexFileName = (Get-ChildItem -Filter "*.tex" | Select-Object -First 1).BaseName
Write-Output "Latex file: $LatexFileName"

$OutputDirectoryAbsPath = (Resolve-Path $OutputDirectory).Path
$LatexFileAbsPath = (Resolve-Path "$LatexFileName.tex").Path
$AuxDirectoryAbsPath = $OutputDirectoryAbsPath

Write-Output "=============================================================================="

Write-Output "Compiling $LatexFileName first time... "
Write-Output "Latex file: $LatexFileAbsPath"
Write-Output "Output directory: $OutputDirectoryAbsPath"
Write-Output "Aux directory: $AuxDirectoryAbsPath"
pdflatex -file-line-error -interaction="nonstopmode" -synctex="1" -output-format="pdf" `
    -output-directory="$OutputDirectoryAbsPath" `
    -aux-directory="$AuxDirectoryAbsPath" $LatexFileAbsPath

Write-Output "=============================================================================="

Write-Output "Compiling bibtex ... "
$WorkingDirectoryForBibtex = "$OutputDirectoryAbsPath/$LatexFileName"
Write-Output "Working directory for bibtex: $WorkingDirectoryForBibtex"
bibtex "$WorkingDirectoryForBibtex"

Write-Output "=============================================================================="

Write-Output "Compiling $LatexFileName second time... "
Write-Output "Latex file: $LatexFileAbsPath"
Write-Output "Output directory: $OutputDirectoryAbsPath"
Write-Output "Aux directory: $AuxDirectoryAbsPath"
pdflatex -file-line-error -interaction="nonstopmode" -synctex="1" -output-format="pdf" `
    -output-directory="$OutputDirectoryAbsPath" `
    -aux-directory="$AuxDirectoryAbsPath" $LatexFileAbsPath

Write-Output "=============================================================================="

Write-Output "Compiling $LatexFileName third time... "
Write-Output "Latex file: $LatexFileAbsPath"
Write-Output "Output directory: $OutputDirectoryAbsPath"
Write-Output "Aux directory: $AuxDirectoryAbsPath"
pdflatex -file-line-error -interaction="nonstopmode" -synctex="1" -output-format="pdf" `
    -output-directory="$OutputDirectoryAbsPath" `
    -aux-directory="$AuxDirectoryAbsPath" $LatexFileAbsPath

Write-Output "=============================================================================="

Write-Output "Build complete."
Write-Output "Changing Powershell Directory... "
cd ..
