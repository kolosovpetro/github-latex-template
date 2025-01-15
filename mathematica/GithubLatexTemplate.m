(* ::Package:: *)

BeginPackage["GithubLatexTemplateMathematicaPackage`"]

A::usage= "A[n, k] returns the real coefficient A of non-negative integers n, k such that n <= k. 
See https://kolosovpetro.github.io/pdf/AStudyOnDynamicEquations.pdf."

L::usage= "L[m, n, k] returns the polynomial L of integers m, n, k. See https://kolosovpetro.github.io/pdf/AStudyOnDynamicEquations.pdf."

P::usage= "P[m, x, b] returns the polynomial P of m, x and b. See https://kolosovpetro.github.io/pdf/AStudyOnDynamicEquations.pdf."

sigma::usage= "Forward jump operator on time scales."

timeScaleDifferenceX::usage= "Returns the partial time scale difference of polynomial P with respect to the varaible X."

timeScaleDerivativeX::usage= "Returns the partial time scale derivative of polynomial P with respect to the varaible X."

timeScaleDifferenceB::usage= "Returns the partial time scale difference of polynomial P with respect to the varaible B."

timeScaleDerivativeB::usage= "Returns the partial time scale derivative of polynomial P with respect to the varaible B."

timeScaleDerivaitveOddPower::usage= "Returns the partial time scale derivative of the polynomial X^{2m+1} with respect to the varaible X."

theorem::usage= "Returns the partial dynamic equation identity such that is main result of the manuscript."

Begin["`Private`"]

Unprotect[Power];
Power[0|0., 0|0.] = 1;
Protect[Power];

A[n_, k_] := 0;
A[n_, k_] := (2k + 1) * Binomial[2k, k] * Sum[A[n, j] * Binomial[j, 2k + 1] * (-1)^(j - 1) / (j - k) * BernoulliB[2j - 2k], {j, 2k + 1, n}] /; 0 <= k < n;
A[n_, k_] := (2n + 1) * Binomial[2n, n] /; k == n;

L[m_, n_, k_] := Sum[A[m, r] * k^r * (n - k)^r, {r, 0, m}];
P[m_, n_, b_] := Sum[L[m, n, k], {k, 0, b - 1}];

sigma[x_] := Global`q * x ^ Global`j;

timeScaleDifferenceX[m_, x_, b_] := (P[m, sigma[x], b] - P[m, Global`t, b]) / (sigma[x] - Global`t);

timeScaleDerivativeX[m_, x_, b_] := Expand[Limit[(P[m, sigma[x], b] - P[m, Global`t, b]) / (sigma[x] - Global`t), Global`t -> x]];

timeScaleDifferenceB[m_, x_, b_] := Expand[(P[m, x, sigma[b]] - P[m, x, t]) / (sigma[b] - t)];

timeScaleDerivativeB[m_, x_, b_] := Expand[Limit[(P[m, x, sigma[b]] - P[m, x, t]) / (sigma[b] - t), t -> b]];

timeScaleDerivaitveOddPower[m_, x_] := Expand[Limit[(sigma[x]^(2m + 1) - t^(2m + 1)) / (sigma[x] - t), t -> x]];

theorem[m_] := Expand[timeScaleDerivativeX[m, Global`x, sigma[Global`x]] + timeScaleDerivativeB[m, Global`x, Global`x]];

End[ ]

EndPackage[ ]

