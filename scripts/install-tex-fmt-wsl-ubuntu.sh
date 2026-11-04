#!/usr/bin/env bash

set -Eeuo pipefail

VERSION="0.5.7"
RELEASE_URL="https://github.com/WGUNDERWOOD/tex-fmt/releases/download/v${VERSION}"

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

case "$(uname -m)" in
  x86_64)
    archive="tex-fmt-x86_64-linux.tar.gz"
    expected_sha256="d0e30b9b811fdc1e66a9328d5c95e9d8e585019288ca39c07f643e0796bcc4a3"
    ;;
  aarch64|arm64)
    archive="tex-fmt-aarch64-linux.tar.gz"
    expected_sha256="ad5a6c8a84f61de711f2d7659191cd7e813ad1881b384abed60df420e1eabdd1"
    ;;
  *)
    echo "Error: unsupported architecture: $(uname -m). Supported architectures are x86_64 and ARM64." >&2
    exit 1
    ;;
esac

for command_name in tar sha256sum install; do
  if ! command -v "$command_name" >/dev/null 2>&1; then
    echo "Error: required command '$command_name' is unavailable." >&2
    exit 1
  fi
done

if command -v curl >/dev/null 2>&1; then
  download() {
    curl --fail --location --silent --show-error "$1" --output "$2"
  }
elif command -v wget >/dev/null 2>&1; then
  download() {
    wget --quiet "$1" --output-document="$2"
  }
else
  echo "Error: install curl or wget before running this installer." >&2
  exit 1
fi

temporary_directory="$(mktemp -d)"
trap 'rm -rf -- "$temporary_directory"' EXIT
archive_path="$temporary_directory/$archive"

echo "Downloading tex-fmt v${VERSION} for $(uname -m)..."
download "$RELEASE_URL/$archive" "$archive_path"

actual_sha256="$(sha256sum "$archive_path")"
actual_sha256="${actual_sha256%% *}"
if [[ "$actual_sha256" != "$expected_sha256" ]]; then
  echo "Error: SHA-256 checksum mismatch for $archive." >&2
  exit 1
fi

mkdir -p "$temporary_directory/extracted"
tar -xzf "$archive_path" -C "$temporary_directory/extracted"
binary_path="$(find "$temporary_directory/extracted" -type f -name tex-fmt -print -quit)"
if [[ -z "$binary_path" ]]; then
  echo "Error: the release archive does not contain a tex-fmt executable." >&2
  exit 1
fi

install_directory="$HOME/.local/bin"
mkdir -p "$install_directory"
install -m 0755 "$binary_path" "$install_directory/tex-fmt"

path_block='case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) export PATH="$HOME/.local/bin:$PATH" ;;
esac'
for startup_file in "$HOME/.profile" "$HOME/.bashrc"; do
  touch "$startup_file"
  if ! grep -Fq 'Added by tex-fmt installer' "$startup_file"; then
    {
      printf '\n# Added by tex-fmt installer (v%s)\n' "$VERSION"
      printf '%s\n' "$path_block"
    } >> "$startup_file"
  fi
done

export PATH="$install_directory:$PATH"
echo "Installed tex-fmt v${VERSION} to $install_directory/tex-fmt"
echo "PATH configured in ~/.profile and ~/.bashrc. Open a new shell or run: source ~/.bashrc"
tex-fmt --version
