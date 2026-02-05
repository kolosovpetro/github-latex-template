(* ::Package:: *)

BeginPackage["NewtonsInterpolationFormulaAndSumsOfPowers`"]

(* BEGIN: Newton's series and sums of powers package *)
FiniteDifferenceOfPowerOrderN::usage=""
BackwardFiniteDifferenceOfPowerOrderN::usage=""
CentralDifference::usage=""

OrdinarySumsOfPowersViaNewtonsSeries::usage="Validates Proposition \\label{prop:ordinary-sums-of-powers-via-newtons-series}"
ValidateOrdinarySumsOfPowersViaNewtonsSeries::usage="Validates Proposition \\label{prop:ordinary-sums-of-powers-via-newtons-series}"

DoubleSumsOfPowersViaNewtonsSeries::usage="Validates Proposition prop:double-sums-of-powers-via-newtons-series"
ValidateDoubleSumsOfPowersViaNewtonsSeries::usage="Validates Proposition prop:double-sums-of-powers-via-newtons-series"

MultifoldSumOfPowersRecurrence::usage="Computes $\\KnuthRFoldSum{r}{n}{m}$"

MultifoldSumsOfPowersViaNewtonsSeries::usage="Validates Theorem~\\eqref{theorem:multifold-sums-of-powers-via-newtons-series}"
ValidateMultifoldSumsOfPowersViaNewtonsSeries::usage="Validates Theorem~\\eqref{theorem:multifold-sums-of-powers-via-newtons-series}"

MultifoldSumsOfPowersViaNewtonsSeries2::usage="Validates Theorem~\\eqref{theorem:multifold-sums-of-powers-via-newtons-series}"
ValidateMultifoldSumsOfPowersViaNewtonsSeries2::usage="Validates Theorem~\\eqref{theorem:multifold-sums-of-powers-via-newtons-series}"

MultifoldSumsOfPowersViaCentralDifferences::usage="Validates Proposition~\\eqref{prop:multifold-sums-of-powers-via-central-differences}"
ValidateMultifoldSumsOfPowersViaCentralDifferences::usage="Validates Proposition~\\eqref{prop:multifold-sums-of-powers-via-central-differences}"

MultifoldSumsOfPowersViaBackwardDifferences::usage="Validates Proposition~\\eqref{prop:multifold-sums-of-powers-via-backward-difference}"
ValidateMultifoldSumsOfPowersViaBackwardDifferences::usage="Validates Proposition~\\eqref{prop:multifold-sums-of-powers-via-backward-difference}"

FiniteDifferencesViaStirlingNumbers::usage="Validates Lemma~\\eqref{lem:finite-differences-via-stirling-numbers}"
FiniteDifferencesViaStirlingNumbersReindexed::usage="Validates Lemma~\\eqref{lem:finite-differences-via-stirling-numbers}"
ValidateFiniteDifferenceViaStirlingNumbers::usage="Validates Lemma~\\eqref{lem:finite-differences-via-stirling-numbers}"

EulerianNumber::usage="Computes Eulerian numbers E(n,k)"
FiniteDifferenceViaEulerianNumbers::usage="Validates Lemma~\\eqref{lem:finite-differences-via-eulerian-numbers}"
ValidateFiniteDifferenceViaEulerianNumbers::usage="Validates Lemma~\\eqref{lem:finite-differences-via-eulerian-numbers}"

MultifoldSumsOfPowersViaStirlingNumbers::usage="Validates Proposition~\\eqref{prop:multifold-sums-of-powers-via-stirling-numbers}"
ValidateMultifoldSumsOfPowersViaStirlingNumbers::usage="Validates Proposition~\\eqref{prop:multifold-sums-of-powers-via-stirling-numbers}"

MultifoldSumsOfPowersViaEulerianNumbers::usage="Validates Proposition~\\eqref{prop:multifold-sums-of-powers-via-eulerian-numbers}"
ValidateMultifoldSumsOfPowersViaEulerianNumbers::usage="Validates Proposition~\\eqref{prop:multifold-sums-of-powers-via-eulerian-numbers}"

MultifoldSumsOfPowersBinomialForm::usage="Validates Proposition~\\eqref{prop:multifold-sums-of-powers-binomial-form}"
ValidateMultifoldSumsOfPowersBinomialForm::usage="Validates Proposition~\\eqref{prop:multifold-sums-of-powers-binomial-form}"

MultifoldSumsOfPowersBinomialFormReindexed::usage="Validates Proposition~\\eqref{prop:multifold-sums-of-powers-binomial-form-reindexed}"
ValidateMultifoldSumsOfPowersBinomialFormReindexed::usage="Validates Proposition~\\eqref{prop:multifold-sums-of-powers-binomial-form-reindexed}"

ValidateMultifoldSumOfZeroPowers::usage=""

(* END: Newton's series and sums of powers package *)

(* TEMP formulas *)
ShiftedHockeyStickIdentityLHS::usage=""
ShiftedHockeyStickIdentityRHS::usage=""
ShiftedHockeyStickIdentityRHS1::usage=""
ShiftedHockeyStickIdentityRHS2::usage=""
ShiftedHockeyStickIdentityRHS3::usage=""
ShiftedHockeyStickIdentityRHS4::usage=""
ShiftedHockeyStickIdentityRHS5::usage=""
ShiftedHockeyStickIdentityLHS1::usage=""
ShiftedHockeyStickIdentityRHS6::usage=""
ShiftedHockeyStickIdentityRHS7::usage=""

TripleSumsOfPowersViaFiniteDifference2::usage=""
TripleSumsOfPowersViaFiniteDifference21::usage=""
TripleSumsOfPowersViaFiniteDifference22::usage=""
TripleSumsOfPowersViaFiniteDifference23::usage=""
TripleSumsOfPowersViaFiniteDifference24::usage=""
(* TEMP formulas *)
(* =========================================================================DOCS END=================================================================== *)

(*BEGIN: Define 0^x = 1 for all x *)
Begin["`Private`"]
Unprotect[Power];
Power[0|0., 0|0.] = 1;
Protect[Power];
(*END: Define 0^x = 1 for all x *)

(* =========================================================================FUNCTIONS BEGIN=========================================================== *)

(* BEGIN: Newton's series and sums of powers package *)
FiniteDifferenceOfPowerOrderN[variable_, exp_, order_]:= Sum[(-1)^(order-j) * Binomial[order, j] * (variable+j)^(exp), {j, 0, order}];
BackwardFiniteDifferenceOfPowerOrderN[variable_, exp_, order_]:= Sum[(-1)^j * Binomial[order, j] * (variable-j)^exp, {j, 0, order}];
CentralDifference[x_, n_, k_] := Sum[(-1)^j * Binomial[k, j] * (x + k/2 -j)^n, {j, 0, k}];

MultifoldSumOfPowersRecurrence[r_, n_, m_]:= 0;
MultifoldSumOfPowersRecurrence[r_, n_, m_]:= n^m /; r==0;
MultifoldSumOfPowersRecurrence[r_, n_, m_]:= Sum[MultifoldSumOfPowersRecurrence[r-1, k, m], {k, 1, n}] /; r>0;

OrdinarySumsOfPowersViaNewtonsSeries[n_, m_, t_]:= Sum[FiniteDifferenceOfPowerOrderN[t, m, j] * ((-1)^j * Binomial[j+t-1, j+1] + Binomial[n-t+1, j+1]), {j, 0, m}];
ValidateOrdinarySumsOfPowersViaNewtonsSeries[max_]:= Table[MultifoldSumOfPowersRecurrence[1, n, m] - OrdinarySumsOfPowersViaNewtonsSeries[n, m, t], {n, 0, max}, {m, 0, max}, {t, 0, max}] //Flatten

DoubleSumsOfPowersViaNewtonsSeries[n_, m_, t_] := Sum[FiniteDifferenceOfPowerOrderN[t, m, j] * ((-1)^j * Binomial[j+t-1, j+1] * n + (-1)^(j+1)* Binomial[j+t-1, j+2] + Binomial[n-t+2, j+2]), {j, 0, m}];
ValidateDoubleSumsOfPowersViaNewtonsSeries[max_] := Table[MultifoldSumOfPowersRecurrence[2, n, m] - DoubleSumsOfPowersViaNewtonsSeries[n, m, t], {n, 0, max}, {m, 0, max}, {t, 0, max}] //Flatten

FiniteDifferencesViaStirlingNumbers[n_, k_, x_]:= Sum[Binomial[x, t-k] * StirlingS2[n, t] * t!, {t, 0, n}];
FiniteDifferencesViaStirlingNumbersReindexed[n_, k_, x_]:= Sum[Binomial[x, t] * StirlingS2[n, k+t] * (k+t)!, {t, 0, n}];
ValidateFiniteDifferenceViaStirlingNumbers[t_]:= Table[FiniteDifferencesViaStirlingNumbersReindexed[n,k, t] - FiniteDifferenceOfPowerOrderN[t, n,k], {n, 0, 20}, {k, 0, n}] //Flatten

MultifoldSumsOfPowersViaNewtonsSeries[r_, n_, m_, t_] := 
Sum[FiniteDifferenceOfPowerOrderN[t, m, j] * (Binomial[n-t+r, j+r] + Sum[(-1)^(j+s-1) * Binomial[j+t-1, j+s] * MultifoldSumOfPowersRecurrence[r-s, n, 0], {s, 1, r}]), {j, 0, m}];
ValidateMultifoldSumsOfPowersViaNewtonsSeries[r_] := Table[MultifoldSumOfPowersRecurrence[r,n,m]-MultifoldSumsOfPowersViaNewtonsSeries[r,n,m,t],{n,0,10},{m,0,10},{t,0,n}]//Flatten

MultifoldSumsOfPowersViaNewtonsSeries2[r_, n_, m_, t_] := 
Sum[FiniteDifferenceOfPowerOrderN[t, m, j] * (Binomial[n-t+r, j+r] - Sum[Binomial[s-t, j+s] * MultifoldSumOfPowersRecurrence[r-s, n, 0], {s, 1, r}]), {j, 0, m}];
ValidateMultifoldSumsOfPowersViaNewtonsSeries2[r_] := Table[MultifoldSumOfPowersRecurrence[r,n,m]-MultifoldSumsOfPowersViaNewtonsSeries[r,n,m,t],{n,0,10},{m,0,10},{t,0,n}]//Flatten

EulerianNumber[0, 0] = 1;
EulerianNumber[n_, k_] /; k < 0 || k >= n := 0;
EulerianNumber[n_, k_] := EulerianNumber[n, k] =(k + 1) EulerianNumber[n - 1, k] + (n - k) EulerianNumber[n - 1, k - 1];

FiniteDifferenceViaEulerianNumbers[m_, j_, t_]:= Sum[EulerianNumber[m,k]* Binomial[t+k, m-j], {k, 0, m}];
ValidateFiniteDifferenceViaEulerianNumbers[t_]:=Table[FiniteDifferenceViaEulerianNumbers[n,k, t]-FiniteDifferenceOfPowerOrderN[t, n,k], {n, 0, 20}, {k, 0, n}] //Flatten

MultifoldSumsOfPowersViaCentralDifferences[r_, n_, m_, t_] := 
Sum[CentralDifference[t+j/2, m, j] * (Binomial[n-t+r, j+r] + Sum[(-1)^(j+s-1) * Binomial[j+t-1, j+s]*MultifoldSumOfPowersRecurrence[r-s, n, 0], {s, 1, r}]), {j, 0, m}];
ValidateMultifoldSumsOfPowersViaCentralDifferences[r_] := Table[MultifoldSumOfPowersRecurrence[r,n,m]-MultifoldSumsOfPowersViaCentralDifferences[r,n,m,t],{n,0,10},{m,0,10},{t,0,n}]//Flatten

MultifoldSumsOfPowersViaBackwardDifferences[r_, n_, m_, t_]:= 
Sum[BackwardFiniteDifferenceOfPowerOrderN[t+j, m, j] * (Binomial[n-t+r, j+r] + Sum[(-1)^(j+s-1) * Binomial[j+t-1, j+s] * MultifoldSumOfPowersRecurrence[r-s, n, 0], {s, 1, r}]), {j, 0, m}];
ValidateMultifoldSumsOfPowersViaBackwardDifferences[r_] := Table[MultifoldSumOfPowersRecurrence[r,n,m]-MultifoldSumsOfPowersViaBackwardDifferences[r,n,m,t],{n,0,10},{m,0,10},{t,0,n}]//Flatten

MultifoldSumsOfPowersViaStirlingNumbers[r_, n_, m_, t_]:= 
Sum[FiniteDifferencesViaStirlingNumbersReindexed[m,j,t] * (Binomial[n-t+r, j+r] + Sum[(-1)^(j+s-1) * Binomial[j+t-1, j+s]*MultifoldSumOfPowersRecurrence[r-s, n, 0], {s, 1, r}]), {j, 0, m}];
ValidateMultifoldSumsOfPowersViaStirlingNumbers[r_] := Table[MultifoldSumOfPowersRecurrence[r,n,m]-MultifoldSumsOfPowersViaStirlingNumbers[r,n,m,t],{n,0,10},{m,0,10},{t,0,n}]//Flatten

MultifoldSumsOfPowersViaEulerianNumbers[r_, n_, m_, t_]:= 
Sum[FiniteDifferenceViaEulerianNumbers[m,j,t] * (Binomial[n-t+r, j+r] + Sum[(-1)^(j+s-1) * Binomial[j+t-1, j+s]*MultifoldSumOfPowersRecurrence[r-s, n, 0], {s, 1, r}]), {j, 0, m}];
ValidateMultifoldSumsOfPowersViaEulerianNumbers[r_] := Table[MultifoldSumOfPowersRecurrence[r,n,m]-MultifoldSumsOfPowersViaEulerianNumbers[r,n,m,t],{n,0,10},{m,0,10},{t,0,n}]//Flatten

MultifoldSumsOfPowersBinomialForm[r_, n_, m_, t_]:= 
Sum[FiniteDifferenceOfPowerOrderN[t, m, j] * (Binomial[n-t+r, j+r] + Sum[(-1)^(j+s-1) * Binomial[j+t-1, j+s]* Binomial[r-s+n-1, r-s], {s, 1, r}]), {j, 0, m}];
ValidateMultifoldSumsOfPowersBinomialForm[r_] := Table[MultifoldSumOfPowersRecurrence[r,n,m]-MultifoldSumsOfPowersBinomialForm[r,n,m,t],{n,0,10},{m,0,10},{t,0,n}]//Flatten

MultifoldSumsOfPowersBinomialFormReindexed[r_, n_, m_, t_]:= 
Sum[FiniteDifferenceOfPowerOrderN[t, m, j] * (Binomial[n-t+r, j+r] + Sum[(-1)^(j+s) * Binomial[j+t-1, j+s+1]* Binomial[r-s+n-2, r-s-1], {s, 0, r-1}]), {j, 0, m}];
ValidateMultifoldSumsOfPowersBinomialFormReindexed[r_] := Table[MultifoldSumOfPowersRecurrence[r,n,m]-MultifoldSumsOfPowersBinomialFormReindexed[r,n,m,t],{n,0,10},{m,0,10},{t,0,n}]//Flatten
ValidateMultifoldSumOfZeroPowers[max_] := Table[MultifoldSumOfPowersRecurrence[r, n, 0] - Binomial[r+n-1, r], {r, 0, max}, {n, 0, max}]//Flatten
(* END: Newton's series and sums of powers *)

(* Some TEMP formulas *)

ShiftedHockeyStickIdentityLHS[t_, j_, n_]:= Sum[Binomial[-t+k, j], {k, 0, n}];
ShiftedHockeyStickIdentityRHS[t_, j_, n_]:= Sum[Binomial[-t+k, j], {k, 0, t-1}] + Sum[Binomial[-t+k, j], {k, t, n}];
ShiftedHockeyStickIdentityRHS1[t_, j_, n_]:= Sum[Binomial[-k-1, j], {k, 0, t-1}] + Sum[Binomial[-t+k, j], {k, t, n}];
ShiftedHockeyStickIdentityRHS2[t_, j_, n_]:= (-1)^j * Sum[Binomial[j+k, j], {k, 0, t-1}] + Sum[Binomial[-t+k, j], {k, t, n}];
ShiftedHockeyStickIdentityRHS3[t_, j_, n_]:= (-1)^j * Binomial[j+t, j+1] + Sum[Binomial[-t+k, j], {k, t, n}];
ShiftedHockeyStickIdentityRHS4[t_, j_, n_]:= (-1)^j * Binomial[j+t, j+1] + Sum[Binomial[k, j], {k, 0, n-t}];
ShiftedHockeyStickIdentityRHS5[t_, j_, n_]:= (-1)^j * Binomial[j+t, j+1] + Binomial[n-t+1, j+1];
ShiftedHockeyStickIdentityLHS1[t_, j_, n_]:= Sum[Binomial[-t+k, j], {k, 1, n}];
ShiftedHockeyStickIdentityRHS6[t_, j_, n_]:= Sum[Binomial[-t+k+1, j], {k, 0, n-1}];
ShiftedHockeyStickIdentityRHS7[t_, j_, n_]:= (-1)^(j)*Binomial[j+t-1, j+1] + Binomial[n-t+1, j+1];

TripleSumsOfPowersViaFiniteDifference2[n_, t_, m_] := Sum[FiniteDifferenceOfPowerOrderN[t, m, j] * Sum[(-1)^j * Binomial[j+t-1, j+1] k^1 + (-1)^(j+1) * Binomial[j+t-1, j+2]*k^0 + Binomial[k-t+2, j+2], {k, 1, n}], {j, 0, m}];
TripleSumsOfPowersViaFiniteDifference21[n_, t_, m_] := Sum[FiniteDifferenceOfPowerOrderN[t, m, j] * (-1)^j * Binomial[j+t-1, j+1] * MultifoldSumOfPowersRecurrence[2, n, 0] + (-1)^(j+1) * Binomial[j+t-1, j+2]* MultifoldSumOfPowersRecurrence[1, n, 0] + (-1)^(j+2) * Binomial[j+t-1, j+3] * MultifoldSumOfPowersRecurrence[0, n, 0] + Binomial[n-t+3, j+3], {j, 0, m}];
TripleSumsOfPowersViaFiniteDifference22[n_, t_, m_] :=
Sum[
  FiniteDifferenceOfPowerOrderN[t, m, j]*
   Sum[
    (-1)^j*Binomial[j + t - 1, j + 1]*k +
    (-1)^(j + 1)*Binomial[j + t - 1, j + 2] +
    Binomial[k - t + 2, j + 2],
    {k, 1, n}
   ],
  {j, 0, m}
];
TripleSumsOfPowersViaFiniteDifference23[n_, t_, m_] := Sum[FiniteDifferenceOfPowerOrderN[t, m, j] * ((-1)^j * Binomial[j+t-1, j+1] * (1/2*(n^2+n)) + (-1)^(j+1) * Binomial[j+t-1, j+2]*n + (-1)^(j+2) * Binomial[j+t-1, j+3] + Binomial[n-t+3, j+3]), {j, 0, m}];
TripleSumsOfPowersViaFiniteDifference24[n_, t_, m_] := Sum[FiniteDifferenceOfPowerOrderN[t, m, j] * ((-1)^j * Binomial[j+t-1, j+1] * MultifoldSumOfPowersRecurrence[2, n, 0] + (-1)^(j+1) * Binomial[j+t-1, j+2]* MultifoldSumOfPowersRecurrence[1, n, 0] + (-1)^(j+2) * Binomial[j+t-1, j+3] * MultifoldSumOfPowersRecurrence[0, n, 0] + Binomial[n-t+3, j+3]), {j, 0, m}];

(* Some TEMP formulas *)

End[ ]
EndPackage[ ]



