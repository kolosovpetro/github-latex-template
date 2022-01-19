# LaTeX template for Github

LaTeX template for Github including general CI/CD actions and Mathematica templates.

[![Build PDF](https://github.com/kolosovpetro/github-latex-template/actions/workflows/build-pdf.yml/badge.svg)](https://github.com/kolosovpetro/github-latex-template/actions/workflows/build.yml/badge.svg)
[![Build and Deploy PDF](https://github.com/kolosovpetro/github-latex-template/actions/workflows/build-and-deploy-pdf.yml/badge.svg)](https://github.com/kolosovpetro/github-latex-template/actions/workflows/build-and-deploy.yml/badge.svg)
![contributors count](https://img.shields.io/github/contributors/kolosovpetro/github-latex-template)

## Template Example

<p align="center">
  <img src="img/template_example.PNG" alt="template_example"/>
</p>

## Build and run in Intellij IDEA

- Install `MikTeX`: https://miktex.org/download
- Update `MikTeX`
- Install `SumatraPDF` viewer: https://www.sumatrapdfreader.org/download-free-pdf-viewer
- Install `Intellij IDEA Ultimate`: https://www.jetbrains.com/idea/download/#section=windows
- Activate `Intellij IDEA Ultimate`
- Install `TeXiFy IDEA` plugin: https://plugins.jetbrains.com/plugin/9473-texify-idea
- Clone this repository locally: `https://github.com/kolosovpetro/github-latex-template.git`
- Open `github-latex-template` folder in `Intellij IDEA Ultimate` and configure as follows
    - LaTeX Configuration
      ![LaTeX Configuration](img/latex_configuration.PNG?raw=true "LaTeX Configuration")
    - BibTeX Configuration
      ![BibTeX Configuration](img/bibtex_configuration.PNG?raw=true "BibTeX Configuration")
- Configure Inverse Search in `Intellij IDEA` for SumatraPDF: `Tools -> LaTeX -> Configure Inverse Search`
- Compile document using `Shift + F10`

## How to use Mathematica package

- Open the package file `GithubLatexTemplateMathematicaPackage.m` in Wolfram Mathematica, I use version 13.0
- Execute the package using `Shift+Enter`
- Open the notebook file `GithubLatexTemplateMathematicaNotebook.nb`
- Execute the line: `Needs["GithubLatexTemplateMathematicaPackage"]`
- Continue your work as desired

## Configure CI / CD

## Action trigger policy
