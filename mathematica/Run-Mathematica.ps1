$ErrorActionPreference = "Stop"
$currentLocation = Get-Location

cd $PSScriptRoot

wolframscript -code '
Get["NewtonsInterpolationFormulaAndSumsOfPowers.m"];

info[msg_] := WriteString["stdout", "\n=== ", msg, " ===\n"];

info["Ordinary sums of powers via Newton series"];
Print @ NewtonsInterpolationFormulaAndSumsOfPowers`ValidateOrdinarySumsOfPowersViaNewtonsSeries[5];

info["Double sums of powers via Newton series"];
Print @ NewtonsInterpolationFormulaAndSumsOfPowers`ValidateDoubleSumsOfPowersViaNewtonsSeries[5];

info["Multifold sums of powers via Newton series"];
Print @ NewtonsInterpolationFormulaAndSumsOfPowers`ValidateMultifoldSumsOfPowersViaNewtonsSeries[5];

info["Finite differences via Stirling numbers"];
Print @ NewtonsInterpolationFormulaAndSumsOfPowers`ValidateFiniteDifferenceViaStirlingNumbers[5];

info["Finite differences via Eulerian numbers"];
Print @ NewtonsInterpolationFormulaAndSumsOfPowers`ValidateFiniteDifferenceViaEulerianNumbers[5];

info["Multifold sums via central differences"];
Print @ NewtonsInterpolationFormulaAndSumsOfPowers`ValidateMultifoldSumsOfPowersViaCentralDifferences[5];

info["Multifold sums via backward differences"];
Print @ NewtonsInterpolationFormulaAndSumsOfPowers`ValidateMultifoldSumsOfPowersViaBackwardDifferences[5];

info["Multifold sums via Stirling numbers"];
Print @ NewtonsInterpolationFormulaAndSumsOfPowers`ValidateMultifoldSumsOfPowersViaStirlingNumbers[5];

info["Multifold sums via Eulerian numbers"];
Print @ NewtonsInterpolationFormulaAndSumsOfPowers`ValidateMultifoldSumsOfPowersViaEulerianNumbers[5];

info["Multifold sums – binomial form"];
Print @ NewtonsInterpolationFormulaAndSumsOfPowers`ValidateMultifoldSumsOfPowersBinomialForm[5];

info["Multifold sums – binomial form (reindexed)"];
Print @ NewtonsInterpolationFormulaAndSumsOfPowers`ValidateMultifoldSumsOfPowersBinomialFormReindexed[5];
'


cd $currentLocation