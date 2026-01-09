#!/usr/bin/env bash
set -euo pipefail

# Fetch and run the SSH access configuration helper.
bash -c "$(curl -fsSL https://raw.githubusercontent.com/WarrenCox007/scripts-consolidated/main/ssh-config/ssh_access.sh)"
