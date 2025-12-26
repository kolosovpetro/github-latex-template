<#
.SYNOPSIS
    Initializes a cloned github-latex-template repository by renaming files,
    updating references, and cleaning build artifacts.

.DESCRIPTION
    This script replaces all occurrences of the default template name
    "github-latex-template" with the actual Git root directory name,
    while preserving protected strings (e.g. workflow template URLs).

    It is safe to re-run and uses small reusable helper functions
    for easier maintenance.
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# ----------------------------------------------------------------------
# Global variables
# ----------------------------------------------------------------------

$GitRootDirectoryName = (Get-Item $PSScriptRoot).Parent.Name
$GitRootDirectoryAbsPath = (Get-Item $PSScriptRoot).Parent
$DefaultGitRootDirectoryName = "github-latex-template"

Write-Host "Git root directory name: $GitRootDirectoryName"
Write-Host "Git root directory abs path: $GitRootDirectoryAbsPath"
Write-Host "Git root default directory name: $DefaultGitRootDirectoryName"

Write-Host "Initializing LaTeX template for repository: $GitRootDirectoryName" -ForegroundColor Cyan

# ----------------------------------------------------------------------
# Helper functions
# ----------------------------------------------------------------------

function Replace-TextInFile
{
    param (
        [Parameter(Mandatory)]
        [string] $FilePath,

        [Parameter(Mandatory)]
        [string] $OldText,

        [Parameter(Mandatory)]
        [string] $NewText
    )

    Write-Host "Invoke Replace-TextInFile with FilePath: $FilePath"
    Write-Host "Invoke Replace-TextInFile with OldText: $OldText"
    Write-Host "Invoke Replace-TextInFile with NewText: $NewText"

    if (-not (Test-Path $FilePath))
    {
        Write-Warning "File not found: $FilePath"
        return
    }

    $content = Get-Content $FilePath -Raw

    $content = $content -replace [regex]::Escape($OldText), $NewText


    Set-Content -Path $FilePath -Value $content -NoNewline
    Write-Host "Updated: $FilePath"
}

function Rename-FileSafe
{
    param (
        [Parameter(Mandatory)]
        [string] $OldPath,

        [Parameter(Mandatory)]
        [string] $NewPath
    )

    Write-Host "Invoke Rename-FileSafe with OldPath: $OldPath"
    Write-Host "Invoke Rename-FileSafe with NewPath: $NewPath"

    if (-not (Test-Path $OldPath))
    {
        Write-Warning "File not found: $OldPath"
        return
    }

    if (Test-Path $NewPath)
    {
        Write-Warning "Target already exists, skipping rename: $NewPath"
        return
    }

    Rename-Item -Path $OldPath -NewName (Split-Path $NewPath -Leaf)
    Write-Host "Renamed: $OldPath -> $NewPath"
}

function Clear-Directory
{
    param (
        [Parameter(Mandatory)]
        [string] $DirectoryPath
    )

    Write-Host "Invoke Clear-Directory with DirectoryPath: $DirectoryPath"

    if (-not (Test-Path $DirectoryPath))
    {
        Write-Warning "Directory not found: $DirectoryPath"
        return
    }

    Get-ChildItem -Path $DirectoryPath -File -Recurse | Remove-Item -Force
    Write-Host "Cleared directory: $DirectoryPath"
}

# ----------------------------------------------------------------------
# 1. Update GitHub Actions workflows
# ----------------------------------------------------------------------

$workflowFiles = @(
    "$GitRootDirectoryAbsPath/.github/workflows/build-and-deploy-pdf.yml",
    "$GitRootDirectoryAbsPath/.github/workflows/build-pdf.yml"
)

foreach ($file in $workflowFiles)
{
    Replace-TextInFile `
        -FilePath $file `
        -OldText $DefaultGitRootDirectoryName `
        -NewText $GitRootDirectoryName
}

# ----------------------------------------------------------------------
# 2. Update .run configuration files
# ----------------------------------------------------------------------

$runFiles = @(
    "$GitRootDirectoryAbsPath/.run/bibliography.run.xml",
    "$GitRootDirectoryAbsPath/.run/build-latex.run.xml"
)

foreach ($file in $runFiles)
{
    Replace-TextInFile `
        -FilePath $file `
        -OldText $DefaultGitRootDirectoryName `
        -NewText $GitRootDirectoryName
}

# ----------------------------------------------------------------------
# 3. Rename Mathematica files
# ----------------------------------------------------------------------

Rename-FileSafe `
    -OldPath "$GitRootDirectoryAbsPath/mathematica/$DefaultGitRootDirectoryName.m" `
    -NewPath "$GitRootDirectoryAbsPath/mathematica/$GitRootDirectoryName.m"

Rename-FileSafe `
    -OldPath "$GitRootDirectoryAbsPath/mathematica/$DefaultGitRootDirectoryName.nb" `
    -NewPath "$GitRootDirectoryAbsPath/mathematica/$GitRootDirectoryName.nb"

# ----------------------------------------------------------------------
# 4. Delete all files from /out
# ----------------------------------------------------------------------

Clear-Directory "$GitRootDirectoryAbsPath/out"

# ----------------------------------------------------------------------
# 5. Rename main LaTeX file
# ----------------------------------------------------------------------

Rename-FileSafe `
    -OldPath "$GitRootDirectoryAbsPath/src/$DefaultGitRootDirectoryName.tex" `
    -NewPath "$GitRootDirectoryAbsPath/src/$GitRootDirectoryName.tex"

# ----------------------------------------------------------------------
# 6. Rename main BibTeX file
# ----------------------------------------------------------------------

Rename-FileSafe `
    -OldPath "$GitRootDirectoryAbsPath/src/$DefaultGitRootDirectoryName.bib" `
    -NewPath "$GitRootDirectoryAbsPath/src/$GitRootDirectoryName.bib"

# ----------------------------------------------------------------------
# 7. Update bibliography reference in main LaTeX file
# ----------------------------------------------------------------------

Replace-TextInFile `
    -FilePath "$GitRootDirectoryAbsPath/src/$GitRootDirectoryName.tex" `
    -OldText "\bibliography{$DefaultGitRootDirectoryName}" `
    -NewText "\bibliography{$GitRootDirectoryName}"

# ----------------------------------------------------------------------
# 8. Update metadata footer
# ----------------------------------------------------------------------

Replace-TextInFile `
    -FilePath "$GitRootDirectoryAbsPath/src/metadata/footer.tex" `
    -OldText "https://github.com/kolosovpetro/$DefaultGitRootDirectoryName" `
    -NewText "https://github.com/kolosovpetro/$GitRootDirectoryName"

Replace-TextInFile `
    -FilePath "$GitRootDirectoryAbsPath/src/metadata/footer.tex" `
    -OldText "github.com/kolosovpetro/$DefaultGitRootDirectoryName" `
    -NewText "github.com/kolosovpetro/$GitRootDirectoryName"

# ----------------------------------------------------------------------
# 9. Update Mathematica package name
# ----------------------------------------------------------------------

Replace-TextInFile `
    -FilePath "$GitRootDirectoryAbsPath/mathematica/$GitRootDirectoryName.m" `
    -OldText "$DefaultGitRootDirectoryName" `
    -NewText "$GitRootDirectoryName"

Write-Host "`nInitialization completed successfully." -ForegroundColor Green



#function Write-Section
#{
#    param (
#        [string]$Message = "",
#        [ConsoleColor]$Color = 'Magenta'
#    )
#    Write-Host "`n==============================================================================" -ForegroundColor $Color
#    Write-Host $Message -ForegroundColor $Color
#}
#
#$ErrorActionPreference = "Stop"
#$InitialWorkingDirectory = Get-Location
#Write-Section "Initial working directory: $InitialWorkingDirectory" -Color Gray
#
#Write-Section "Setting working directory to PSScriptRoot: $PSScriptRoot" -Color Gray
#Set-Location -Path $PSScriptRoot
#
#Write-Section "Determining the root latex file ..." -Color Gray
#$LatexFileName = (Get-ChildItem -Filter "*.tex" | Select-Object -First 1).BaseName
#Write-Section "LaTeX file name: $LatexFileName"
#
#Write-Section "Determining the root bibtex file ..." -Color Gray
#$BibtexFileName = (Get-ChildItem -Filter "*.bib" | Select-Object -First 1).BaseName
#Write-Section "BibTeX file name: $BibtexFileName"
#
#Write-Section "Determining the name or root GIT repository ..." -Color Gray
#$GitRootDirectory = (Get-Item $PSScriptRoot).Parent.Name
#Write-Section "New name for LaTeX and BibTeX files: $GitRootDirectory"
#
#Write-Section "Renaming LaTeX file ..." -Color Gray
#Write-Section "Old LaTeX file name: $LatexFileName.tex" -Color Gray
#Write-Section "New LaTeX file name: $GitRootDirectory.tex"
#Rename-Item -Path "$LatexFileName.tex" -NewName "$GitRootDirectory.tex"
#Write-Section "LaTeX file renamed successfully!" -Color Green
#
#Write-Section "Renaming BibTeX file ..."
#Write-Section "Old BibTeX file name: $BibtexFileName.bib" -Color Gray
#Write-Section "New BibTeX file name: $GitRootDirectory.bib"
#Rename-Item -Path "$BibtexFileName.bib" -NewName "$GitRootDirectory.bib"
#Write-Section "BibTeX file renamed successfully!" -Color Green
#
#Write-Section "Patching LaTeX file with new BibTeX file name ..." -Color Gray
#$LatexFileContent = Get-Content -Path "$GitRootDirectory.tex"
#Write-Section "Old BibTeX file name: $BibtexFileName"
#Write-Section "New BibTeX file name: $GitRootDirectory" -Color Gray
#$LatexFileContent = $LatexFileContent -replace "$BibtexFileName", "$GitRootDirectory"
#$LatexFileContent | Set-Content "$GitRootDirectory.tex"
#Write-Section "Successfully patched LaTeX file with new BibTeX file!" -Color Green
#
#Write-Section "Patching Github Actions ..." -Color Gray
#$BuildActionFile = "build-pdf.yml"
#$BuildActionFilePath = "../.github/workflows/$BuildActionFile"
#$BuildActionFileContent = Get-Content -Path $BuildActionFilePath
#Write-Section "Initial build action content:"
#$BuildActionFileContent
#Write-Section "Patching build action ..." -Color Gray
#$BuildActionFileContent = $BuildActionFileContent -replace "$LatexFileName", "$GitRootDirectory"
#$BuildActionFileContent | Set-Content $BuildActionFilePath
#Write-Section "Patched build action content:"
#$BuildActionFileContent
#Write-Section "Successfully patched build action!" -Color Green
#
#$DeployActionFileName = "build-and-deploy-pdf.yml"
#$DeployActionFilePath = "../.github/workflows/$DeployActionFileName"
#$DeployActionFileConent = Get-Content -Path $DeployActionFilePath
#Write-Section "Initial deploy action content:"
#$DeployActionFileConent
#Write-Section "Patching deploy action ..." -Color Gray
#$DeployActionFileConent = $DeployActionFileConent -replace "$LatexFileName", "$GitRootDirectory"
#$DeployActionFileConent | Set-Content $DeployActionFilePath
#
#Write-Section "Patched deploy action content:"
#$DeployActionFileConent
#Write-Section "Successfully patched deploy action!" -Color Green
#
#Write-Section "Renaming Mathematica files ..." -Color Gray
#
#$MathematicaProgramsFolder = "../mathematica"
#$MathematicaPackageFilePath = "$MathematicaProgramsFolder/$LatexFileName.m"
#$MathematicaNotebookFilePath = "$MathematicaProgramsFolder/$LatexFileName.nb"
#Rename-Item -Path "$MathematicaPackageFilePath" -NewName "$GitRootDirectory.m"
#Rename-Item -Path "$MathematicaNotebookFilePath" -NewName "$GitRootDirectory.nb"
#
#Write-Section "Successfully renamed Mathematica files!" -Color Green
#
#Write-Section "Changing Powershell directory to $InitialWorkingDirectory ... " -Color Gray
#Set-Location $InitialWorkingDirectory
#
#$OutputFolder = "..\out\*"
#Write-Section "Cleaning output folder: $OutputFolder"  -Color Gray
#Remove-Item -Path $OutputFolder -Recurse -Force
#Write-Section "Succesfully cleaned the output folder." -Color Green
#
#Write-Section "Deleting renovate configs..."
#$RenovateConfigPath = "../renovate.json"
#$RenovateLicensePath = "../renovate.json.license"
#
#try
#{
#    Remove-Item -Path $RenovateConfigPath -Recurse -Force
#    Remove-Item -Path $RenovateLicensePath -Recurse -Force
#}
#catch
#{
#    Write-Host $_
#    Write-Host "Skipping renovate deletion..."
#}
#
#Write-Section "Fix encoding ..."
#
#.\..\scripts\Test-Encoding.ps1 -Autofix
#
#Write-Host "Fix encoding is complete." -ForegroundColor Green
#
#Write-Section "Execution has been completed succesfully: $LASTEXITCODE" -Color Green
