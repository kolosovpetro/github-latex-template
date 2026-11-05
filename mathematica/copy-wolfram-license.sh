#!/usr/bin/env bash

set -Eeuo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(git -C "$script_dir" rev-parse --show-toplevel 2>/dev/null)" || {
  printf 'Error: could not locate the Git repository containing this script.\n' >&2
  exit 1
}
container_id="${1:-${WOLFRAM_CONTAINER_NAME:-wolfram-licensed}}"
license_dir="$repo_root/mathematica/Licensing"
license_file="$license_dir/mathpass"
container_license_path="/home/wolframengine/.WolframEngine/Licensing/mathpass"

if [[ "$container_id" == "-h" || "$container_id" == "--help" ]]; then
  printf 'Usage: %s [CONTAINER_NAME_OR_ID]\n' "${0##*/}"
  printf 'Copy the activated container mathpass file to %s.\n' "$license_file"
  exit 0
fi

if ! command -v docker >/dev/null 2>&1; then
  printf 'Error: docker is not installed or not on PATH.\n' >&2
  exit 127
fi

if ! docker container inspect "$container_id" >/dev/null 2>&1; then
  printf 'Error: Docker container not found: %s\n' "$container_id" >&2
  printf 'List containers, including stopped ones, with: docker ps -a\n' >&2
  exit 1
fi

mkdir -p -- "$license_dir"
docker cp "$container_id:$container_license_path" "$license_file"

printf 'Wolfram license file copied to: %s\n' "$license_file"
