#!/usr/bin/env bash

set -Eeuo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd -- "$script_dir"

for command_name in pandoc; do
  if ! command -v "$command_name" >/dev/null 2>&1; then
    printf 'Error: %s is required to generate the HTML document.\n' "$command_name" >&2
    exit 127
  fi
done

mapfile -t tex_files < <(find . -maxdepth 1 -type f -name '*.tex' -printf '%f\n' | sort)
if (( ${#tex_files[@]} != 1 )); then
  printf 'Error: expected exactly one root-level .tex file in %s; found %d.\n' \
    "$script_dir" "${#tex_files[@]}" >&2
  exit 1
fi

latex_file="${tex_files[0]}"
latex_name="${latex_file%.tex}"
bibliography_file="$latex_name.bib"
csl_file="chicago-author-date.csl"
metadata_file="metadata.html"
output_file="index.html"

for required_file in "$bibliography_file" "$csl_file" "$metadata_file"; do
  if [[ ! -f "$required_file" ]]; then
    printf 'Error: required input file not found: %s/%s\n' "$script_dir" "$required_file" >&2
    exit 1
  fi
done

printf 'Generating %s from %s...\n' "$output_file" "$latex_file"
pandoc "$latex_file" \
  --mathjax=https://cdn.jsdelivr.net/npm/mathjax@4/tex-mml-chtml.js \
  --standalone \
  --citeproc \
  --metadata=lang:en \
  --bibliography="$bibliography_file" \
  --csl="$csl_file" \
  -o "$output_file"

./Update-Pandoc-Metadata.sh

printf 'HTML generation complete: %s/%s\n' "$script_dir" "$output_file"
