#!/bin/bash
# Shared utility functions for setup scripts

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

print_header() {
    echo ""
    echo -e "${BLUE}======================================${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}======================================${NC}"
    echo ""
}

print_section() {
    echo ""
    echo -e "${CYAN}>>> $1${NC}"
}

print_success() {
    echo -e "${GREEN}[OK] $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}[WARN] $1${NC}"
}

print_error() {
    echo -e "${RED}[ERROR] $1${NC}"
}

print_info() {
    echo -e "${BLUE}[INFO] $1${NC}"
}

# Check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Check if a brew package is installed
brew_installed() {
    brew list "$1" &> /dev/null
}

# Check if a brew cask is installed
cask_installed() {
    brew list --cask "$1" &> /dev/null
}

# Install brew package if not installed
brew_install() {
    local package="$1"
    if brew_installed "$package"; then
        print_info "$package is already installed"
    else
        print_info "Installing $package..."
        brew install "$package"
        print_success "$package installed"
    fi
}

# Install brew cask if not installed
cask_install() {
    local cask="$1"
    if cask_installed "$cask"; then
        print_info "$cask is already installed"
    else
        print_info "Installing $cask..."
        brew install --cask "$cask"
        print_success "$cask installed"
    fi
}

# Backup a file before modifying
backup_file() {
    local file="$1"
    if [[ -f "$file" ]]; then
        cp "$file" "${file}.backup.$(date +%Y%m%d_%H%M%S)"
        print_info "Backed up $file"
    fi
}

# Add line to file if not already present (idempotent)
add_line_to_file() {
    local line="$1"
    local file="$2"
    if ! grep -qF "$line" "$file" 2>/dev/null; then
        echo "$line" >> "$file"
        return 0
    fi
    return 1
}

# Add block to file with markers (idempotent)
add_block_to_file() {
    local marker="$1"
    local content="$2"
    local file="$3"

    local start_marker="# >>> $marker >>>"
    local end_marker="# <<< $marker <<<"

    # Remove existing block if present
    if grep -q "$start_marker" "$file" 2>/dev/null; then
        # Use perl for more reliable multiline deletion on macOS
        perl -i -p0e "s/\n*# >>> $marker >>>.*?# <<< $marker <<<\n*//s" "$file"
    fi

    # Add new block
    echo "" >> "$file"
    echo "$start_marker" >> "$file"
    echo "$content" >> "$file"
    echo "$end_marker" >> "$file"
}
