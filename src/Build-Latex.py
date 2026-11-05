#!/usr/bin/env python3
"""Build the root LaTeX document and, optionally, its bibliography."""

import argparse
import os
from pathlib import Path
import shutil
import subprocess
import sys


SCRIPT_DIR = Path(__file__).resolve().parent


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Build the root LaTeX document in this directory."
    )
    parser.add_argument(
        "output_directory",
        nargs="?",
        default="../out",
        help="output directory (default: ../out, relative to this script)",
    )
    parser.add_argument(
        "--no-bibtex",
        action="store_true",
        help="skip the BibTeX step",
    )
    return parser.parse_args()


def require_command(command: str, message: str) -> None:
    if shutil.which(command) is None:
        print(message, file=sys.stderr)
        raise SystemExit(127)


def separator() -> None:
    print("=" * 78)


def main() -> int:
    args = parse_args()

    output_dir = Path(args.output_directory)
    if not output_dir.is_absolute():
        output_dir = SCRIPT_DIR / output_dir
    output_dir.mkdir(parents=True, exist_ok=True)
    output_dir = output_dir.resolve()

    require_command(
        "pdflatex",
        "Error: pdflatex is not installed or not on PATH. Install TeX Live first.",
    )
    if not args.no_bibtex:
        require_command("bibtex", "Error: bibtex is not installed or not on PATH.")

    tex_files = sorted(
        path.name
        for path in SCRIPT_DIR.glob("*.tex")
        if path.is_file()
    )
    if not tex_files:
        print(f"Error: no root-level .tex document found in {SCRIPT_DIR}", file=sys.stderr)
        return 1
    if len(tex_files) > 1:
        print("Error: expected one root-level .tex document, found multiple:", file=sys.stderr)
        for filename in tex_files:
            print(f"  {filename}", file=sys.stderr)
        return 1

    latex_file = tex_files[0]
    latex_name = Path(latex_file).stem

    def compile_latex() -> None:
        print(f"Compiling {latex_file}...", flush=True)
        subprocess.run(
            [
                "pdflatex",
                "-file-line-error",
                "-halt-on-error",
                "-interaction=nonstopmode",
                "-synctex=1",
                "-output-format=pdf",
                f"-output-directory={output_dir}",
                latex_file,
            ],
            cwd=SCRIPT_DIR,
            check=True,
        )

    separator()
    print(f"LaTeX file: {SCRIPT_DIR / latex_file}")
    print(f"Output directory: {output_dir}")
    separator()
    compile_latex()

    if not args.no_bibtex:
        separator()
        print(f"Running BibTeX for {latex_name}...", flush=True)
        env = os.environ.copy()
        env["BIBINPUTS"] = f"{SCRIPT_DIR}:{env.get('BIBINPUTS', '')}"
        subprocess.run(["bibtex", latex_name], cwd=output_dir, env=env, check=True)

    separator()
    compile_latex()
    separator()
    compile_latex()
    separator()
    print(f"Build complete: {output_dir / f'{latex_name}.pdf'}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except subprocess.CalledProcessError as error:
        raise SystemExit(error.returncode) from error
