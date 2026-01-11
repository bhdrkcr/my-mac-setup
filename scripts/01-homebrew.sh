#!/bin/bash
# Install Homebrew package manager

print_section "Homebrew"

if command_exists brew; then
    print_success "Homebrew already installed at $(brew --prefix)"
    print_info "Updating Homebrew..."
    brew update
else
    print_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add to PATH for current session
    if [[ "$ARCH" == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi

    print_success "Homebrew installed"
fi

# Ensure brew is in PATH for subsequent scripts
eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"

# Disable analytics (optional)
brew analytics off
print_info "Homebrew analytics disabled"
