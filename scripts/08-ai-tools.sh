#!/bin/bash
# Install AI CLI tools: Gemini, Claude, Codex (GitHub Copilot)

print_section "AI Tools"

# Ensure npm is available (installed via nvm in 03-dev-tools.sh)
# We might need to source nvm again if this script is run in isolation, but setup.sh handles flow.
# However, to be safe, let's try to load nvm if npm isn't found.
if ! command_exists npm; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

# Gemini CLI
npm_install "@google/gemini-cli"

# Claude Code
npm_install "@anthropic-ai/claude-code"

# Codex (GitHub Copilot CLI extension)
if command_exists gh; then
    print_info "Installing GitHub Copilot CLI extension..."
    if ! gh extension list | grep -q "github/gh-copilot"; then
        gh extension install github/gh-copilot
        print_success "GitHub Copilot extension installed"
    else
        print_info "GitHub Copilot extension already installed"
    fi
else
    print_warning "GitHub CLI (gh) not found. Skipping Copilot extension."
fi

print_success "AI tools installed"
