#!/usr/bin/env bash

set -e

MATHEMATICA_FILE_NAME="${1:-ValidateMultifoldSumsOfPowers.txt}"

CURRENT_DIR="$(pwd)"

cd "$(dirname "$0")"

SCRIPT_CODE="$(cat "$MATHEMATICA_FILE_NAME")"

echo "================================================= $MATHEMATICA_FILE_NAME ================================================="

docker run --rm \
  -v "$PWD/Licensing:/home/wolframengine/.WolframEngine/Licensing" \
  wolframresearch/wolframengine:15.0 \
  wolframscript -code "$SCRIPT_CODE"

echo "================================================= $MATHEMATICA_FILE_NAME ================================================="

cd "$CURRENT_DIR"