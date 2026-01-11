#!/bin/bash
# Install fonts (GUI apps skipped per user preference)

print_section "Fonts"

# Tap the fonts cask
brew tap homebrew/cask-fonts 2>/dev/null || true

# Nerd Fonts (required for terminal icons in Starship and eza)
cask_install font-fira-code-nerd-font
cask_install font-jetbrains-mono-nerd-font
cask_install font-hack-nerd-font

print_success "Fonts installed"
print_info "To use these fonts in Terminal.app:"
print_info "  1. Open Terminal > Settings > Profiles"
print_info "  2. Select your profile and click 'Font'"
print_info "  3. Choose 'FiraCode Nerd Font' or 'JetBrainsMono Nerd Font'"
