function Build-Latex
{
    param (
        [string]$OutputDirectory = "..\out",
        [Boolean]$ShouldCompileBibtex = $true
    )

    try
    {
        $InitialDirectory = Get-Location

        Write-Host "Initial working directory: $InitialDirectory"  -ForegroundColor Magenta
        Write-Host "Setting working directory to PSScriptRoot: $PSScriptRoot"  -ForegroundColor Magenta

        Set-Location -Path $PSScriptRoot

        Write-Dash

        Write-Host "Determining the root latex file to build ..."

        $LatexFileName = (Get-ChildItem -Filter "*.tex" | Select-Object -First 1).BaseName

        Write-Host "Latex file: $LatexFileName"  -ForegroundColor Magenta

        $OutputDirectoryAbsPath = (Resolve-Path $OutputDirectory).Path
        $LatexFileAbsPath = (Resolve-Path "$LatexFileName.tex").Path
        $AuxDirectoryAbsPath = $OutputDirectoryAbsPath

        Write-Dash

        Write-Host "Compiling $LatexFileName first time... "  -ForegroundColor Magenta

        Compile-Latex -LatexFileAbsPath $LatexFileAbsPath `
              -OutputDirectoryAbsPath $OutputDirectoryAbsPath `
              -AuxDirectoryAbsPath $AuxDirectoryAbsPath

        if ($ShouldCompileBibtex -eq $true)
        {
            Write-Dash

            Write-Host "Compiling bibtex ... "  -ForegroundColor Magenta

            Compile-Bibtex -OutputDirectoryAbsPath $OutputDirectoryAbsPath -LatexFileName $LatexFileName
        }

        Write-Dash

        Write-Host "Compiling $LatexFileName second time... "  -ForegroundColor Magenta

        Compile-Latex -LatexFileAbsPath $LatexFileAbsPath `
              -OutputDirectoryAbsPath $OutputDirectoryAbsPath `
              -AuxDirectoryAbsPath $AuxDirectoryAbsPath

        Write-Dash

        Write-Host "Compiling $LatexFileName third time... "  -ForegroundColor Magenta

        Compile-Latex -LatexFileAbsPath $LatexFileAbsPath `
              -OutputDirectoryAbsPath $OutputDirectoryAbsPath `
              -AuxDirectoryAbsPath $AuxDirectoryAbsPath

        Write-Dash

        Write-Host "Build complete!" -ForegroundColor Green
        Write-Host "Exit Code: $LASTEXITCODE" -ForegroundColor Green
        Write-Host "Changing Powershell Directory to $InitialDirectory ... " -ForegroundColor Green

        Set-Location $InitialDirectory

        .\..\scripts\Test-Encoding.ps1 -Autofix

        Write-Host "Fix encoding is complete." -ForegroundColor Green
        Write-Host "Exit Code: $LASTEXITCODE" -ForegroundColor Green
        Write-Host "Changing Powershell Directory to $InitialDirectory ... " -ForegroundColor Green
    }
    catch
    {
        Set-Location $InitialDirectory
        Write-Error "Latex error appeared. Inspect the logs."
    }
}

function Write-Dash
{
    Write-Host "==============================================================================" -ForegroundColor Cyan
}


function Compile-Latex
{
    param(
        [string] $LatexFileAbsPath,
        [string] $OutputDirectoryAbsPath,
        [string] $AuxDirectoryAbsPath
    )

    Write-Host "Latex file absolute path: $LatexFileAbsPath" -ForegroundColor Magenta
    Write-Host "Output directory absolute path: $OutputDirectoryAbsPath" -ForegroundColor Magenta
    Write-Host "Aux directory absolute path: $AuxDirectoryAbsPath" -ForegroundColor Magenta

    pdflatex -file-line-error -halt-on-error -interaction="nonstopmode" -synctex="1" -output-format="pdf" `
             -output-directory="$OutputDirectoryAbsPath" `
             -aux-directory="$AuxDirectoryAbsPath" $LatexFileAbsPath

    if ($LASTEXITCODE -ne 0)
    {
        throw "Latex error appeared. Inspect the logs."
    }
}

function Compile-Bibtex
{
    param(
        [string]$OutputDirectoryAbsPath,
        [string]$LatexFileName
    )

    $WorkingDirectoryForBibtex = "$OutputDirectoryAbsPath\$LatexFileName"

    Write-Host "Bibtex absolute path: $WorkingDirectoryForBibtex" -ForegroundColor Magenta

    bibtex "$WorkingDirectoryForBibtex"

    if ($LASTEXITCODE -ne 0)
    {
        throw "Bibtex error appeared. Inspect the logs."
    }
}

Build-Latex
