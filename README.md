# Scripts Consolidated

A unified repository containing shell scripts and setup guides for Linux administration, SSH configuration, OpenCode installation, and infrastructure templates. Consolidates the previous three repos: **Linux-scrips**, **Opencode**, and **shell-script**.

## Directory Structure

```
scripts-consolidated/
├── ssh-config/           # SSH configuration and access setup
├── opencode/            # OpenCode installation scripts
├── codex/               # Codex CLI install script
├── infrastructure/      # Proxmox and infrastructure templates
├── setup-docs/          # Documentation for setup and configuration
└── README.md            # This file
```

## SSH Configuration (`ssh-config/`)

Scripts and guides for configuring SSH access on Linux servers.

### Files
- **ssh_access.sh** – Enables password and keyboard-interactive authentication on `/etc/ssh/sshd_config`
- **ssh_access_setup.sh** – Downloads and runs the SSH access configuration helper
- **ssh_port_forward** – Instructions for SSH local port forwarding (useful for device-based authentication flows)
- **ssh_key_cleanup.md** – How to remove cached host keys

### Quick Start
```bash
# Enable SSH password authentication on a fresh server
curl -fsSL https://raw.githubusercontent.com/WarrenCox007/scripts-consolidated/main/ssh-config/ssh_access.sh | sudo bash
```

### Port Forwarding Example
```bash
# From your workstation, create an SSH tunnel to the server:
ssh -L 1455:localhost:1455 root@your-server-ip

# Then on the server, start your CLI authentication:
codex login

# Open the callback URL in your workstation browser
```

## OpenCode (`opencode/`)

Complete setup scripts for OpenCode with Node.js, npm, npx, and MCP servers.

### Files
- **install_opencode_full.sh** – Complete OpenCode + MCP setup for Ubuntu 22.04
- Includes: OpenCode, Node.js, npm, npx, MCP servers, WebSearch, Context7, and environment setup

### Quick Start
```bash
sudo bash install_opencode_full.sh
```

## Codex

OpenAI Codex CLI setup and usage.

### Quick Start
```bash
curl -fsSL https://raw.githubusercontent.com/WarrenCox007/scripts-consolidated/main/codex/codex_install.sh | sudo bash

codex login
codex
```

### Manual Install
```bash
npm install -g @openai/codex
codex login
codex
```

## Infrastructure (`infrastructure/`)

Infrastructure templates and configurations.

### Files
- **proxmox_template** – Proxmox VM template configurations

## Setup Documentation (`setup-docs/`)

Detailed guides and reference documentation.

### Common Tasks

#### Create a New Sudo User
```bash
adduser username
usermod -aG sudo username
su - username
```

#### Remove Cached SSH Host Keys
```bash
ssh-keygen -R 192.168.10.20
```

#### Node.js 20 and Gemini Installation
See `setup-docs/node20_and_gemini_install.sh` for automated installation.

#### OpenCode Installation
See `setup-docs/opencode_install.sh` for step-by-step setup.

## Prerequisites

- Linux system (Ubuntu 22.04 or similar)
- Root or sudo access for most scripts
- curl and bash

## Usage Guidelines

1. **Always review scripts before execution** – Adapt them to your environment
2. **Run with appropriate privileges** – Most scripts require root or sudo
3. **Backup important files** – Scripts make backups of modified files (e.g., `/etc/ssh/sshd_config.bak.*`)
4. **Test in non-production first** – Especially infrastructure-related scripts

## Contributing

These scripts are tools for system administration and development setup. Ensure they are appropriate for your environment before use.

## License & Attribution

Based on the original repos:
- [Linux-scrips](https://github.com/WarrenCox007/Linux-scrips)
- Opencode installation guides
- Infrastructure templates
