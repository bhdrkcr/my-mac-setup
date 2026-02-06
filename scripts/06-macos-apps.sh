#!/bin/bash
# Install fonts

print_section "Fonts"

# Nerd Fonts (required for terminal icons in Starship and eza)
cask_install font-fira-code-nerd-font
cask_install font-jetbrains-mono-nerd-font
cask_install font-hack-nerd-font

print_success "Fonts installed"
print_info "Ghostty is pre-configured to use JetBrainsMono Nerd Font."
