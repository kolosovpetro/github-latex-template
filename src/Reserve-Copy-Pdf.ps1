param(
    [string]$FileName = "NewtonsInterpolationFormulaAndSumsOfPowers"
)

$RootDirectory = "$PSScriptRoot/.."

Set-Location $RootDirectory

$SourcePath = "$RootDirectory/out/$FileName.pdf"
$DestinationPath = "$RootDirectory/out/$FileName.annotated.pdf"

Copy-Item -Path $SourcePath -Destination $DestinationPath -Force