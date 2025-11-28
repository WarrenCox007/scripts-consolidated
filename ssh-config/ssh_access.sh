#!/usr/bin/env bash

# Configure SSH to allow password and keyboard-interactive authentication.
# Designed for use on fresh machines via: curl -fsSL <url>/ssh%20access.sh | sudo bash

#bash -c "$(curl -fsSL https://raw.githubusercontent.com/WarrenCox007/Linux-scrips/main/ssh%20access.sh)"

#!/usr/bin/env bash

# Enable SSH password & keyboard-interactive auth safely
# Usage:
# curl -fsSL https://raw.githubusercontent.com/WarrenCox007/Linux-scrips/main/ssh%20access.sh | sudo bash

set -euo pipefail

ensure_root() {
  if [[ "${EUID:-$(id -u)}" -ne 0 ]]; then
    echo "This script must be run as root. Re-run with sudo or as root." >&2
    exit 1
  fi
}

update_sshd_config() {
  local config_path="/etc/ssh/sshd_config"
  local backup_path="${config_path}.bak.$(date +%Y%m%d%H%M%S)"

  cp "$config_path" "$backup_path"

  local tmp
  tmp="$(mktemp)"

  awk '
    BEGIN {
      found_pass = 0
      found_kbd = 0
      found_pam = 0
    }

    /^#?PasswordAuthentication/ {
      print "PasswordAuthentication yes"
      found_pass = 1
      next
    }

    /^#?KbdInteractiveAuthentication/ {
      print "KbdInteractiveAuthentication yes"
      found_kbd = 1
      next
    }

    /^#?UsePAM/ {
      print "UsePAM yes"
      found_pam = 1
      next
    }

    { print }

    END {
      if (!found_pass) print "PasswordAuthentication yes"
      if (!found_kbd) print "KbdInteractiveAuthentication yes"
      if (!found_pam)  print "UsePAM yes"
    }
  ' "$config_path" > "$tmp"

  mv "$tmp" "$config_path"
  chmod 600 "$config_path"

  echo "Backup created: $backup_path"
  echo "Updated: $config_path"
}

restart_ssh() {
  if systemctl is-active --quiet ssh; then
    systemctl restart ssh
    echo "SSH service restarted"
  elif systemctl is-active --quiet sshd; then
    systemctl restart sshd
    echo "SSH service restarted"
  else
    echo "Warning: Could not determine SSH service name. Please restart manually."
    return 1
  fi
}

main() {
  echo "SSH Configuration Script"
  echo "======================="
  ensure_root
  update_sshd_config
  restart_ssh
  echo "Done! SSH is now configured for password and keyboard-interactive authentication."
}

main "$@"
