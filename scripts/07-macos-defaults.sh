#!/bin/bash
# Configure macOS system preferences

print_section "macOS System Preferences"

# Close any open System Preferences panes to prevent conflicts
osascript -e 'tell application "System Preferences" to quit' 2>/dev/null
osascript -e 'tell application "System Settings" to quit' 2>/dev/null

# ============================================================================
# General UI/UX
# ============================================================================

print_info "Configuring general UI/UX..."

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# ============================================================================
# Keyboard
# ============================================================================

print_info "Configuring keyboard..."

# Fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2

# Short delay before key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable press-and-hold for keys (enable key repeat everywhere)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable automatic period substitution
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# ============================================================================
# Trackpad
# ============================================================================

print_info "Configuring trackpad..."

# Enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# ============================================================================
# Finder
# ============================================================================

print_info "Configuring Finder..."

# Show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When searching, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable warning when changing file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Show the ~/Library folder
chflags nohidden ~/Library 2>/dev/null || true

# ============================================================================
# Dock
# ============================================================================

print_info "Configuring Dock..."

# Set Dock icon size
defaults write com.apple.dock tilesize -int 48

# Auto-hide the Dock
defaults write com.apple.dock autohide -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Don't show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# ============================================================================
# Screenshots
# ============================================================================

print_info "Configuring screenshots..."

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# ============================================================================
# Activity Monitor
# ============================================================================

# Show all processes
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# ============================================================================
# Apply Changes
# ============================================================================

print_info "Restarting affected applications..."

for app in "Activity Monitor" "Dock" "Finder" "SystemUIServer"; do
    killall "${app}" &> /dev/null || true
done

print_success "macOS preferences configured"
print_warning "Some changes require a logout/restart to take effect"
