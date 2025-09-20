#!/usr/bin/env bash
# Husky pre-commit hook

set -euo pipefail

if command -v npx >/dev/null 2>&1; then
  npx lint-staged
else
  echo "npx not found; skipping lint-staged"
fi

