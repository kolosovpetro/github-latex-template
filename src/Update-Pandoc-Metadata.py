#!/usr/bin/env python3
"""Replace Pandoc's generator metadata with the project's metadata snippet."""

from pathlib import Path
import sys


SCRIPT_DIR = Path(__file__).resolve().parent
METADATA_FILE = SCRIPT_DIR / "metadata.html"
HTML_FILE = SCRIPT_DIR / "index.html"
MARKER = b'  <meta name="generator" content="pandoc 3.13" />'


def main() -> int:
    for input_file in (METADATA_FILE, HTML_FILE):
        if not input_file.is_file():
            print(f"Error: required file not found: {input_file}", file=sys.stderr)
            return 1

    metadata = METADATA_FILE.read_bytes().rstrip(b"\r\n")
    html = HTML_FILE.read_bytes()
    occurrences = html.count(MARKER)
    if occurrences != 1:
        print(
            f"Error: expected one Pandoc metadata marker in {HTML_FILE}, "
            f"found {occurrences}.",
            file=sys.stderr,
        )
        return 1

    HTML_FILE.write_bytes(html.replace(MARKER, metadata, 1))
    print(f"Updated Pandoc metadata in {HTML_FILE}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
