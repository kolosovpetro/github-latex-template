param (
    [string]$LatexFileName = "GithubLatexTemplate",
    [string]$OutputDirectory = "../out"
)

$OutputDirectoryAbsPath = (Resolve-Path $OutputDirectory).Path
$LatexFileAbsPath = (Resolve-Path "$LatexFileName.tex").Path
$AuxDirectoryAbsPath = $OutputDirectoryAbsPath

Write-Output "Compiling $LatexFileName first time... "
Write-Output "Latex file: $LatexFileAbsPath"
Write-Output "Output directory: $OutputDirectoryAbsPath"
Write-Output "Aux directory: $AuxDirectoryAbsPath"
pdflatex -file-line-error -interaction="nonstopmode" -synctex="1" -output-format="pdf" `
    -output-directory="$OutputDirectoryAbsPath" `
    -aux-directory="$AuxDirectoryAbsPath" $LatexFileAbsPath

Write-Output "Compiling bibtex ... "
$WorkingDirectoryForBibtex = "$OutputDirectoryAbsPath/$LatexFileName"
Write-Output "Working directory for bibtex: $WorkingDirectoryForBibtex"
bibtex "$WorkingDirectoryForBibtex"

Write-Output "Compiling $LatexFileName second time... "
Write-Output "Latex file: $LatexFileAbsPath"
Write-Output "Output directory: $OutputDirectoryAbsPath"
Write-Output "Aux directory: $AuxDirectoryAbsPath"
pdflatex -file-line-error -interaction="nonstopmode" -synctex="1" -output-format="pdf" `
    -output-directory="$OutputDirectoryAbsPath" `
    -aux-directory="$AuxDirectoryAbsPath" $LatexFileAbsPath

Write-Output "Compiling $LatexFileName third time... "
Write-Output "Latex file: $LatexFileAbsPath"
Write-Output "Output directory: $OutputDirectoryAbsPath"
Write-Output "Aux directory: $AuxDirectoryAbsPath"
pdflatex -file-line-error -interaction="nonstopmode" -synctex="1" -output-format="pdf" `
    -output-directory="$OutputDirectoryAbsPath" `
    -aux-directory="$AuxDirectoryAbsPath" $LatexFileAbsPath
