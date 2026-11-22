# CHANGELOG

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning v2.0.0](https://semver.org/spec/v2.0.0.html).

## [2.1.0] - Nov 22, 2026

### Added

- Add a Python runner that executes every file in `mathematica/Tests` and reports failures
- Include both polynomial example-generation scripts in the Mathematica test run

### Changed

- Move Mathematica test scripts into the `mathematica/Tests` directory
- Update the Mathematica reusable GitHub Actions workflow to run the Python test runner
- Remove the manually maintained Wolfram script list from the Mathematica workflow

## [2.0.0] - Nov 05, 2026

### Added

- Add Python scripts for workspace initialization, LaTeX builds, and Pandoc HTML generation
- Add Ubuntu installation scripts and VS Code configuration
- Add Mathematica Docker execution and reusable GitHub Actions workflows
- Add mathematical writing guidance and prompt collection

### Changed

- Pin Pandoc to version 3.13 and update HTML generation, metadata, and light styling
- Update reusable GitHub Actions for Python-based Pandoc builds and Mathematica CI
- Update project documentation and Mathematica container instructions

### Removed

- Remove IDE run configurations
- Move superseded PowerShell and shell scripts out of the active `src` workflow

## [1.6.0] - Jul 12, 2026

### Changed

- Update pandoc script
- Update pandoc metadata
- Add math writing
- Vs code build configs
- Updates in README
- Updates in footer
- Add notations for special symbols and t versions of them
- Add Mathematica documentation example table
- Fix keywords comma before Interpolation
- Github actions for Mathematica CI/CD
- Sync VScode config
- GitHub Actions reusable template for Mathematica

## [1.5.0] - Jan 06, 2026

### Changed

- Reuse build template actions
- Add notation for falling and rising factorials
- Add symbols for derivatives
- Edits in footer
- In bibliography: note -> howpublished
- Update init script
- Implement HTML deploy to GitHub pages

## [1.4.0] - Jan 06, 2026

### Changed

- Add `mdframed` package
- Add multifold sums of powers symbol
- Add `metadata` folder to artifacts
- Add ORCID link
- Rework footer
- Move build docs to `BUILD.md`
- Add default keywords to `README.md`
- Add default MSC2101 to `README.md`
- Add default Abstract to `README.md`
- Add `REFERENCES.txt` file with plain text references
- Add `CITATION.bib` file
- Rename `abstract` and `conclusions` files
- Add acknowledgements
- Update metadata
- Rework MSC2010 subjects
- Rework `Initialize-Workspace.ps1` script
- Fix build script
- Update file versioning
- Add free foot note
- Update article structure
- Clean-up in preamble
- Rework metadata
- Add pandoc script
- Configure pandoc with GitHub Actions

## [1.3.3] - Dec 19, 2025

### Changed

- Metadata moved to separate folder

## [1.3.2] - Dec 19, 2025

### Changed

- Update build script
- Date upper in the manuscript
- Use `enumitem` package
- Add `enable_patch_version` parameter to CI/CD
- Comment excessive metadata
- Add `physics` package for derivatives
- Comment excessive custom commands
- Update encoding script
- Remove azure pipelines CI/CD
- Update initialization script
- Build script fixes encoding
- Commit build configurations
- Build script minor fix
- Add run configuration for encoding
- Adjust template
- Add Texify idea plugin build configurations
- Add renovate configs
- Make links color red
- Copy bibliography from unexpected identities paper
- Copy mathematica scripts from unexpected identities paper
- Copy build scripts from unexpected identities paper
- Move metadata and license to a separate file
- Add BUILD.md
- Update Init workspace script
- Add encoding exclusions: `.m` and `.nb`
- Move version files to root folder

## [1.3.1] - Jan 15, 2025

### Changed

- Update initializer script
- Move images folder
- Add figures folder
- Add default keywords
- Update README
- Update bibliography

## [1.3.0] - Oct 06, 2024

### Changed

- Implement powershell build script that can be run from any location
- Implement powershell build script that searches for latex file in its PSRoot folder
- Implement powershell script that renames main latex and bibtex files to match repo root directory name
- Update README with new build instructions

## [1.2.0] - Sep 25, 2024

### Changed

- Implement latex build template (GitHub Actions)
- Implement latex deploy template (GitHub Actions)

## [1.1.9] - Jul 03, 2024

### Changed

- Hotfix update GitHub Actions GitVersion

## [1.1.8] - Jul 03, 2024

### Changed

- Changelog added
- README updated
- Theorem environments update
- Footnote added
- Bump GitHub Actions version
- Hotfix update GitHub Actions GitVersion

## [1.1.7] - Jan 31, 2024

### Changed

- Initial release before change log introduced.

## [1.1.6] - Nov 16, 2023

### Changed

- Added version as part of CI in azure pipelines

## [1.1.5] - Nov 16, 2023

### Changed

- Added azure pipelines CI

## [0.1.6] - Not released

## [0.1.5] - Not released

## [0.1.4] - Jul 19, 2023

### Changed

- Version format inside latex document changed

## [0.1.3] - Not released

## [0.1.2] - Jul 16, 2023

### Changed

- GitVersion and SemVer is part of CI/CD and also part of PDF document. Version is being updated automatically during CI/CD process

## [0.1.1] - Jul 16, 2023

### Changed

- CI/CD updated
- Example in README updated
- Picture example added
- Line skip increased
