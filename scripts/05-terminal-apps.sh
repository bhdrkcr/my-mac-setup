#!/bin/bash
# Install terminal applications: Neovim, tmux

print_section "Terminal Applications"

# Neovim
brew_install neovim

# tmux
brew_install tmux

# tmux plugin manager
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    print_info "Installing tmux plugin manager..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    print_success "TPM installed"
else
    print_info "TPM already installed"
fi

# Configure Neovim
NVIM_CONFIG_DIR="$HOME/.config/nvim"
mkdir -p "$NVIM_CONFIG_DIR"

if [[ ! -f "$NVIM_CONFIG_DIR/init.lua" ]] || [[ "$FORCE_CONFIG" == "1" ]]; then
    cp "$SCRIPT_DIR/configs/nvim/init.lua" "$NVIM_CONFIG_DIR/init.lua"
    print_success "Neovim configuration installed"
else
    print_info "Neovim config already exists, skipping (set FORCE_CONFIG=1 to overwrite)"
fi

# Configure tmux
if [[ ! -f "$HOME/.tmux.conf" ]] || [[ "$FORCE_CONFIG" == "1" ]]; then
    cp "$SCRIPT_DIR/configs/tmux.conf" "$HOME/.tmux.conf"
    print_success "tmux configuration installed"
else
    print_info "tmux config already exists, skipping (set FORCE_CONFIG=1 to overwrite)"
fi

# Set Neovim as default editor
EDITOR_CONFIG='export EDITOR="nvim"
export VISUAL="nvim"
alias vim="nvim"
alias vi="nvim"'
add_block_to_file "EDITOR" "$EDITOR_CONFIG" "$HOME/.zshrc"

print_success "Terminal applications configured"
