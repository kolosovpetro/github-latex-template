## Build and run using PowerShell (Windows)

- Install `MikTeX`: https://miktex.org/download
- Update `MikTeX` packages
- Install `SumatraPDF` viewer: https://www.sumatrapdfreader.org/download-free-pdf-viewer
- `.\src\Initialize-Workspace.ps1` configures workspace, renames files and patches CI/CD values
- `.\src\Build-Latex.ps1` to build LaTeX and BibTeX

## Build and run in IntelliJ IDEA (Windows)

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

## Build and run in JetBrains Rider (Windows)

- Install `MikTeX`: https://miktex.org/download
- Update `MikTeX`
- Install `SumatraPDF` viewer: https://www.sumatrapdfreader.org/download-free-pdf-viewer
- Path to SumatraPDF: `C:\Program Files\SumatraPDF`
- Install `JetBrains Rider` (free for non-commercial use): https://www.jetbrains.com/rider/
- Install `TeXiFy IDEA` plugin: https://plugins.jetbrains.com/plugin/9473-texify-idea
- Configure Inverse Search in `Rider` for SumatraPDF: `Tools -> LaTeX -> Configure Inverse Search`
- Clone this repository locally: `git clone git@github.com:kolosovpetro/unexpected-polynomial-identities-classical-interpolation.git`
- Open `unexpected-polynomial-identities-classical-interpolation` folder in `Jetbrains Rider` and run `build` configuration

![build](./src/sections/images/build_the_manuscript_rider.png)

