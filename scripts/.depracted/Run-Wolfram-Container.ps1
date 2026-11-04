param (
    [string]$MathematicaFileName = "ValidateMultifoldSumsOfPowers.txt"
)

$ErrorActionPreference = "Stop"
$currentLocation = Get-Location

Set-Location $PSScriptRoot

$scriptCode = Get-Content $MathematicaFileName -Raw

Write-Host "================================================= $MathematicaFileName =================================================" -ForegroundColor Magenta

docker run --rm `
-v ${PWD}\Licensing:/home/wolframengine/.WolframEngine/Licensing `
wolframresearch/wolframengine:15.0 `
wolframscript -code $scriptCode

Write-Host "================================================= $MathematicaFileName =================================================" -ForegroundColor Magenta

Set-Location $currentLocation