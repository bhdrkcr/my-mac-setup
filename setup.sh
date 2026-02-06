#!/bin/bash
#
# MacBook Setup Script
# ====================
# Configures a new Mac with development tools and preferences.
# Safe to run multiple times (idempotent).
#
# Usage: ./setup.sh
#

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/scripts/utils.sh"

# Architecture detection
ARCH=$(uname -m)
if [[ "$ARCH" == "arm64" ]]; then
    HOMEBREW_PREFIX="/opt/homebrew"
else
    HOMEBREW_PREFIX="/usr/local"
fi
export HOMEBREW_PREFIX
export SCRIPT_DIR

# ============================================================================
# Section Flags - Set to 0 to disable a section
# ============================================================================

INSTALL_XCODE_CLI=1
INSTALL_HOMEBREW=1
INSTALL_SHELL_SETUP=1
INSTALL_DEV_TOOLS=1
INSTALL_CLI_TOOLS=1
INSTALL_TERMINAL_APPS=1
INSTALL_AI_TOOLS=1
INSTALL_FONTS=1
CONFIGURE_MACOS_DEFAULTS=1

# ============================================================================
# Main Script
# ============================================================================

print_header "MacBook Setup Script"
echo "Architecture: $ARCH"
echo "Homebrew prefix: $HOMEBREW_PREFIX"
echo ""
echo "The following sections will be installed:"
[[ $INSTALL_XCODE_CLI -eq 1 ]] && echo "  - Xcode Command Line Tools"
[[ $INSTALL_HOMEBREW -eq 1 ]] && echo "  - Homebrew"
[[ $INSTALL_SHELL_SETUP -eq 1 ]] && echo "  - Shell Setup (Zsh + Starship)"
[[ $INSTALL_DEV_TOOLS -eq 1 ]] && echo "  - Dev Tools (pyenv, nvm, git)"
[[ $INSTALL_CLI_TOOLS -eq 1 ]] && echo "  - Modern CLI Tools"
[[ $INSTALL_TERMINAL_APPS -eq 1 ]] && echo "  - Terminal Apps (Neovim, tmux)"
[[ $INSTALL_AI_TOOLS -eq 1 ]] && echo "  - AI Tools (Gemini, Claude, Copilot)"
[[ $INSTALL_FONTS -eq 1 ]] && echo "  - Nerd Fonts"
[[ $CONFIGURE_MACOS_DEFAULTS -eq 1 ]] && echo "  - macOS Preferences"
echo ""

# Prompt for confirmation
read -p "Continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi

# Run sections
[[ $INSTALL_XCODE_CLI -eq 1 ]] && source "$SCRIPT_DIR/scripts/00-xcode-cli.sh"
[[ $INSTALL_HOMEBREW -eq 1 ]] && source "$SCRIPT_DIR/scripts/01-homebrew.sh"
[[ $INSTALL_SHELL_SETUP -eq 1 ]] && source "$SCRIPT_DIR/scripts/02-shell-setup.sh"
[[ $INSTALL_DEV_TOOLS -eq 1 ]] && source "$SCRIPT_DIR/scripts/03-dev-tools.sh"
[[ $INSTALL_CLI_TOOLS -eq 1 ]] && source "$SCRIPT_DIR/scripts/04-cli-tools.sh"
[[ $INSTALL_TERMINAL_APPS -eq 1 ]] && source "$SCRIPT_DIR/scripts/05-terminal-apps.sh"
[[ $INSTALL_AI_TOOLS -eq 1 ]] && source "$SCRIPT_DIR/scripts/08-ai-tools.sh"
[[ $INSTALL_FONTS -eq 1 ]] && source "$SCRIPT_DIR/scripts/06-macos-apps.sh"
[[ $CONFIGURE_MACOS_DEFAULTS -eq 1 ]] && source "$SCRIPT_DIR/scripts/07-macos-defaults.sh"

# ============================================================================
# Post-installation Summary
# ============================================================================

print_header "Setup Complete!"

echo "Next steps:"
echo ""
echo "  1. Restart your terminal (or run: source ~/.zshrc)"
echo ""
echo "  2. Ghostty is pre-configured with JetBrainsMono Nerd Font."
echo "     Config: ~/.config/ghostty/config"
echo ""
echo "  3. Install Python (optional):"
echo "     pyenv install 3.12"
echo "     pyenv global 3.12"
echo ""
echo "  4. Install Node.js (optional):"
echo "     nvm install --lts"
echo "     nvm use --lts"
echo ""
echo "  5. Install tmux plugins:"
echo "     Open tmux and press: Ctrl+b then I (capital i)"
echo ""
echo "  6. Open nvim - plugins will auto-install on first launch"
echo ""

print_success "Enjoy your new setup!"
