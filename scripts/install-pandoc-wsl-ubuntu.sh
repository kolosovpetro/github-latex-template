#!/usr/bin/env bash

set -Eeuo pipefail

PANDOC_VERSION="3.13"
PANDOC_RELEASE_URL="https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}"

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

case "$(uname -m)" in
  x86_64|amd64)
    PANDOC_PACKAGE="pandoc-${PANDOC_VERSION}-1-amd64.deb"
    ;;
  aarch64|arm64)
    PANDOC_PACKAGE="pandoc-${PANDOC_VERSION}-1-arm64.deb"
    ;;
  *)
    echo "Error: Pandoc ${PANDOC_VERSION} Ubuntu packages are unavailable for $(uname -m)." >&2
    exit 1
    ;;
esac

if command -v curl >/dev/null 2>&1; then
  DOWNLOAD=(curl --fail --location --silent --show-error)
elif command -v wget >/dev/null 2>&1; then
  DOWNLOAD=(wget --quiet --show-progress)
else
  echo "Error: install curl or wget to download Pandoc." >&2
  exit 1
fi

TEMP_DIR="$(mktemp -d)"
trap 'rm -rf -- "$TEMP_DIR"' EXIT
PACKAGE_PATH="$TEMP_DIR/$PANDOC_PACKAGE"
PACKAGE_URL="$PANDOC_RELEASE_URL/$PANDOC_PACKAGE"

echo "Downloading Pandoc ${PANDOC_VERSION} for Ubuntu ($(uname -m))..."
if [[ "${DOWNLOAD[0]}" == "curl" ]]; then
  "${DOWNLOAD[@]}" "$PACKAGE_URL" --output "$PACKAGE_PATH"
else
  "${DOWNLOAD[@]}" "$PACKAGE_URL" --output-document="$PACKAGE_PATH"
fi

echo "Updating Ubuntu package lists..."
"${SUDO[@]}" apt-get update

echo "Installing Pandoc ${PANDOC_VERSION}..."
"${SUDO[@]}" env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends "$PACKAGE_PATH"

if ! command -v pandoc >/dev/null 2>&1; then
  echo "Error: Pandoc was installed but is not available on PATH." >&2
  exit 1
fi

echo
INSTALLED_VERSION="$(pandoc --version | head -n 1 | awk '{print $2}')"
if [[ "$INSTALLED_VERSION" != "$PANDOC_VERSION" ]]; then
  echo "Error: expected Pandoc ${PANDOC_VERSION}, found ${INSTALLED_VERSION}." >&2
  exit 1
fi

PANDOC_PATH="$(command -v pandoc)"
echo
echo "Pandoc ${PANDOC_VERSION} installation complete."
echo "Executable: $PANDOC_PATH"
echo "The package installs Pandoc under /usr/bin, which is on PATH for Ubuntu shells."
