#!/usr/bin/env bash
set -euo pipefail

# Load existing shell configuration before running installers.
source "${HOME}/.bashrc"

# Install the Opencode tooling bundle.
bash -c "$(curl -fsSL https://raw.githubusercontent.com/WarrenCox007/scripts-consolidated/main/opencode/install_opencode_full.sh)"
