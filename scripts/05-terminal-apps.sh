#!/bin/bash
# Install terminal applications: Ghostty, Neovim, tmux

print_section "Terminal Applications"

# Configure Ghostty
GHOSTTY_CONFIG_DIR="$HOME/.config/ghostty"
mkdir -p "$GHOSTTY_CONFIG_DIR"

backup_file "$GHOSTTY_CONFIG_DIR/config"
cp "$SCRIPT_DIR/configs/ghostty/config" "$GHOSTTY_CONFIG_DIR/config"
print_success "Ghostty configuration installed"

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

backup_file "$NVIM_CONFIG_DIR/init.lua"
cp "$SCRIPT_DIR/configs/nvim/init.lua" "$NVIM_CONFIG_DIR/init.lua"
print_success "Neovim configuration installed"

# Configure tmux
backup_file "$HOME/.tmux.conf"
cp "$SCRIPT_DIR/configs/tmux.conf" "$HOME/.tmux.conf"
print_success "tmux configuration installed"

# Set Neovim as default editor
EDITOR_CONFIG='export EDITOR="nvim"
export VISUAL="nvim"
alias vim="nvim"
alias vi="nvim"'
add_block_to_file "EDITOR" "$EDITOR_CONFIG" "$HOME/.zshrc"

print_success "Terminal applications configured"
