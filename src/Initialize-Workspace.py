#!/usr/bin/env python3
"""Initialize a cloned github-latex-template repository."""

from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parent.parent
REPO_NAME = REPO_ROOT.name
DEFAULT_REPO_NAME = "github-latex-template"


def replace_text_in_file(file_path: Path, old_text: str, new_text: str) -> None:
    print(f"Replacing text in: {file_path}")
    if not file_path.is_file():
        print(f"Warning: file not found: {file_path}")
        return

    content = file_path.read_bytes()
    file_path.write_bytes(content.replace(old_text.encode(), new_text.encode()))
    print(f"Updated: {file_path}")


def rename_file_safe(old_path: Path, new_path: Path) -> None:
    print(f"Renaming: {old_path} -> {new_path}")
    if not old_path.exists():
        print(f"Warning: file not found: {old_path}")
        return
    if new_path.exists():
        print(f"Warning: target already exists, skipping rename: {new_path}")
        return

    old_path.rename(new_path)
    print(f"Renamed: {old_path} -> {new_path}")


def clear_directory(directory_path: Path) -> None:
    print(f"Clearing directory: {directory_path}")
    if not directory_path.is_dir():
        print(f"Warning: directory not found: {directory_path}")
        return

    for path in directory_path.rglob("*"):
        if path.is_file() or path.is_symlink():
            path.unlink()
    print(f"Cleared directory: {directory_path}")


def main() -> None:
    print(f"Git root directory name: {REPO_NAME}")
    print(f"Git root directory abs path: {REPO_ROOT}")
    print(f"Git root default directory name: {DEFAULT_REPO_NAME}")
    print(f"Initializing LaTeX template for repository: {REPO_NAME}")

    workflow_files = [
        REPO_ROOT / ".github/workflows/build-and-deploy-pdf.yml",
        REPO_ROOT / ".github/workflows/build-pdf.yml",
    ]
    temp_url_old = "kolosovpetro/github-latex-template/.github/workflows/"
    temp_url_new = "kolosovpetro/TEMP/.github/workflows/"

    for file_path in workflow_files:
        replace_text_in_file(file_path, temp_url_old, temp_url_new)
    for file_path in workflow_files:
        replace_text_in_file(file_path, DEFAULT_REPO_NAME, REPO_NAME)
    for file_path in workflow_files:
        replace_text_in_file(file_path, temp_url_new, temp_url_old)

    for file_path in (
        REPO_ROOT / ".run/bibliography.run.xml",
        REPO_ROOT / ".run/build-latex.run.xml",
    ):
        replace_text_in_file(file_path, DEFAULT_REPO_NAME, REPO_NAME)

    rename_file_safe(
        REPO_ROOT / "mathematica" / f"{DEFAULT_REPO_NAME}.m",
        REPO_ROOT / "mathematica" / f"{REPO_NAME}.m",
    )
    rename_file_safe(
        REPO_ROOT / "mathematica" / f"{DEFAULT_REPO_NAME}.nb",
        REPO_ROOT / "mathematica" / f"{REPO_NAME}.nb",
    )

    clear_directory(REPO_ROOT / "out")

    rename_file_safe(
        REPO_ROOT / "src" / f"{DEFAULT_REPO_NAME}.tex",
        REPO_ROOT / "src" / f"{REPO_NAME}.tex",
    )
    rename_file_safe(
        REPO_ROOT / "src" / f"{DEFAULT_REPO_NAME}.bib",
        REPO_ROOT / "src" / f"{REPO_NAME}.bib",
    )

    replace_text_in_file(
        REPO_ROOT / "src" / f"{REPO_NAME}.tex",
        f"\\bibliography{{{DEFAULT_REPO_NAME}}}",
        f"\\bibliography{{{REPO_NAME}}}",
    )

    footer = REPO_ROOT / "src/metadata/footer.tex"
    replace_text_in_file(
        footer,
        f"https://github.com/kolosovpetro/{DEFAULT_REPO_NAME}",
        f"https://github.com/kolosovpetro/{REPO_NAME}",
    )
    replace_text_in_file(
        footer,
        f"github.com/kolosovpetro/{DEFAULT_REPO_NAME}",
        f"github.com/kolosovpetro/{REPO_NAME}",
    )

    replace_text_in_file(
        REPO_ROOT / "mathematica" / f"{REPO_NAME}.m",
        DEFAULT_REPO_NAME,
        REPO_NAME,
    )

    for file_path in (
        REPO_ROOT / "renovate.json",
        REPO_ROOT / "renovate.json.license",
    ):
        if file_path.exists():
            print(f"Removing: {file_path}")
            file_path.unlink()
        else:
            print(f"Skipping non-existing file: {file_path}")

    for file_path in (
        REPO_ROOT / ".github/workflows/build-pdf-template.yml",
        REPO_ROOT / ".github/workflows/build-and-deploy-pdf-template.yml",
    ):
        if file_path.exists():
            print(f"Removing: {file_path}")
            file_path.unlink()
        else:
            print(f"Skipping non-existing file: {file_path}")

    print("\nInitialization completed successfully.")


if __name__ == "__main__":
    main()
