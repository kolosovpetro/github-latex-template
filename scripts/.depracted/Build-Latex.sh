#!/usr/bin/env bash

set -Eeuo pipefail

usage() {
  cat <<'USAGE'
Usage: Build-Latex.sh [OUTPUT_DIRECTORY] [--no-bibtex]

Build the root LaTeX document in this directory. OUTPUT_DIRECTORY defaults
to ../out and is resolved relative to this script's directory.
USAGE
}

output_dir="../out"
compile_bibtex=true
output_dir_set=false

for arg in "$@"; do
  case "$arg" in
    --no-bibtex)
      compile_bibtex=false
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    -* )
      echo "Error: unknown option: $arg" >&2
      usage >&2
      exit 2
      ;;
    *)
      if [[ "$output_dir_set" == true ]]; then
        echo "Error: only one output directory may be specified." >&2
        usage >&2
        exit 2
      fi
      output_dir="$arg"
      output_dir_set=true
      ;;
  esac
done

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
if [[ "$output_dir" != /* ]]; then
  output_dir="$script_dir/$output_dir"
fi
mkdir -p -- "$output_dir"
output_dir="$(cd -- "$output_dir" && pwd)"

if ! command -v pdflatex >/dev/null 2>&1; then
  echo "Error: pdflatex is not installed or not on PATH. Install TeX Live first." >&2
  exit 127
fi
if [[ "$compile_bibtex" == true ]] && ! command -v bibtex >/dev/null 2>&1; then
  echo "Error: bibtex is not installed or not on PATH." >&2
  exit 127
fi

mapfile -t tex_files < <(find "$script_dir" -maxdepth 1 -type f -name '*.tex' -printf '%f\n' | sort)
if (( ${#tex_files[@]} == 0 )); then
  echo "Error: no root-level .tex document found in $script_dir" >&2
  exit 1
fi
if (( ${#tex_files[@]} > 1 )); then
  echo "Error: expected one root-level .tex document, found multiple:" >&2
  printf '  %s\n' "${tex_files[@]}" >&2
  exit 1
fi

latex_file="${tex_files[0]}"
latex_name="${latex_file%.tex}"
cd -- "$script_dir"

separator() { printf '%s\n' '=============================================================================='; }
compile_latex() {
  echo "Compiling $latex_file..."
  pdflatex \
    -file-line-error \
    -halt-on-error \
    -interaction=nonstopmode \
    -synctex=1 \
    -output-format=pdf \
    "-output-directory=$output_dir" \
    "$latex_file"
}

separator
echo "LaTeX file: $script_dir/$latex_file"
echo "Output directory: $output_dir"
separator
compile_latex

if [[ "$compile_bibtex" == true ]]; then
  separator
  echo "Running BibTeX for $latex_name..."
  # BibTeX reads the .aux file from the output directory and the .bib file
  # from the source directory.
  (cd -- "$output_dir" && BIBINPUTS="$script_dir:${BIBINPUTS:-}" bibtex "$latex_name")
fi

separator
compile_latex
separator
compile_latex
separator
echo "Build complete: $output_dir/$latex_name.pdf"
