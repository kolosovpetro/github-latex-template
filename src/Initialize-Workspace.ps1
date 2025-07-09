function Write-Section
{
    param ([string]$Message = "")
    Write-Host "`n==============================================================================" -ForegroundColor Cyan
    Write-Host $Message
}


$InitialWorkingDirectory = Get-Location
Write-Section "Initial working directory: $InitialWorkingDirectory"

Write-Section "Setting working directory to PSScriptRoot: $PSScriptRoot"
Set-Location -Path $PSScriptRoot

Write-Section "Determining the root latex file ..."
$LatexFileName = (Get-ChildItem -Filter "*.tex" | Select-Object -First 1).BaseName
Write-Section "LaTeX file name: $LatexFileName"

Write-Section "Determining the root bibtex file ..."
$BibtexFileName = (Get-ChildItem -Filter "*.bib" | Select-Object -First 1).BaseName
Write-Section "BibTeX file name: $BibtexFileName"

Write-Section "Determining the name or root GIT repository ..."
$GitRootDirectory = (Get-Item $PSScriptRoot).Parent.Name
Write-Section "New name for LaTeX and BibTeX files: $GitRootDirectory"

Write-Section "Renaming LaTeX file ..."
Write-Section "Old LaTeX file name: $LatexFileName.tex"
Write-Section "New LaTeX file name: $GitRootDirectory.tex"
Rename-Item -Path "$LatexFileName.tex" -NewName "$GitRootDirectory.tex"
Write-Section "LaTeX file renamed successfully!"

Write-Section "Renaming BibTeX file ..."
Write-Section "Old BibTeX file name: $BibtexFileName.bib"
Write-Section "New BibTeX file name: $GitRootDirectory.bib"
Rename-Item -Path "$BibtexFileName.bib" -NewName "$GitRootDirectory.bib"
Write-Section "BibTeX file renamed successfully!"

Write-Section "Patching LaTeX file with new BibTeX file name ..."
$LatexFileContent = Get-Content -Path "$GitRootDirectory.tex"
Write-Section "Old BibTeX file name: $BibtexFileName"
Write-Section "New BibTeX file name: $GitRootDirectory"
$LatexFileContent = $LatexFileContent -replace "$BibtexFileName", "$GitRootDirectory"
$LatexFileContent | Set-Content "$GitRootDirectory.tex"
Write-Section "Successfully patched LaTeX file with new BibTeX file!"

Write-Section "Patching Github Actions ..."
$LatexFileName
$BuildActionFile = "build-pdf.yml"
$BuildActionFilePath = "../.github/workflows/$BuildActionFile"
$BuildActionFileContent = Get-Content -Path $BuildActionFilePath
Write-Section
$BuildActionFileContent
Write-Section
$BuildActionFileContent = $BuildActionFileContent -replace "$LatexFileName", "$GitRootDirectory"
$BuildActionFileContent | Set-Content $BuildActionFilePath
Write-Section
$BuildActionFileContent
Write-Section

$DeployActionFileName = "build-and-deploy-pdf.yml"
$DeployActionFilePath = "../.github/workflows/$DeployActionFileName"
$DeployActionFileConent = Get-Content -Path $DeployActionFilePath
Write-Section
$DeployActionFileConent
Write-Section
$DeployActionFileConent = $DeployActionFileConent -replace "$LatexFileName", "$GitRootDirectory"
$DeployActionFileConent | Set-Content $DeployActionFilePath

Write-Section
$DeployActionFileConent

Write-Section "Renaming Mathematica files ..."

$MathematicaProgramsFolder = "../mathematica"
$MathematicaPackageFilePath = "$MathematicaProgramsFolder/$LatexFileName.m"
$MathematicaNotebookFilePath = "$MathematicaProgramsFolder/$LatexFileName.nb"
Rename-Item -Path "$MathematicaPackageFilePath" -NewName "$GitRootDirectory.m"
Rename-Item -Path "$MathematicaNotebookFilePath" -NewName "$GitRootDirectory.nb"

Write-Section "Changing Powershell directory to $GitRootDirectory... "

Set-Location $InitialWorkingDirectory
