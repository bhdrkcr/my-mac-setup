#!/bin/bash
# Install modern CLI tools

print_section "Modern CLI Tools"

# Fuzzy finder
brew_install fzf
# Install fzf key bindings and fuzzy completion
if [[ ! -f "$HOME/.fzf.zsh" ]]; then
    print_info "Installing fzf key bindings..."
    "$HOMEBREW_PREFIX/opt/fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish
fi

# Better cat
brew_install bat

# Better ls
brew_install eza

# Better grep (ripgrep)
brew_install ripgrep

# Better find
brew_install fd

# Simplified man pages
brew_install tldr

# JSON processor
brew_install jq

# Directory navigation
brew_install zoxide

# HTTP client
brew_install httpie

# Git UI
brew_install lazygit

# Disk usage analyzer
brew_install dust

# Process viewers
brew_install htop
brew_install btop

# File manager
brew_install ranger

# Better git diff
brew_install git-delta

# Configure aliases for modern tools
CLI_ALIASES='# Modern CLI tool aliases
alias cat="bat --paging=never"
alias ls="eza --icons --group-directories-first"
alias ll="eza -la --icons --group-directories-first"
alias lt="eza --tree --level=2 --icons"
alias tree="eza --tree --icons"
alias grep="rg"
alias find="fd"

# fzf configuration
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"

# zoxide (better cd)
eval "$(zoxide init zsh)"
alias cd="z"

# Useful aliases
alias reload="source ~/.zshrc"
alias zshconfig="$EDITOR ~/.zshrc"
alias brewup="brew update && brew upgrade && brew cleanup"'
add_block_to_file "CLI_ALIASES" "$CLI_ALIASES" "$HOME/.zshrc"

# Source fzf
add_line_to_file '[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh' "$HOME/.zshrc"

print_success "Modern CLI tools installed"
