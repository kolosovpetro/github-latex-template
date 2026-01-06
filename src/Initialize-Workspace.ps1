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

$TempReplaceUrlOld = "kolosovpetro/github-latex-template/.github/workflows/"
$TempReplaceUrlNew = "kolosovpetro/TEMP/.github/workflows/"

Write-Host "Temp replace action template URL"
Write-Host "Old URL: $TempReplaceUrlOld"
Write-Host "New URL: $TempReplaceUrlNew"

foreach ($file in $workflowFiles)
{
    Write-Host "Temp replace action template URL"
    Write-Host "Old URL: $TempReplaceUrlOld"
    Write-Host "New URL: $TempReplaceUrlNew"
    Write-Host "Processing the file: $file"

    Replace-TextInFile `
        -FilePath $file `
        -OldText $TempReplaceUrlOld `
        -NewText $TempReplaceUrlNew `
}

foreach ($file in $workflowFiles)
{
    Replace-TextInFile `
        -FilePath $file `
        -OldText $DefaultGitRootDirectoryName `
        -NewText $GitRootDirectoryName
}

foreach ($file in $workflowFiles)
{
    Write-Host "Updating action tamplate URL..."
    Write-Host "File: $file"

    Replace-TextInFile `
        -FilePath $file `
        -OldText $TempReplaceUrlNew `
        -NewText $TempReplaceUrlOld `
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

# ----------------------------------------------------------------------
# 10. Delete renovate configs
# ----------------------------------------------------------------------

Write-Host "Removing renovate configs ..."

$RenoveteConfig = "$GitRootDirectoryAbsPath/renovate.json"
$RenoveteLicense = "$GitRootDirectoryAbsPath/renovate.json.license"

$renovate = @($RenoveteConfig, $RenoveteLicense)

foreach ($file in $renovate) 
{
    if (Test-Path $file) {
        Write-Host "Removing: $file ..."
        Remove-Item $file
        continue
    }

    Write-Host "Skipping non-existing file: $file ..."
}

# ----------------------------------------------------------------------
# 11. Delete unnecessary GitHub actions templates
# ----------------------------------------------------------------------

Write-Host "Removing unnecessary GitHub actions templates ..."

$BuildTemplate = "$GitRootDirectoryAbsPath/.github/workflows/build-pdf-template.yml"
$DeployTemplate = "$GitRootDirectoryAbsPath/.github/workflows/build-and-deploy-pdf-template.yml"

$actions = @($BuildTemplate, $DeployTemplate)

foreach ($file in $actions) 
{
    if (Test-Path $file) {
        Write-Host "Removing: $file ..."
        Remove-Item $file
        continue
    }

    Write-Host "Skipping non-existing file: $file ..."
}

Write-Host "`nInitialization completed successfully." -ForegroundColor Green
