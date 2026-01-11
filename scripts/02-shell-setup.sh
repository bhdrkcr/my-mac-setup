#!/bin/bash
# Setup Zsh with enhancements

print_section "Shell Setup (Zsh)"

ZSHRC="$HOME/.zshrc"

# Create .zshrc if it doesn't exist
touch "$ZSHRC"

# Install Starship prompt
print_info "Installing Starship prompt..."
brew_install starship

# Zsh plugins via Homebrew
print_info "Installing Zsh plugins..."
brew_install zsh-autosuggestions
brew_install zsh-syntax-highlighting
brew_install zsh-completions

# Apply shell configuration
print_info "Configuring .zshrc..."
backup_file "$ZSHRC"

# Source the zshrc configuration from configs
ZSHRC_CONFIG="$SCRIPT_DIR/configs/zshrc.sh"
if [[ -f "$ZSHRC_CONFIG" ]]; then
    add_block_to_file "MACBOOK_SETUP" "$(cat "$ZSHRC_CONFIG")" "$ZSHRC"
    print_success ".zshrc configured"
fi

# Copy Starship config
mkdir -p "$HOME/.config"
cp "$SCRIPT_DIR/configs/starship.toml" "$HOME/.config/starship.toml"
print_success "Starship configuration installed"

print_success "Shell setup complete"
