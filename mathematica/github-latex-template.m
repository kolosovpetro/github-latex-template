(* ::Package:: *)

BeginPackage["github-latex-template`"]

(*BEGIN: Definitions *)
A::usage="A[n, k] returns the real coefficient A of non-negative integers n, k such that n <= k."
PrintTriangleA::usage="PrintTriangleA[m] prints triangle of coefficients A for given non negative integer m."
OddPowerIdentity::usage="Validates odd power identity."
OddPowerIdentitySimplified::usage="Validates odd power identity expanded form."
BivariateSumT::usage="Defines bivariate sum T(m,n,k)."
TriangleFormBivariateSumT::usage="Prints Tm in the form of triangle."
TableFormBivariateSumT::usage="Prints Tm in the form of table."
T::usage="Coefficient T(d,r) see Application 2: Examples of coefficients A."
(*END: Definitions *)

(*BEGIN: Faulhaber's coefficients *)
FaulhaberCoefficients::usage="Faulhaber coefficients https://arxiv.org/pdf/math/9207222 page 14."
(*END: Faulhaber's coefficients *)

(*BEGIN: Forward decompositions *)
ForwardRecurrenceForT::usage="Validates the forward recurrence for the bivariate sum T(m,n,k)."
OddPowerForwardDecomposition::usage="Validates the identity Odd power forward decomposition."
OddPowerForwardDecompositionMMinus1::usage="Validates the identity Odd power forward decomposition m-1."
OddPowerForwardDecompositionMMinus1Shifted::usage="Validates the identity Odd power forward decomposition m-1 shifted."
OddPowerForwardDecompositionShifted::usage="Validates the identity Odd power forward decomposition shifted."
TableFormForwardRecurrenceForT::usage="Prints the forward recurrence for Tm in the form of triangle."
(*END: Forward decompositions *)

(*BEGIN: Forward decompositions multifold *)
ForwardRecurrenceForTMultifold::usage="Validates the multifold forward recurrence for the bivariate sum T(m,n,k)."
OddPowerForwardDecompositionMultifold::usage=""
OddPowerForwardDecompositionMMinus1Multifold::usage=""
OddPowerForwardDecompositionShiftedMultifold::usage=""
OddPowerForwardDecompositionMMinus1ShiftedMultifold::usage=""
TableFormForwardRecurrenceForTMultifold::usage="Prints the multifold forward recurrence for Tm in the form of triangle."
(*END: Forward decompositions multifold *)

(*BEGIN: Backward decompositions *)
BackwardRecurrenceForT::usage="Validates the backward recurrence for the bivariate sum T(m,n,k)."
OddPowerBackwardDecomposition::usage="Validates the identity Odd power backward decomposition."
OddPowerBackwardDecompositionShifted::usage="Validates the identity Odd power backward decomposition shifted."
OddPowerBackwardDecompositionMMinus1::usage="Validates the identity Odd power backward decomposition m-1."
OddPowerBackwardDecompositionMMinus1Shifted::usage="Validates the identity Odd power backward decomposition m-1 shifted."
TableFormBackwardRecurrenceForT::usage="Prints the backward recurrence for Tm in the form of triangle."
(*END: Backward decompositions *)

(*BEGIN: Backward decompositions multifold *)
BackwardRecurrenceForTMultifold::usage="Validates the multifold backward recurrence for the bivariate sum T(m,n,k)."
OddPowerBackwardDecompositionMultifold::usage=""
OddPowerBackwardDecompositionShiftedMultifold::usage=""
OddPowerBackwardDecompositionMMinus1Multifold::usage=""
OddPowerBackwardDecompositionMMinus1ShiftedMultifold::usage=""
TableFormBackwardRecurrenceForTMultifold::usage="Prints the multifold backward recurrence for Tm in the form of triangle."
(*END: Backward decompositions multifold *)

(*BEGIN: Central decompositions *)
CentralRecurrenceForT::usage="Validates the central recurrence for the bivariate sum T(m,n,k)."
OddPowerCentralDecomposition::usage="Validates the identity Odd power central decomposition."
TableFormCentralRecurrenceForT::usage="Prints the central recurrence for Tm in the form of triangle."
(*END: Central decompositions *)

(*BEGIN: Sums of powers *)
SumsOfPowers::usage=""
SumsOfOddPowers::usage=""
SumsOfOddPowersRearranged::usage=""
SumsOfOddPowersReindexed::usage=""
SumsOfOddPowersTriple::usage=""
(*END: Sums of powers *)

(*BEGIN: Binomial Forms *)
BinomialForm::usage="Validates the identity Binomial form."
ShiftedBinomialForm::usage="Validates the identity Shifted binomial form."
CenteredBinomialForm::usage="Validates the identity Centered binomial form."
ShiftedCenteredBinomialForm::usage="Validates the identity Shifted centered binomial form."
NegatedBinomialForm::usage="Validates the identity Negated binomial form."
ShiftedNegatedBinomialForm::usage="Validates the identity Shifted negated binomial form."
CenteredNegatedBinomialForm::usage="Validates the identity Centered negated binomial form."
ShiftedCenteredNegatedBinomialForm::usage="Validates the identity Shifted centered negated binomial form."
(*END: Binomial Forms *)

(*BEGIN: Double bivariate identities *)
DoubleBivariateSumR::usage="Defines the Double bivaraite sum Rm."
OddPowerDoubleBivariate::usage="Verifies odd power double bivariate proposition 4.39."
OddPowerDoubleBivariateMultifold::usage="Verifies odd power double bivariate proposition 4.41."
OddPowerDoubleBivariateNegated::usage="Verifies odd power double bivariate negated proposition 4.40."
OddPowerDoubleBivariateNegatedMultifold::usage="Verifies odd power double bivariate negated proposition 4.42."
(*END: Double bivariate identities *)

(*BEGIN: Bivariate Faulhaber's formula *)
SumOfConvolvedPowers::usage=""
BivaraiteFaulhabersFormula::usage=""
(*END: Bivariate Faulhaber's formula *)
(* =========================================================================DOCS END=================================================================== *)

(*BEGIN: Define 0^x = 1 for all x *)
Begin["`Private`"]
Unprotect[Power];
Power[0|0., 0|0.] = 1;
Protect[Power];
(*END: Define 0^x = 1 for all x *)

(* =========================================================================FUNCTIONS BEGIN=========================================================== *)

(*BEGIN: Definitions *)
A[n_, k_] := 0;
A[n_, k_] := (2k + 1) * Binomial[2k, k] * Sum[A[n, j] * Binomial[j, 2k + 1] * (-1)^(j - 1) / (j - k) * BernoulliB[2j - 2k], {j, 2k + 1, n}] /; 0 <= k < n;
A[n_, k_] := (2n + 1) * Binomial[2n, n] /; k == n;
PrintTriangleA[m_]:= TableForm[Table[A[n, k], {n, 0, m}, {k, 0, n}], TableAlignments -> Left];
OddPowerIdentity[n_, m_]:= Sum[Sum[A[m,r] * k^r * (n-k)^r, {k, 1, n}], {r, 0, m}];
OddPowerIdentitySimplified[n_, m_]:= Expand[Sum[Sum[A[m,r] * k^r * (n-k)^r, {k, 1, n}], {r, 0, m}]];
BivariateSumT[m_, n_, k_]:= Sum[A[m, r] * k^r (n-k)^r, {r, 0, m}];
TriangleFormBivariateSumT[m_, rows_]:= TableForm[Table[BivariateSumT[m, n, k], {n, 0, rows}, {k, 0, n}], TableAlignments -> Left];
TableFormBivariateSumT[m_, rows_, columns_]:= TableForm[Table[BivariateSumT[m, n, k], {n, 0, rows}, {k, 0, columns}], TableAlignments -> Left];
T[d_,r_]:= (2r+1) * Binomial[2r,r] * Binomial[d, 2r+1] * (-1)^(d-1)/(d-r) * BernoulliB[2d-2r];
(*END: Definitions *)

(*BEGIN: Faulhaber's coefficients *)
FaulhaberCoefficients[n_, k_]:= 0;
FaulhaberCoefficients[n_, k_]:= (-1)^(n-k) * Sum[Binomial[2n, n-k-j]* Binomial[n-k+j, j] * (n-k-j)/(n-k+j) * BernoulliB[n+k+j], {j, 0, n-k}] /; 0 <= k < n;
FaulhaberCoefficients[n_, k_]:= BernoulliB[2n] /; k == n;
(*END: Faulhaber's coefficients *)

(*BEGIN: Forward decompositions *)
ForwardRecurrenceForT[m_, n_, k_]:= Sum[(-1)^(t+1) * Binomial[m+1, t] * BivariateSumT[m, n+t, k], {t, 1, m+1}];
OddPowerForwardDecomposition[n_, m_]:= Sum[Sum[(-1)^(t+1) * Binomial[m+1, t] * BivariateSumT[m, n+t, k], {t, 1, m+1}], {k, 1, n}];
OddPowerForwardDecompositionMMinus1[n_, m_]:= Sum[Sum[(-1)^(t+1) * Binomial[m, t] * BivariateSumT[m-1, n+t, k], {t, 1, m}], {k, 1, n}];
OddPowerForwardDecompositionShifted[n_, m_]:= Sum[Sum[(-1)^(t+1) * Binomial[m+1, t] * BivariateSumT[m, n+t, k], {t, 1, m+1}], {k, 0, n-1}];
OddPowerForwardDecompositionMMinus1Shifted[n_, m_]:= Sum[Sum[(-1)^(t+1) * Binomial[m, t] * BivariateSumT[m-1, n+t, k], {t, 1, m}], {k, 0, n-1}];
TableFormForwardRecurrenceForT[m_, rows_]:= TableForm[Table[ForwardRecurrenceForT[m, n, k], {n, 0, rows}, {k, 0, n}], TableAlignments -> Left];
(*END: Forward decompositions *)

(*BEGIN: Forward decompositions multifold *)
ForwardRecurrenceForTMultifold[m_, n_, k_, s_]:= Sum[(-1)^(t+1) * Binomial[m+s, t] * BivariateSumT[m, n+t, k], {t, 1, m+s}];
OddPowerForwardDecompositionMultifold[n_, m_, s_] := Sum[Sum[(-1)^(t+1) * Binomial[m+s, t] * BivariateSumT[m, n+t, k], {t, 1, m+s}], {k, 1, n}];
OddPowerForwardDecompositionMMinus1Multifold[n_, m_, s_] := Sum[Sum[(-1)^(t+1) * Binomial[m+s, t] * BivariateSumT[m-1, n+t, k], {t, 1, m+s}], {k, 1, n}];
OddPowerForwardDecompositionShiftedMultifold[n_, m_, s_] := Sum[Sum[(-1)^(t+1) * Binomial[m+s, t] * BivariateSumT[m, n+t, k], {t, 1, m+s}], {k, 0, n-1}];
OddPowerForwardDecompositionMMinus1ShiftedMultifold[n_, m_, s_] := Sum[Sum[(-1)^(t+1) * Binomial[m+s, t] * BivariateSumT[m-1, n+t, k], {t, 1, m+s}], {k, 0, n-1}];
TableFormForwardRecurrenceForTMultifold[m_, s_, rows_]:= TableForm[Table[ForwardRecurrenceForTMultifold[m, n, k, s], {n, 0, rows}, {k, 0, n}], TableAlignments -> Left];
(*END: Forward decompositions multifold *)

(*BEGIN: Backward decompositions *)
BackwardRecurrenceForT[m_, n_, k_]:= Sum[(-1)^(t-1) * Binomial[m+1, t] * BivariateSumT[m, n-t, k], {t, 1, m+1}];
OddPowerBackwardDecomposition[n_, m_]:= Sum[Sum[(-1)^(t+1) * Binomial[m+1, t] * BivariateSumT[m, n-t, k], {t, 1, m+1}], {k, 1, n}];
OddPowerBackwardDecompositionShifted[n_, m_]:= Sum[Sum[(-1)^(t+1) * Binomial[m+1, t] * BivariateSumT[m, n-t, k], {t, 1, m+1}], {k, 0, n-1}];
OddPowerBackwardDecompositionMMinus1[n_, m_]:= Sum[Sum[(-1)^(t-1) * Binomial[m, t] * BivariateSumT[m-1, n-t, k], {t, 1, m}], {k, 1, n}];
OddPowerBackwardDecompositionMMinus1Shifted[n_, m_]:= Sum[Sum[(-1)^(t-1) * Binomial[m, t] * BivariateSumT[m-1, n-t, k], {t, 1, m}], {k, 0, n-1}];
TableFormBackwardRecurrenceForT[m_, rows_]:= TableForm[Table[BackwardRecurrenceForT[m, n, k], {n, 0, rows}, {k, 0, n}], TableAlignments -> Left];
(*END: Backward decompositions *)

(*BEGIN: Backward decompositions multifold *)
BackwardRecurrenceForTMultifold[m_, n_, k_, s_]:= Sum[(-1)^(t-1) * Binomial[m+s, t] * BivariateSumT[m, n-t, k], {t, 1, m+s}];
OddPowerBackwardDecompositionMultifold[n_, m_, s_] := Sum[Sum[(-1)^(t+1) * Binomial[m+s, t] * BivariateSumT[m, n-t, k], {t, 1, m+s}], {k, 1, n}];
OddPowerBackwardDecompositionShiftedMultifold[n_, m_, s_] := Sum[Sum[(-1)^(t+1) * Binomial[m+s, t] * BivariateSumT[m, n-t, k], {t, 1, m+s}], {k, 0, n-1}];
OddPowerBackwardDecompositionMMinus1Multifold[n_, m_, s_] := Sum[Sum[(-1)^(t+1) * Binomial[m+s, t] * BivariateSumT[m-1, n-t, k], {t, 1, m+s}], {k, 1, n}];
OddPowerBackwardDecompositionMMinus1ShiftedMultifold[n_, m_, s_] := Sum[Sum[(-1)^(t+1) * Binomial[m+s, t] * BivariateSumT[m-1, n-t, k], {t, 1, m+s}], {k, 0, n-1}];
TableFormBackwardRecurrenceForTMultifold[m_, s_, rows_]:= TableForm[Table[BackwardRecurrenceForTMultifold[m, n, k, s], {n, 0, rows}, {k, 0, n}], TableAlignments -> Left];
(*END: Backward decompositions multifold *)

(*BEGIN: Central decompositions *)
CentralRecurrenceForT[m_, n_, k_]:= Sum[(-1)^(t+1) * Binomial[m+1, t] * BivariateSumT[m, n+(m/2)-t, k], {t, 1, m+1}];
TableFormCentralRecurrenceForT[m_, rows_]:= TableForm[Table[CentralRecurrenceForT[m, n, k], {n, -m/2, rows}, {k, 0, n+m/2}], TableAlignments -> Left];
OddPowerCentralDecomposition[n_, m_]:= Sum[Sum[(-1)^(t+1) * Binomial[m+1, t] * BivariateSumT[m, n+(m/2)-t, k], {t, 1, m+1}], {k, 1, n+(m/2)}];
(*END: Central decompositions *)

(*BEGIN: Binomial Forms *)
BinomialForm[m_, n_, a_] := Sum[A[m, r]* Sum[(k + a)^r * (n + a - k)^r, {k, -a+1, n + a}], {r, 0, m}];
ShiftedBinomialForm[m_, n_, a_] := Sum[A[m, r]* Sum[(k + a)^r * (n + a - k)^r, {k, -a, n + a-1}], {r, 0, m}];
CenteredBinomialForm[m_, n_, a_] := Sum[A[m, r]* Sum[(k + a/2)^r * (n + a/2 - k)^r, {k, -a/2 + 1, n + a/2}], {r, 0, m}];
ShiftedCenteredBinomialForm[m_, n_, a_] := Sum[A[m, r]* Sum[(k + a/2)^r * (n + a/2 - k)^r, {k, -a/2, n + a/2 - 1}], {r, 0, m}];
NegatedBinomialForm[m_, n_, a_] := Sum[A[m, r]* Sum[(k - a)^r * (n - a - k)^r, {k, a+1, n - a}], {r, 0, m}];
ShiftedNegatedBinomialForm[m_, n_, a_] := Sum[A[m, r]* Sum[(k - a)^r * (n - a - k)^r, {k, a, n - a - 1}], {r, 0, m}];
CenteredNegatedBinomialForm[m_, n_, a_] := Sum[A[m, r]* Sum[(k - a/2)^r * (n - a/2 - k)^r, {k, a/2, n - a/2 - 1}], {r, 0, m}];
ShiftedCenteredNegatedBinomialForm[m_, n_, a_] := Sum[A[m, r]* Sum[(k - a/2)^r * (n - a/2 - k)^r, {k, a/2+1, n - a/2}], {r, 0, m}];
(*END: Binomial Forms *)

(*BEGIN: Double bivariate identities *)
DoubleBivariateSumR[m_, n_, t_]:= Sum[BivariateSumT[m, n+t, k], {k, 1, n}];
OddPowerDoubleBivariate[n_, m_]:=Sum[(-1)^(t+1) * Binomial[m+1, t] * DoubleBivariateSumR[m, n, t], {t, 1, m+1}];
OddPowerDoubleBivariateMultifold[n_, m_, s_]:=Sum[(-1)^(t+1) * Binomial[m+s, t] * DoubleBivariateSumR[m, n, t], {t, 1, m+s}];
OddPowerDoubleBivariateNegated[n_, m_]:=Sum[(-1)^(t+1) * Binomial[m+1, t] * DoubleBivariateSumR[m, n, -t], {t, 1, m+1}];
OddPowerDoubleBivariateNegatedMultifold[n_, m_, s_]:=Sum[(-1)^(t+1) * Binomial[m+s, t] * DoubleBivariateSumR[m, n, -t], {t, 1, m+s}];
(*END: Double bivariate identities *)

(*BEGIN: Bivariate Faulhaber's formula *)
SumOfConvolvedPowers[n_, r_]:=Sum[k^r * (n-k)^r, {k, 1, n}];
BivaraiteFaulhabersFormula[n_, r_]:= n^(2r+1)/((2r+1)*Binomial[2r,r]) + (-1)^r * Sum[Binomial[r, 2k+1]*BernoulliB[2r-2k]/(r-k) * n^(2k+1), {k, 0, r-1}];
(*END: Bivariate Faulhaber's formula *)

(*BEGIN: Sums of powers *)
SumsOfPowers[n_, r_]:= Expand[Sum[k^r, {k, 1, n}]];
SumsOfOddPowers[n_, m_]:= Sum[A[m,r] * Sum[Sum[(t*k)^r, {k, 0, n-t}], {t, 1, n}], {r, 0, m}];
SumsOfOddPowersRearranged[n_, m_]:= Sum[A[m,r] * Sum[ t^r * Sum[(k)^r, {k, 0, n-t}], {t, 1, n}], {r, 0, m}];
SumsOfOddPowersReindexed[n_, m_]:= Sum[A[m,r] * Sum[Sum[((n-t)*k)^r, {k, 1, t}], {t, 1, n}], {r, 0, m}];
SumsOfOddPowersTriple[n_, m_]:= Sum[A[m,r] * Sum[Sum[j^r * (k-j)^r, {j, 1, k}], {k, 1, n}], {r, 0, m}];
(*END: Sums of powers *)

End[ ]
EndPackage[ ]



