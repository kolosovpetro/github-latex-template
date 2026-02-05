# GitHub LaTeX Template

## Abstract

- LaTeX template for GitHub including general CI/CD actions and Mathematica templates.
- Best compatible with JetBrains Rider 2024.3.8 Build #RD-243.26574.73, built on May 18, 2025.
- Plugin: https://plugins.jetbrains.com/plugin/9473-texify-idea


## Metadata

- **Initial release date:** December 24, 2025.
- **MSC2010:** 05A19, 05A10, 41A15, 11B68, 11B73, 11B83
- **Keywords:** Sums of powers, Newton's interpolation formula, Finite differences, Binomial coefficients, Faulhaber's formula, Bernoulli numbers, Bernoulli polynomials, Interpolation, Approximation, Discrete convolution, Combinatorics, Polynomial identities, Central factorial numbers, Stirling numbers, Eulerian numbers, Worpitzky identity, Pascal's triangle, OEIS
- **License:** This work is licensed under a [CC BY 4.0 License](https://creativecommons.org/licenses/by/4.0/)
- **DOI:** https://doi.org/10.5281/zenodo.18040979
- **Web Version:** https://kolosovpetro.github.io/math/test
- **Sources:** https://github.com/kolosovpetro/github-latex-template
- **ORCID:** https://orcid.org/0000-0002-6544-8880
- **Email:** kolosovp94@gmail.com

## References

- Knuth, D. E. (1993). Johann Faulhaber and sums of powers. Mathematics of Computation, 61(203), 277–294. https://arxiv.org/abs/math/9207222
- Newton, I., & Chittenden, N. W. (1850). Newton's Principia: The mathematical principles of natural philosophy. New-York: D. Adee. https://archive.org/details/bub_gb_KaAIAAAAIAAJ/page/466/mode/2up
- Graham, R. L., Knuth, D. E., & Patashnik, O. (1994). Concrete mathematics: A foundation for computer science (2nd ed.). Addison-Wesley Publishing Company, Inc. https://archive.org/details/concrete-mathematics
- Pfaff, T. J. (2007). Deriving a formula for sums of powers of integers. Pi Mu Epsilon Journal, 12(7), 425–430. https://www.jstor.org/stable/24340705
- Sloane, N. J. A., et al. (2003). The on-line encyclopedia of integer sequences. https://oeis.org/
- Cereceda, J. L. (2022). Sums of powers of integers and generalized Stirling numbers of the second kind. arXiv preprint arXiv:2211.11648. https://arxiv.org/abs/2211.11648
- Worpitzky, J. (1883). Studien über die bernoullischen und eulerschen zahlen. Journal für die reine und angewandte Mathematik, 94, 203–232. http://eudml.org/doc/148532
- Steffensen, J. F. (1927). Interpolation. Williams & Wilkins. https://www.amazon.com/-/de/Interpolation-Second-Dover-Books-Mathematics-ebook/dp/B00GHQVON8
- Carlitz, L., & Riordan, J. (1963). The divided central differences of zero. Canadian Journal of Mathematics, 15, 94–100. https://doi.org/10.4153/CJM-1963-010-8
- Riordan, J. (1968). Combinatorial identities (Vol. 217). Wiley New York. https://www.amazon.com/-/de/Combinatorial-Identities-Probability-Mathematical-Statistics/dp/0471722758
- Scheuer, M. (2020). Reference request: identity in central factorial numbers. https://math.stackexchange.com/a/3665722/463487
- Kolosov, P. (2025). Mathematica programs for finite differences, Stirling numbers, and sums of powers. GitHub repository. https://github.com/kolosovpetro/NewtonsInterpolationFormulaAndSumsOfPowers/tree/main/mathematica

[//]: # (===============REMOVE AFTER THIS LINE=================)

## GitHub Actions used

- https://github.com/actions/checkout
- https://github.com/pandoc/actions
- https://github.com/jgm/pandoc/releases
- https://github.com/GitTools/actions/blob/main/docs/examples/github/gitversion/index.md
- https://github.com/xu-cheng/latex-action
- https://github.com/actions/upload-artifact

## How to use Mathematica package

- Open the package file `GithubLatexTemplateMathematicaPackage.m` in Wolfram Mathematica, I use version 13.0
- Execute the package using `Shift+Enter`
- Open the notebook file `GithubLatexTemplateMathematicaNotebook.nb`
- Execute the line: `Needs["GithubLatexTemplateMathematicaPackage"]`
- Continue your work as desired

## Configure CI / CD

- Update root file name in `build-pdf.yml` and `build-and-deploy-pdf.yml`
- Set repository secrets
    - `GH_ACCESS_TOKEN`: Generate GitHub Personal access token at
      `Settings -> Developer Settings -> Personal access tokens -> Generate mew token`

## Actions and their trigger policy

- `build-pdf.yml` builds project using `TeXLive`. Triggered on `pull_request`, `push` to `develop` branch
- `build-and-deploy-pdf.yml` builds project using `TeXLive` and deploys to `GitHub Pages`. Triggered on `push` to `main`
  branch

## Template example

Compiled document looks like as follows

<p align="center">
  <img src="src/sections/images/template_example.png" alt="template_example"/>
  <img src="src/sections/images/template_example2.png" alt="template_example"/>
</p>
