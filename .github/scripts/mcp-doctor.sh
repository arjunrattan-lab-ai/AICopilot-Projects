#!/usr/bin/env bash
set -euo pipefail

# mcp-doctor.sh — Diagnose and fix MCP setup for automotive-pm
#
# Run:  ./scripts/mcp-doctor.sh
# Does: Checks Node 18+, installs if missing, validates .env, tests MCPs.
#        Safe to re-run — only changes what's broken.

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REQUIRED_NODE_MAJOR=18
ENV_FILE="$REPO_ROOT/.env"
ENV_EXAMPLE="$REPO_ROOT/.env.example"
MCP_JSON="$REPO_ROOT/.vscode/mcp.json"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

pass() { echo -e "  ${GREEN}✅ $1${NC}"; }
fail() { echo -e "  ${RED}❌ $1${NC}"; }
warn() { echo -e "  ${YELLOW}⚠️  $1${NC}"; }
info() { echo -e "  $1"; }

echo ""
echo "🔧 MCP Doctor — automotive-pm"
echo "=============================="
echo ""

ISSUES=0

# ── 1. Node.js ────────────────────────────────────────

echo "1. Node.js (required: v${REQUIRED_NODE_MAJOR}+)"

# Check if node exists at all
if ! command -v node &>/dev/null; then
  fail "Node.js not found"

  # Check for nvm
  if [ -s "$HOME/.nvm/nvm.sh" ]; then
    info "  nvm detected. Installing Node ${REQUIRED_NODE_MAJOR}..."
    # shellcheck source=/dev/null
    source "$HOME/.nvm/nvm.sh"
    nvm install "$REQUIRED_NODE_MAJOR"
    nvm use "$REQUIRED_NODE_MAJOR"
    nvm alias default "$REQUIRED_NODE_MAJOR"
    pass "Node $(node --version) installed via nvm"
  elif command -v fnm &>/dev/null; then
    info "  fnm detected. Installing Node ${REQUIRED_NODE_MAJOR}..."
    fnm install "$REQUIRED_NODE_MAJOR"
    fnm use "$REQUIRED_NODE_MAJOR"
    fnm default "$REQUIRED_NODE_MAJOR"
    pass "Node $(node --version) installed via fnm"
  elif command -v volta &>/dev/null; then
    info "  volta detected. Installing Node ${REQUIRED_NODE_MAJOR}..."
    volta install "node@${REQUIRED_NODE_MAJOR}"
    pass "Node $(node --version) installed via volta"
  else
    fail "No Node.js and no version manager (nvm, fnm, volta) found."
    echo ""
    echo "  Installing nvm + Node ${REQUIRED_NODE_MAJOR} automatically..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    # shellcheck source=/dev/null
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
    nvm install "$REQUIRED_NODE_MAJOR"
    nvm use "$REQUIRED_NODE_MAJOR"
    nvm alias default "$REQUIRED_NODE_MAJOR"
    pass "nvm installed. Node $(node --version) installed."
    warn "Restart your terminal for nvm to be available in new shells."
  fi
else
  NODE_MAJOR=$(node -e 'console.log(process.versions.node.split(".")[0])')
  if [ "$NODE_MAJOR" -lt "$REQUIRED_NODE_MAJOR" ]; then
    fail "Node $(node --version) is too old (need v${REQUIRED_NODE_MAJOR}+)"

    # Try to switch via nvm
    if [ -s "$HOME/.nvm/nvm.sh" ]; then
      # shellcheck source=/dev/null
      source "$HOME/.nvm/nvm.sh"
      if nvm ls "$REQUIRED_NODE_MAJOR" &>/dev/null; then
        info "  Node ${REQUIRED_NODE_MAJOR} already installed via nvm. Switching..."
        nvm use "$REQUIRED_NODE_MAJOR"
        nvm alias default "$REQUIRED_NODE_MAJOR"
      else
        info "  Installing Node ${REQUIRED_NODE_MAJOR} via nvm..."
        nvm install "$REQUIRED_NODE_MAJOR"
        nvm use "$REQUIRED_NODE_MAJOR"
        nvm alias default "$REQUIRED_NODE_MAJOR"
      fi
      pass "Switched to Node $(node --version)"
      warn "Restart Claude Code for the MCP servers to pick up the new version."
    elif command -v fnm &>/dev/null; then
      fnm install "$REQUIRED_NODE_MAJOR"
      fnm use "$REQUIRED_NODE_MAJOR"
      fnm default "$REQUIRED_NODE_MAJOR"
      pass "Switched to Node $(node --version) via fnm"
    elif command -v volta &>/dev/null; then
      volta install "node@${REQUIRED_NODE_MAJOR}"
      pass "Switched to Node $(node --version) via volta"
    else
      fail "No version manager found. Install nvm: https://github.com/nvm-sh/nvm#installing-and-updating"
      ISSUES=$((ISSUES + 1))
    fi
  else
    pass "Node $(node --version)"
  fi
fi

echo ""

# ── 2. .env file ──────────────────────────────────────

echo "2. Environment variables (.env)"

if [ ! -f "$ENV_FILE" ]; then
  if [ -f "$ENV_EXAMPLE" ]; then
    cp "$ENV_EXAMPLE" "$ENV_FILE"
    warn ".env created from .env.example — fill in your API keys"
    ISSUES=$((ISSUES + 1))
  else
    fail ".env not found and no .env.example to copy from"
    info "  Create .env with at minimum:"
    info "    FELLOW_API_KEY=your_key_here"
    ISSUES=$((ISSUES + 1))
  fi
else
  pass ".env exists"

  # Check for required keys
  REQUIRED_KEYS=("FELLOW_API_KEY")
  OPTIONAL_KEYS=("SNOWFLAKE_USER" "SNOWFLAKE_ROLE" "SNOWFLAKE_WAREHOUSE" "TAVILY_API_KEY")

  for key in "${REQUIRED_KEYS[@]}"; do
    if grep -q "^${key}=" "$ENV_FILE" && [ -n "$(grep "^${key}=" "$ENV_FILE" | cut -d= -f2-)" ]; then
      pass "$key is set"
    else
      fail "$key is missing or empty"
      ISSUES=$((ISSUES + 1))
    fi
  done

  for key in "${OPTIONAL_KEYS[@]}"; do
    if grep -q "^${key}=" "$ENV_FILE" && [ -n "$(grep "^${key}=" "$ENV_FILE" | cut -d= -f2-)" ]; then
      pass "$key is set (optional)"
    else
      warn "$key not set (optional — some features may be limited)"
    fi
  done
fi

echo ""

# ── 3. MCP config ─────────────────────────────────────

echo "3. MCP configuration"

if [ -f "$MCP_JSON" ]; then
  pass ".vscode/mcp.json exists"

  # Check for each server
  for server in fellow snowflake tavily; do
    if grep -q "\"$server\"" "$MCP_JSON"; then
      pass "$server server configured"
    else
      warn "$server server not in mcp.json"
    fi
  done
else
  fail ".vscode/mcp.json not found"
  info "  Run: cp .vscode/mcp.json.example .vscode/mcp.json"
  ISSUES=$((ISSUES + 1))
fi

echo ""

# ── 4. Pre-warm npx caches ───────────────────────────

echo "4. Pre-warming MCP dependencies"

if command -v npx &>/dev/null; then
  NODE_MAJOR=$(node -e 'console.log(process.versions.node.split(".")[0])')
  if [ "$NODE_MAJOR" -ge "$REQUIRED_NODE_MAJOR" ]; then
    info "  Caching fellow-mcp (this may take a moment on first run)..."
    if npx -y fellow-mcp@latest --help &>/dev/null 2>&1; then
      pass "fellow-mcp cached and working"
    else
      warn "fellow-mcp install or cache failed — Fellow may not work"
      ISSUES=$((ISSUES + 1))
    fi
  else
    warn "Skipping pre-warm — Node version too old"
  fi
else
  warn "npx not found — cannot pre-warm caches"
fi

echo ""

# ── 5. Summary ────────────────────────────────────────

echo "=============================="
if [ "$ISSUES" -eq 0 ]; then
  echo -e "${GREEN}All checks passed! Restart Claude Code if you made changes.${NC}"
else
  echo -e "${YELLOW}${ISSUES} issue(s) found. Fix them and re-run this script.${NC}"
fi
echo ""
