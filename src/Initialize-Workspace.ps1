function Write-Section
{
    param (
        [string]$Message = "",
        [ConsoleColor]$Color = 'Magenta'
    )
    Write-Host "`n==============================================================================" -ForegroundColor $Color
    Write-Host $Message -ForegroundColor $Color
}

$ErrorActionPreference = "Stop"
$InitialWorkingDirectory = Get-Location
Write-Section "Initial working directory: $InitialWorkingDirectory" -Color Gray

Write-Section "Setting working directory to PSScriptRoot: $PSScriptRoot" -Color Gray
Set-Location -Path $PSScriptRoot

Write-Section "Determining the root latex file ..." -Color Gray
$LatexFileName = (Get-ChildItem -Filter "*.tex" | Select-Object -First 1).BaseName
Write-Section "LaTeX file name: $LatexFileName"

Write-Section "Determining the root bibtex file ..." -Color Gray
$BibtexFileName = (Get-ChildItem -Filter "*.bib" | Select-Object -First 1).BaseName
Write-Section "BibTeX file name: $BibtexFileName"

Write-Section "Determining the name or root GIT repository ..." -Color Gray
$GitRootDirectory = (Get-Item $PSScriptRoot).Parent.Name
Write-Section "New name for LaTeX and BibTeX files: $GitRootDirectory"

Write-Section "Renaming LaTeX file ..." -Color Gray
Write-Section "Old LaTeX file name: $LatexFileName.tex"-Color Gray
Write-Section "New LaTeX file name: $GitRootDirectory.tex"
Rename-Item -Path "$LatexFileName.tex" -NewName "$GitRootDirectory.tex"
Write-Section "LaTeX file renamed successfully!" -Color Green

Write-Section "Renaming BibTeX file ..."
Write-Section "Old BibTeX file name: $BibtexFileName.bib" -Color Gray
Write-Section "New BibTeX file name: $GitRootDirectory.bib"
Rename-Item -Path "$BibtexFileName.bib" -NewName "$GitRootDirectory.bib"
Write-Section "BibTeX file renamed successfully!" -Color Green

Write-Section "Patching LaTeX file with new BibTeX file name ..." -Color Gray
$LatexFileContent = Get-Content -Path "$GitRootDirectory.tex"
Write-Section "Old BibTeX file name: $BibtexFileName"
Write-Section "New BibTeX file name: $GitRootDirectory" -Color Gray
$LatexFileContent = $LatexFileContent -replace "$BibtexFileName", "$GitRootDirectory"
$LatexFileContent | Set-Content "$GitRootDirectory.tex"
Write-Section "Successfully patched LaTeX file with new BibTeX file!" -Color Green

Write-Section "Patching Github Actions ..." -Color Gray
$BuildActionFile = "build-pdf.yml"
$BuildActionFilePath = "../.github/workflows/$BuildActionFile"
$BuildActionFileContent = Get-Content -Path $BuildActionFilePath
Write-Section "Initial build action content:"
$BuildActionFileContent
Write-Section "Patching build action ..." -Color Gray
$BuildActionFileContent = $BuildActionFileContent -replace "$LatexFileName", "$GitRootDirectory"
$BuildActionFileContent | Set-Content $BuildActionFilePath
Write-Section "Patched build action content:"
$BuildActionFileContent
Write-Section "Successfully patched build action!" -Color Green

$DeployActionFileName = "build-and-deploy-pdf.yml"
$DeployActionFilePath = "../.github/workflows/$DeployActionFileName"
$DeployActionFileConent = Get-Content -Path $DeployActionFilePath
Write-Section "Initial deploy action content:"
$DeployActionFileConent
Write-Section "Patching deploy action ..." -Color Gray
$DeployActionFileConent = $DeployActionFileConent -replace "$LatexFileName", "$GitRootDirectory"
$DeployActionFileConent | Set-Content $DeployActionFilePath

Write-Section "Patched deploy action content:"
$DeployActionFileConent
Write-Section "Successfully patched deploy action!" -Color Green

Write-Section "Renaming Mathematica files ..." -Color Gray

$MathematicaProgramsFolder = "../mathematica"
$MathematicaPackageFilePath = "$MathematicaProgramsFolder/$LatexFileName.m"
$MathematicaNotebookFilePath = "$MathematicaProgramsFolder/$LatexFileName.nb"
Rename-Item -Path "$MathematicaPackageFilePath" -NewName "$GitRootDirectory.m"
Rename-Item -Path "$MathematicaNotebookFilePath" -NewName "$GitRootDirectory.nb"

Write-Section "Successfully renamed Mathematica files!" -Color Green

Write-Section "Changing Powershell directory to $InitialWorkingDirectory ... " -Color Gray
Set-Location $InitialWorkingDirectory

$OutputFolder = "..\out\*"
Write-Section "Cleaning output folder: $OutputFolder"  -Color Gray
Remove-Item -Path $OutputFolder -Recurse -Force
Write-Section "Succesfully cleaned the output folder." -Color Green

Write-Section "Execurtion has been completed succesfully: $LASTEXITCODE" -Color Green
