(* ::Package:: *)

BeginPackage["CentralDifferences`"]

(*BEGIN: Definitions *)
CentralDifference::usage=""
CentralFactorial::usage=""
FallingFactorial::usage=""
CentralFactorialNumber2ndKind::usage=""
RiordanPowerIdentity::usage=""
NewtonsFormulaForCentralDifferencesShifted::usage=""
MultifoldSumOfPowersRecurrence::usage=""

ValidateCentralFactorialsInTermsOfFalling::usage=""

ValidateBinomialFormOfCentralFactorials::usage=""

NewtonsFormulaForPowersInZero::usage=""
ValidateNewtonsFormulaForPowersInZero::usage=""

OrdinarySumsOfOddPowersInCentralDifferences::usage=""
ValidateOrdinarySumsOfOddPowersInCentralDifferences::usage=""

MultifoldSumsOfOddPowersInCentralDifferences::usage=""
ValidateMultifoldSumsOfOddPowersInCentralDifferences::usage=""

NewtonsFormulaForPowers::usage=""
ValidateNewtonsFormulaForPowers::usage=""

PowersInCentralBinomialForm::usage=""
ValidatePowersInCentralBinomialForm::usage=""

EvenPowersInCentralBinomialForm::usage=""

ValidateBinomialDecomposition::usage=""

ValidateCentralBinomialDecomposition::usage=""

CenteredOrdinarySumsOfPowers::usage=""

ValidateCenteredOrdinarySumsOfPowers::usage=""

CenteredDecompositionOfPowerSums::usage=""

ValidateCenteredDecompositionOfPowerSums::usage=""

ValidateCenteredHockeyStickIdentity::usage=""

ClosedFormOfCenteredSumsOfPowers::usage=""

ValidateClosedFormOfCenteredSumsOfPowers::usage=""

SimplifiedCenteredSumsOfPowers::usage=""

ValidateSimplifiedCenteredSumsOfPowers::usage=""

DoubleCenteredSumsOfPowers::usage=""

ValidateDoubleCenteredSumsOfPowers::usage=""

MultifoldCenteredSumsOfPowers::usage=""

ValidateMultifoldCenteredSumsOfPowers::usage=""

ValidateMultifoldSumOfZeroPowers::usage=""

BinomialMultifoldCenteredSumsOfPowers::usage=""

ValidateBinomialMultifoldCenteredSumsOfPowers::usage=""

NegatedBinomialCenteredSumOfPowers::usage=""

ValidateNegatedBinomialCenteredSumOfPowers::usage=""

(*END: Definitions *)

(* =========================================================================DOCS END=================================================================== *)

(*BEGIN: Define 0^x = 1 for all x *)
Begin["`Private`"]
Unprotect[Power];
Power[0|0., 0|0.] = 1;
Protect[Power];
(*END: Define 0^x = 1 for all x *)

(* =========================================================================FUNCTIONS BEGIN=========================================================== *)

(*BEGIN: Definitions *)
MultifoldSumOfPowersRecurrence[r_, n_, m_]:= 0;
MultifoldSumOfPowersRecurrence[r_, n_, m_]:= n^m /; r==0;
MultifoldSumOfPowersRecurrence[r_, n_, m_]:= Sum[MultifoldSumOfPowersRecurrence[r-1, k, m], {k, 1, n}] /; r>0;

CentralDifference[x_, n_, k_] := Sum[(-1)^j * Binomial[k, j] * (x + k/2 -j)^n, {j, 0, k}];

CentralFactorial[x_, k_] := 0 /; k<0;
CentralFactorial[x_, k_] := 1 /; k==0;
CentralFactorial[x_, k_] := x * Product[(x + k/2 -j), {j, 1, k-1}] /; k>0;

FallingFactorial[x_, n_] := Product[x-k, {k, 0, n-1}];

CentralFactorialNumber2ndKind[n_, k_] := 1/k! * CentralDifference[0, n, k];

RiordanPowerIdentity[x_, m_] := Sum[CentralFactorialNumber2ndKind[m,k] * CentralFactorial[x, k], {k, 1, m}];

NewtonsFormulaForCentralDifferencesShifted[x_, h_, n_] := Sum[ 1/k! * CentralDifference[h, n, k] * CentralFactorial[x, k], {k, 0, n}];

ValidateCentralFactorialsInTermsOfFalling[max_] := Table[CentralFactorial[n,k] - n * FallingFactorial[n + k/2 -1, k-1], {n, -max, max}, {k, 1, max}] //Flatten

ValidateBinomialFormOfCentralFactorials[max_] := Table[CentralFactorial[n,k]/ k! - (n/k) * Binomial[n+k/2-1, k-1], {n, -max, max}, {k, 1, max}] //Flatten

NewtonsFormulaForPowersInZero[n_, m_] := Sum[CentralFactorial[n, j] * 1/j! * CentralDifference[0, m, j], {j, 0, m}];

ValidateNewtonsFormulaForPowersInZero[max_] := Table[n^m - NewtonsFormulaForPowersInZero[n, m], {n, 1, max}, {m, 1, max}] //Flatten

OrdinarySumsOfOddPowersInCentralDifferences[n_, m_] := Sum[1/(2k) * Binomial[n+k, 2k] * CentralDifference[0, 2m, 2k], {k, 1, m}];

ValidateOrdinarySumsOfOddPowersInCentralDifferences[max_] := Table[MultifoldSumOfPowersRecurrence[1, n, 2m-1] - OrdinarySumsOfOddPowersInCentralDifferences[n, m], {n,1, max}, {m, 1, max}] //Flatten

MultifoldSumsOfOddPowersInCentralDifferences[r_, n_, m_] := Sum[1/(2k) * Binomial[n+k-1+r, 2k-1+r] * CentralDifference[0, 2m, 2k], {k, 1, m}];
ValidateMultifoldSumsOfOddPowersInCentralDifferences[max_] := Table[MultifoldSumOfPowersRecurrence[r, n, 2m-1] - MultifoldSumsOfOddPowersInCentralDifferences[r, n, m], {n,1, max}, {m, 1, max}, {r, 0, max}] //Flatten

NewtonsFormulaForPowers[n_, m_, t_] := Sum[CentralFactorial[n-t, k] / k! * CentralDifference[t, m, k], {k, 0, m}];
ValidateNewtonsFormulaForPowers[max_] := Table[n^m - NewtonsFormulaForPowers[n, m, t], {n, 0, max}, {m, 0, max}, {t, 0, max}] //Flatten

PowersInCentralBinomialForm[n_, m_, t_] := t^m + Sum[(n-t)/k * Binomial[n-t+k/2-1, k-1] * CentralDifference[t, m, k], {k, 1, m}];
ValidatePowersInCentralBinomialForm[max_] := Table[n^m - PowersInCentralBinomialForm[n, m, t], {n, 0, max}, {m, 0, max}, {t, 0, max}] //Flatten

EvenPowersInCentralBinomialForm[n_, m_, t_] := t^(2m) + Sum[(n-t)/ (2k) * Binomial[n-t+k-1, 2k-1] * CentralDifference[t, 2m, 2k], {k, 1, m}];

ValidateBinomialDecomposition[max_] := Table[n*Binomial[n+r, m]-((m+1)*Binomial[n+r, m+1] - (r-m)* Binomial[n+r,m]), {n, 0, max}, {r, 0, max}, {m, 0, max}] //Flatten

ValidateCentralBinomialDecomposition[max_] := Table[j*Binomial[j-t+k/2-1,k-1]-(k*Binomial[j-t+k/2-1,k]+(t+k/2)*Binomial[j-t+k/2-1,k-1]),{j,0,max},{t,0,max},{k,0,max}]//Flatten

CenteredOrdinarySumsOfPowers[n_, m_, t_] :=
  Sum[t^m, {j, 1, n}] +
  Sum[
    CentralDifference[t, m, k]/k *
      (
        Sum[
          j*Binomial[j - t + k/2 - 1, k - 1],
          {j, 1, n}
        ]
        - t*
        Sum[
          Binomial[j - t + k/2 - 1, k - 1],
          {j, 1, n}
        ]
      ),
    {k, 1, m}
  ];
  
ValidateCenteredOrdinarySumsOfPowers[max_] := Table[MultifoldSumOfPowersRecurrence[1, n, m] - CenteredOrdinarySumsOfPowers[n, m, t], {n, 0, max}, {m, 0, max}, {t, 0, max}] //Flatten

CenteredDecompositionOfPowerSums[n_, m_, t_] :=
  Sum[t^m, {j, 1, n}] +
  Sum[
    CentralDifference[t, m, k] *
      (
        Sum[
          Binomial[j - t + k/2 - 1, k],
          {j, 1, n}
        ]
        + (1/2)*
        Sum[
          Binomial[j - t + k/2 - 1, k - 1],
          {j, 1, n}
        ]
      ),
    {k, 1, m}
  ];
  
ValidateCenteredDecompositionOfPowerSums[max_] := Table[MultifoldSumOfPowersRecurrence[1, n, m] - CenteredDecompositionOfPowerSums[n, m, t], {n, 0, max}, {m, 0, max}, {t, 0, max}] //Flatten
ValidateCenteredHockeyStickIdentity[max_] := Table[Sum[Binomial[j-t+k/2-1,k],{j,1,n}]-(Binomial[n-t+k/2,k+1]-Binomial[-t+k/2,k+1]),{n,0,max},{t,0,max},{k,0,max}]//Flatten

ClosedFormOfCenteredSumsOfPowers[n_, m_, t_] := 
  Sum[t^m, {j, 1, n}] +
  Sum[
    CentralDifference[t, m, k] *
      ( (Binomial[n - t + k/2, k + 1] - Binomial[-t + k/2, k + 1]) +
        (1/2)*(Binomial[n - t + k/2, k] - Binomial[-t + k/2, k])
      ),
    {k, 1, m}
  ];
  
ValidateClosedFormOfCenteredSumsOfPowers[max_] := Table[MultifoldSumOfPowersRecurrence[1, n, m] - ClosedFormOfCenteredSumsOfPowers[n, m, t], {n, 0, max}, {m, 0, max}, {t, 0, max}] //Flatten
SimplifiedCenteredSumsOfPowers[n_, m_, t_] :=
  Sum[t^m, {j, 1, n}] +
  Sum[
    CentralDifference[t, m, k]/2 *
      (
        (Binomial[n - t + k/2 + 1, k + 1] + Binomial[n - t + k/2, k + 1]) -
        (Binomial[-t + k/2, k + 1] + Binomial[-t + k/2 + 1, k + 1])
      ),
    {k, 1, m}
  ];

ValidateSimplifiedCenteredSumsOfPowers[max_] := Table[MultifoldSumOfPowersRecurrence[1, n, m] - SimplifiedCenteredSumsOfPowers[n, m, t], {n, 0, max}, {m, 0, max}, {t, 0, max}] //Flatten

DoubleCenteredSumsOfPowers[n_, m_, t_] :=
  t^m*MultifoldSumOfPowersRecurrence[2, n, 0] +
  Sum[
    CentralDifference[t, m, k]/2 *
      (
        (Binomial[n - t + k/2 + 2, k + 2] +
         Binomial[n - t + k/2 + 1, k + 2])
        -
        (Binomial[-t + k/2 + 2, k + 2] +
         Binomial[-t + k/2 + 1, k + 2])*
          MultifoldSumOfPowersRecurrence[0, n, 0]
        -
        (Binomial[-t + k/2 + 1, k + 1] +
         Binomial[-t + k/2, k + 1])*
          MultifoldSumOfPowersRecurrence[1, n, 0]
      ),
    {k, 1, m}
  ];

ValidateDoubleCenteredSumsOfPowers[max_] := Table[MultifoldSumOfPowersRecurrence[2, n, m] - DoubleCenteredSumsOfPowers[n, m, t], {n, 0, max}, {m, 0, max}, {t, 0, max}] //Flatten

MultifoldCenteredSumsOfPowers[r_, n_, m_, t_] :=
  t^m*MultifoldSumOfPowersRecurrence[r, n, 0] +
  Sum[
    CentralDifference[t, m, k]/2 *
      (
        (Binomial[n - t + k/2 + r, k + r] +
         Binomial[n - t + k/2 + r - 1, k + r])
        -
        Sum[
          (Binomial[-t + k/2 + r - s, k + r - s] +
           Binomial[-t + k/2 + r - s - 1, k + r - s])*
            MultifoldSumOfPowersRecurrence[s, n, 0],
          {s, 0, r - 1}
        ]
      ),
    {k, 1, m}
  ];

ValidateMultifoldCenteredSumsOfPowers[max_] := Table[MultifoldSumOfPowersRecurrence[r, n, m] - MultifoldCenteredSumsOfPowers[r, n, m, t], {n, 0, max}, {m, 0, max}, {t, 0, max}, {r, 0, max}] //Flatten
ValidateMultifoldSumOfZeroPowers[max_] := Table[MultifoldSumOfPowersRecurrence[r, n, 0] - Binomial[r+n-1, r], {r, 0, max}, {n, 0, max}] //Flatten
BinomialMultifoldCenteredSumsOfPowers[r_, n_, m_, t_] :=
  Binomial[r + n - 1, r]*t^m +
  Sum[
    CentralDifference[t, m, k]/2 *
      (
        (Binomial[n - t + k/2 + r, k + r] +
         Binomial[n - t + k/2 + r - 1, k + r])
        -
        Sum[
          (Binomial[-t + k/2 + r - s, k + r - s] +
           Binomial[-t + k/2 + r - s - 1, k + r - s])*
            Binomial[s+ n - 1, s],
          {s, 0, r - 1}
        ]
      ),
    {k, 1, m}
  ];
  
ValidateBinomialMultifoldCenteredSumsOfPowers[max_] := Table[MultifoldSumOfPowersRecurrence[r, n, m] - BinomialMultifoldCenteredSumsOfPowers[r, n, m, t], {n, 0, max}, {m, 0, max}, {t, 0, max}, {r, 0, max}] //Flatten

NegatedBinomialCenteredSumOfPowers[r_, n_, m_, t_] :=
  (-1)^m Binomial[r + n - 1, r] t^m +
  (-1)^m Sum[
    (-1)^k CentralDifference[t, m, k]/2 *
      (
        (
          Binomial[n + t + k/2 + r, k + r] +
          Binomial[n + t + k/2 + r - 1, k + r]
        )
        -
        Sum[
          (
            Binomial[t + k/2 + r - s, k + r - s] +
            Binomial[t + k/2 + r - s - 1, k + r - s]
          ) Binomial[s + n - 1, s],
          {s, 0, r - 1}
        ]
      ),
    {k, 1, m}
  ];

ValidateNegatedBinomialCenteredSumOfPowers[max_] := Table[MultifoldSumOfPowersRecurrence[r, n, m] - NegatedBinomialCenteredSumOfPowers[r, n, m, t], {n, 0, max}, {m, 0, max}, {t, 0, max}, {r, 0, max}] //Flatten

(*END: Definitions *)

End[ ]
EndPackage[ ]



