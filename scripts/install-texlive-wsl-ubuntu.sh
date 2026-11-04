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

echo "Installing TeX Live and common LaTeX build tools..."
"${SUDO[@]}" env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  latexmk \
  texlive-fonts-recommended \
  texlive-binaries \
  texlive-latex-base \
  texlive-latex-extra \
  texlive-latex-recommended \
  texlive-plain-generic

echo
echo "TeX Live installation complete. Versions:"
pdflatex --version | head -n 1
latexmk -v | head -n 1
