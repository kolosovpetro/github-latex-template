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
$LatexFileContent | Set-Content "$GitRootDirectory.tex"

Write-Output "=============================================================================="

Write-Output "Updating Github Actions ..."
$LatexFileName
$BuildActionFile = "build-pdf.yml"
$BuildActionFilePath = "../.github/workflows/$BuildActionFile"
$BuildActionFileContent = Get-Content -Path $BuildActionFilePath
Write-Output "=============================================================================="
$BuildActionFileContent
Write-Output "=============================================================================="
$BuildActionFileContent = $BuildActionFileContent -replace "$LatexFileName", "$GitRootDirectory"
$BuildActionFileContent | Set-Content $BuildActionFilePath
Write-Output "=============================================================================="
$BuildActionFileContent
Write-Output "=============================================================================="

$DeployActionFileName = "build-and-deploy-pdf.yml"
$DeployActionFilePath = "../.github/workflows/$DeployActionFileName"
$DeployActionFileConent = Get-Content -Path $DeployActionFilePath
Write-Output "=============================================================================="
$DeployActionFileConent
Write-Output "=============================================================================="
$DeployActionFileConent = $DeployActionFileConent -replace "$LatexFileName", "$GitRootDirectory"
$DeployActionFileConent | Set-Content $DeployActionFilePath
Write-Output "=============================================================================="
$DeployActionFileConent
Write-Output "=============================================================================="

Write-Output "Updating Mathematica files ..."
$MathematicaProgramsFolder = "../mathematica"
$MathematicaPackageFilePath = "$MathematicaProgramsFolder/$LatexFileName.m"
$MathematicaNotebookFilePath = "$MathematicaProgramsFolder/$LatexFileName.nb"
Rename-Item -Path "$MathematicaPackageFilePath" -NewName "$GitRootDirectory.m"
Rename-Item -Path "$MathematicaNotebookFilePath" -NewName "$GitRootDirectory.nb"


Write-Output "=============================================================================="

Write-Output "Changing Powershell Directory... "
cd ..
