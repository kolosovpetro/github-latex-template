param (
    [string]$MathematicaFileName = "ValidateMultifoldSumsOfPowersTheorem.txt"
)

$ErrorActionPreference = "Stop"
$currentLocation = Get-Location

Set-Location $PSScriptRoot

$scriptCode = Get-Content $MathematicaFileName -Raw

wolframscript -code $scriptCode


Set-Location $currentLocation