#!/bin/bash
#
# COMPLETE OpenCode + MCP Setup Script for Ubuntu 22.04
# Includes: OpenCode install, Node.js, npm, npx, MCP servers,
# WebSearch, Context7, environment setup, auto sourcing, and fixes.
#

set -e

###################################
# COLOR OUTPUT
###################################
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
error()   { echo -e "${RED}[ERROR]${NC} $1"; }

###################################
# DETECT USER HOME DIR
###################################
if [ "$SUDO_USER" ]; then
    USER_HOME=$(eval echo "~$SUDO_USER")
    USER_NAME=$SUDO_USER
else
    USER_HOME=$HOME
    USER_NAME=$(whoami)
fi

info "Detected user: $USER_NAME"
info "Home directory: $USER_HOME"

###################################
# SYSTEM UPDATE
###################################
info "Updating system…"
apt update -y && apt upgrade -y
success "System updated"

###################################
# INSTALL PREREQUISITES
###################################
info "Installing required packages…"

apt install -y curl git unzip apt-transport-https ca-certificates

###################################
# INSTALL NODE + NPM + NPX (FIX FOR WEBSEARCH)
###################################
info "Installing Node.js + npm…"
curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
apt install -y nodejs

success "Node.js installed: $(node --version)"
success "npm installed: $(npm --version)"

# Ensure npx exists
if ! command -v npx >/dev/null 2>&1; then
    warn "npx missing — installing npm again"
    apt install -y npm
else
    success "npx OK"
fi

###################################
# INSTALL OPENCODE
###################################
info "Installing OpenCode…"

if curl -fsSL https://opencode.ai/install | bash; then
    success "OpenCode installed via official installer"
else
    warn "Official installer failed — installing via npm"
    npm install -g opencode-ai
fi

if command -v opencode >/dev/null 2>&1; then
    success "OpenCode installed successfully"
else
    error "OpenCode installation failed"
    exit 1
fi

###################################
# CREATE CONFIG PATHS
###################################
info "Creating OpenCode config directory…"
mkdir -p "$USER_HOME/.config/opencode"

###################################
# CREATE opencode.json (MCP CONFIG)
###################################
info "Writing OpenCode MCP config…"

cat > "$USER_HOME/.config/opencode/opencode.json" << EOF
{
  "\$schema": "https://opencode.ai/config.json",
  "mcp": {
    "context7": {
      "type": "remote",
      "url": "https://mcp.context7.com/mcp",
      "enabled": true
    },
    "websearch": {
      "type": "local",
      "command": ["npx", "-y", "@modelcontextprotocol/server-web-search"],
      "enabled": true,
      "environment": {
        "BRAVE_API_KEY": "{env:BRAVE_API_KEY}"
      }
    }
  },
  "tools": {
    "context7": true,
    "websearch": true
  }
}
EOF

success "OpenCode MCP config created"

###################################
# CREATE ENVIRONMENT FILE FOR MCP KEYS
###################################
info "Creating environment file for API keys…"

cat > "$USER_HOME/.config/opencode/.env" << EOF
# Context7 API Key (optional)
# CONTEXT7_API_KEY=your_context7_api_key_here

# Brave Search API Key (required for websearch)
BRAVE_API_KEY=your_brave_api_key_here
EOF

success "Environment file created: $USER_HOME/.config/opencode/.env"

###################################
# ADD AUTO-LOADING TO BASHRC
###################################
info "Adding environment loading to ~/.bashrc…"

if ! grep -q "opencode/.env" "$USER_HOME/.bashrc"; then
    echo "" >> "$USER_HOME/.bashrc"
    echo "# Load OpenCode MCP environment" >> "$USER_HOME/.bashrc"
    echo "if [ -f ~/.config/opencode/.env ]; then" >> "$USER_HOME/.bashrc"
    echo "    set -a" >> "$USER_HOME/.bashrc"
    echo "    source ~/.config/opencode/.env" >> "$USER_HOME/.bashrc"
    echo "    set +a" >> "$USER_HOME/.bashrc"
    echo "fi" >> "$USER_HOME/.bashrc"
fi

success "~/.bashrc updated"

###################################
# AUTO-RELOAD BASHRC
###################################
info "Reloading environment…"
source "$USER_HOME/.bashrc"

success "Environment reloaded"

###################################
# FINAL MESSAGE
###################################
echo ""
success "COMPLETE INSTALL FINISHED!"
echo "----------------------------------------"
echo "📍 Config file:       $USER_HOME/.config/opencode/opencode.json"
echo "🔑 API key file:      $USER_HOME/.config/opencode/.env"
echo "💻 Reload shell:      source ~/.bashrc"
echo "🚀 Start OpenCode:    opencode"
echo "----------------------------------------"
echo ""
echo "Next steps:"
echo "1. Edit API key file:"
echo "   nano ~/.config/opencode/.env"
echo "2. Add your Brave API key"
echo ""
echo "3. Start OpenCode:"
echo "   opencode"
echo ""
echo "4. Try MCP tools inside OpenCode:"
echo "   \"Search Ubuntu update logs using websearch\""
echo "   \"Explain React hooks using context7\""
echo "----------------------------------------"
