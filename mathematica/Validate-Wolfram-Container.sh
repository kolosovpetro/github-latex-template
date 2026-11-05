#!/usr/bin/env bash

set -e

CURRENT_DIR="$(pwd)"

cd "$(dirname "$0")"

SCRIPT_CODE="Prime[150]"

echo "================================================= Start: Validate Container ================================================="

docker run --rm \
  -v "$PWD/Licensing:/home/wolframengine/.WolframEngine/Licensing" \
  wolframresearch/wolframengine:15.0 \
  wolframscript -code "$SCRIPT_CODE"

echo "================================================= End: Validate Container ================================================="

cd "$CURRENT_DIR"
