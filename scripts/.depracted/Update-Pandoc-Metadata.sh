#!/usr/bin/env bash

set -Eeuo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
metadata_file="$script_dir/metadata.html"
html_file="$script_dir/index.html"

for input_file in "$metadata_file" "$html_file"; do
  if [[ ! -f "$input_file" ]]; then
    printf 'Error: required file not found: %s\n' "$input_file" >&2
    exit 1
  fi
done

if ! command -v python3 >/dev/null 2>&1; then
  printf 'Error: python3 is required to update the Pandoc metadata.\n' >&2
  exit 127
fi

python3 - "$metadata_file" "$html_file" <<'PY'
from pathlib import Path
import sys

metadata_path = Path(sys.argv[1])
html_path = Path(sys.argv[2])
metadata = metadata_path.read_bytes().rstrip(b"\r\n")
html = html_path.read_bytes()
marker = b'  <meta name="generator" content="pandoc" />'
occurrences = html.count(marker)

if occurrences != 1:
    raise SystemExit(
        f"Error: expected one Pandoc metadata marker in {html_path}, found {occurrences}."
    )

html_path.write_bytes(html.replace(marker, metadata, 1))
PY

printf 'Updated Pandoc metadata in %s\n' "$html_file"
