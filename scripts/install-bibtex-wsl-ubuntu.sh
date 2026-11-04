#!/usr/bin/env bash

set -Eeuo pipefail

if [[ "${EUID}" -eq 0 ]]; then
  SUDO=()
elif command -v sudo >/dev/null 2>&1; then
  SUDO=(sudo)
else
  echo "Error: run as root or install sudo first." >&2
  exit 1
fi

if [[ ! -r /etc/os-release ]]; then
  echo "Error: cannot identify the operating system (missing /etc/os-release)." >&2
  exit 1
fi

# shellcheck source=/etc/os-release
source /etc/os-release
if [[ "${ID:-}" != "ubuntu" ]]; then
  echo "Error: this installer supports Ubuntu only (detected: ${ID:-unknown})." >&2
  exit 1
fi
if ! command -v apt-get >/dev/null 2>&1; then
  echo "Error: apt-get is unavailable; this installer requires Ubuntu's package manager." >&2
  exit 1
fi

echo "Updating Ubuntu package lists..."
"${SUDO[@]}" apt-get update

echo "Installing BibTeX..."
"${SUDO[@]}" env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends texlive-binaries

echo
if ! command -v bibtex >/dev/null 2>&1; then
  echo "Error: BibTeX was installed but is not available on PATH." >&2
  exit 1
fi
bibtex --version | head -n 1
