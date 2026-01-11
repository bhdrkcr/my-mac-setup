#!/bin/bash
# Install Xcode Command Line Tools

print_section "Xcode Command Line Tools"

if xcode-select -p &> /dev/null; then
    print_success "Xcode Command Line Tools already installed"
else
    print_info "Installing Xcode Command Line Tools..."
    xcode-select --install

    # Wait for installation to complete
    print_info "Waiting for installation to complete (this may take a few minutes)..."
    until xcode-select -p &> /dev/null; do
        sleep 5
    done
    print_success "Xcode Command Line Tools installed"
fi
