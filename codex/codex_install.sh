#!/usr/bin/env bash
set -euo pipefail

if ! command -v npm >/dev/null 2>&1; then
  echo "npm not found. Install Node.js before running this script." >&2
  exit 1
fi

npm install -g @openai/codex

echo "Codex CLI installed. Run: codex login"
