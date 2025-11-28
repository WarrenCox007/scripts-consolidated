# OpenCode Installation

Complete setup scripts for OpenCode with Node.js, Gemini CLI, and MCP servers.

## Files

- **install_opencode_full.sh** – Complete OpenCode + MCP setup for Ubuntu 22.04 (includes Node.js, npm, npx, WebSearch, Context7)
- **node20_and_gemini_install.sh** – Node.js 20 and Gemini CLI installation
- **opencode_install.sh** – Download and run the full OpenCode installation

## Quick Start

### Option 1: Full OpenCode Setup
```bash
sudo bash install_opencode_full.sh
```

### Option 2: Just Node.js 20 + Gemini CLI
```bash
sudo bash node20_and_gemini_install.sh
```

### Option 3: Download and Run
```bash
bash opencode_install.sh
```

## What Gets Installed

- Node.js (LTS or version 20)
- npm and npx
- OpenCode CLI
- MCP servers:
  - WebSearch (Brave Search)
  - Context7
- Environment configuration and auto-loading

## Configuration

After installation:

1. **Edit environment file** with your API keys:
   ```bash
   nano ~/.config/opencode/.env
   ```

2. **Add your Brave Search API key** (required for WebSearch MCP)

3. **Reload shell**:
   ```bash
   source ~/.bashrc
   ```

4. **Start OpenCode**:
   ```bash
   opencode
   ```

## Troubleshooting

- If `npx` is missing, the script will reinstall npm
- Config files are automatically created in `~/.config/opencode/`
- Environment variables are auto-loaded on shell startup
