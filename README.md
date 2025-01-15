# GitHub LaTeX Template

[![Build PDF](https://github.com/kolosovpetro/github-latex-template/actions/workflows/build-pdf.yml/badge.svg)](https://github.com/kolosovpetro/github-latex-template/actions/workflows/build.yml/badge.svg)
[![Build and Deploy PDF](https://github.com/kolosovpetro/github-latex-template/actions/workflows/build-and-deploy-pdf.yml/badge.svg)](https://github.com/kolosovpetro/github-latex-template/actions/workflows/build-and-deploy.yml/badge.svg)

LaTeX template for GitHub including general CI/CD actions and Mathematica templates.

- https://dev.azure.com/PetroKolosovProjects/github-latex-template

## GitHub Actions used

- https://github.com/actions/checkout
- https://github.com/GitTools/actions/blob/main/docs/examples/github/gitversion/index.md
- https://github.com/xu-cheng/latex-action
- https://github.com/actions/upload-artifact

## Build and run using PowerShell (Windows)

- Install `MikTeX`: https://miktex.org/download
- Update `MikTeX`
- Install `SumatraPDF` viewer: https://www.sumatrapdfreader.org/download-free-pdf-viewer
- `Rename-Tex-Files.ps1` renames main LaTeX and BibTeX files to match the repository root directory name
- `Build-Latex.ps1`

## Build and run in Intellij IDEA (Windows)

- Install `MikTeX`: https://miktex.org/download
- Update `MikTeX`
- Install `SumatraPDF` viewer: https://www.sumatrapdfreader.org/download-free-pdf-viewer
- Path to SumatraPDF: `C:\Program Files\SumatraPDF`
- Install `Intellij IDEA Ultimate`: https://www.jetbrains.com/idea/download/#section=windows
- Activate `Intellij IDEA Ultimate`
- Install `TeXiFy IDEA` plugin: https://plugins.jetbrains.com/plugin/9473-texify-idea
- Clone this repository locally: `https://github.com/kolosovpetro/github-latex-template.git`
- Open `github-latex-template` folder in `Intellij IDEA Ultimate` and configure as follows
    - LaTeX Configuration
      ![LaTeX Configuration](./src/sections/images/latex_configuration.png "LaTeX Configuration")
    - BibTeX Configuration
      ![BibTeX Configuration](./src/sections/images/bibtex_configuration.png "BibTeX Configuration")
- Configure Inverse Search in `Intellij IDEA` for SumatraPDF: `Tools -> LaTeX -> Configure Inverse Search`
- Compile document using `Shift + F10`

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
