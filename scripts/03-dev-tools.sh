#!/bin/bash
# Install development tools: pyenv, nvm, git

print_section "Development Tools"

# Git (usually pre-installed but ensure latest)
brew_install git

# Configure git
print_info "Configuring Git..."
git config --global user.name "qwerkek"
git config --global user.email "qwerkek@users.noreply.github.com"
git config --global init.defaultBranch main
git config --global core.editor nvim
git config --global pull.rebase true
git config --global push.default current
git config --global push.autoSetupRemote true

# Git aliases
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.lg "log --oneline --graph --decorate"
git config --global alias.last "log -1 HEAD"
git config --global alias.unstage "reset HEAD --"

print_success "Git configured"

# pyenv - Python version management
print_info "Setting up pyenv..."
brew_install pyenv
brew_install pyenv-virtualenv

# Configure pyenv in shell
PYENV_CONFIG='export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"'
add_block_to_file "PYENV" "$PYENV_CONFIG" "$HOME/.zshrc"
print_success "pyenv configured"

# nvm - Node version management
print_info "Setting up nvm..."
brew_install nvm

# Create nvm directory
mkdir -p "$HOME/.nvm"

# Configure nvm in shell
NVM_CONFIG='export NVM_DIR="$HOME/.nvm"
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"

# Auto-load .nvmrc
autoload -U add-zsh-hook
load-nvmrc() {
  local nvmrc_path="$(nvm_find_nvmrc)"
  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ "$(nvm version)" != "$(nvm version default)" ]; then
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc'
add_block_to_file "NVM" "$NVM_CONFIG" "$HOME/.zshrc"
print_success "nvm configured"

print_success "Development tools configured"
