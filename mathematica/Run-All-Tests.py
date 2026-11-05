#!/usr/bin/env python3
"""Run every test file in mathematica/Tests with the Wolfram Docker runner."""

from pathlib import Path
import subprocess
import sys


MATHEMATICA_DIR = Path(__file__).resolve().parent
TESTS_DIR = MATHEMATICA_DIR / "Tests"
RUNNER = MATHEMATICA_DIR / "Run-Wolfram-Container.sh"


def main() -> int:
    test_files = sorted(path for path in TESTS_DIR.iterdir() if path.is_file())
    if not test_files:
        print(f"No test files found in {TESTS_DIR}", file=sys.stderr)
        return 1

    failed = []
    for test_file in test_files:
        relative_path = test_file.relative_to(MATHEMATICA_DIR)
        print(f"\nRunning {relative_path}...", flush=True)
        result = subprocess.run(["bash", str(RUNNER), str(relative_path)], cwd=MATHEMATICA_DIR)
        if result.returncode != 0:
            failed.append((relative_path, result.returncode))

    if failed:
        print("\nFailed tests:", file=sys.stderr)
        for path, returncode in failed:
            print(f"  {path} (exit code {returncode})", file=sys.stderr)
        return 1

    print(f"\nAll {len(test_files)} test files completed successfully.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
