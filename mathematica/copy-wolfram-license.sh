#!/usr/bin/env bash

set -Eeuo pipefail
umask 077

container_id="${1:-wolfram-licensed}"
script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd -- "$script_dir/.." && pwd)"
license_dir="$repo_root/mathematica/Licensing"
license_file="$license_dir/mathpass"
container_license_path="/home/wolframengine/.WolframEngine/Licensing/mathpass"

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
chmod 700 "$license_dir"
docker cp "$container_id:$container_license_path" "$license_file"
chmod 600 "$license_file"

printf 'Wolfram license file copied to: %s\n' "$license_file"
