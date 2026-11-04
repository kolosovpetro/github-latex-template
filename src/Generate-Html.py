#!/usr/bin/env python3
"""Generate the template's standalone HTML document with Pandoc."""

from pathlib import Path
import shutil
import subprocess
import sys


SCRIPT_DIR = Path(__file__).resolve().parent


def main() -> int:
    if shutil.which("pandoc") is None:
        print("Error: pandoc is required to generate the HTML document.", file=sys.stderr)
        return 127

    tex_files = sorted(
        path.name for path in SCRIPT_DIR.glob("*.tex") if path.is_file()
    )
    if len(tex_files) != 1:
        print(
            f"Error: expected exactly one root-level .tex file in {SCRIPT_DIR}; "
            f"found {len(tex_files)}.",
            file=sys.stderr,
        )
        return 1

    latex_file = SCRIPT_DIR / tex_files[0]
    latex_name = latex_file.stem
    bibliography_file = SCRIPT_DIR / f"{latex_name}.bib"
    csl_file = "chicago-author-date.csl"
    metadata_file = "metadata.html"
    output_file = "index.html"

    for required_file in (bibliography_file, SCRIPT_DIR / csl_file, SCRIPT_DIR / metadata_file):
        if not required_file.is_file():
            print(
                f"Error: required input file not found: {required_file}",
                file=sys.stderr,
            )
            return 1

    print(f"Generating {output_file} from {latex_file.name}...", flush=True)
    subprocess.run(
        [
            "pandoc",
            str(latex_file),
            "--math-method=mathjax:https://cdn.jsdelivr.net/npm/mathjax@4/tex-mml-chtml.js",
            "--standalone",
            "--citeproc",
            "--metadata=lang:en",
            "--variable=backgroundcolor:#ffffff",
            "--variable=fontcolor:#1a1a1a",
            f"--bibliography={bibliography_file}",
            f"--csl={csl_file}",
            "-o",
            output_file,
        ],
        cwd=SCRIPT_DIR,
        check=True,
    )

    subprocess.run(
        [sys.executable, str(SCRIPT_DIR / "Update-Pandoc-Metadata.py")],
        cwd=SCRIPT_DIR,
        check=True,
    )
    print(f"HTML generation complete: {SCRIPT_DIR / output_file}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except subprocess.CalledProcessError as error:
        raise SystemExit(error.returncode) from error
