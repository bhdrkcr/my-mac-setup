# MacBook Setup Script

Automated setup script for configuring a new Mac with development tools, shell enhancements, and system preferences.

## Features

- **Homebrew** - Package manager for macOS
- **pyenv** - Python version management
- **nvm** - Node.js version management
- **Zsh enhancements** - Starship prompt, autosuggestions, syntax highlighting
- **Modern CLI tools** - fzf, bat, eza, ripgrep, fd, and more
- **Neovim** - Modern vim with plugin configuration
- **tmux** - Terminal multiplexer
- **macOS tweaks** - Developer-friendly system preferences

## Requirements

- macOS 12 (Monterey) or later
- Admin privileges (for Homebrew and system preferences)

## Quick Start

```bash
cd ~/Projects/setup
chmod +x setup.sh
./setup.sh
```

## What Gets Installed

### Development Tools
| Tool | Description |
|------|-------------|
| Homebrew | Package manager |
| pyenv | Python version manager |
| nvm | Node.js version manager |
| git | Version control |

### Shell Enhancements
| Tool | Description |
|------|-------------|
| Starship | Fast, customizable prompt |
| zsh-autosuggestions | Fish-like command suggestions |
| zsh-syntax-highlighting | Command syntax coloring |
| fzf | Fuzzy finder (Ctrl+R for history) |

### Modern CLI Tools
| Tool | Replaces | Description |
|------|----------|-------------|
| bat | cat | Syntax highlighting |
| eza | ls | Icons, colors, tree view |
| ripgrep | grep | 10x faster search |
| fd | find | Simpler syntax |
| zoxide | cd | Smart directory jumping |
| tldr | man | Simplified examples |
| jq | - | JSON processor |
| lazygit | - | Git TUI |
| htop/btop | top | Better process viewers |

### Terminal Apps
| Tool | Description |
|------|-------------|
| Neovim | Modern vim with plugins |
| tmux | Terminal multiplexer |

## Customization

### Disable Sections

Edit `setup.sh` and set any flag to `0`:

```bash
INSTALL_FONTS=0              # Skip font installation
CONFIGURE_MACOS_DEFAULTS=0   # Skip system preferences
```

### Add/Remove Packages

Edit `Brewfile` for declarative package management, or modify individual scripts in `scripts/`.

## Post-Installation

1. **Restart Terminal** - Required for shell changes
2. **Set Terminal Font** - Choose "FiraCode Nerd Font" in Terminal > Settings > Profiles > Font
3. **Install Python** - `pyenv install 3.12 && pyenv global 3.12`
4. **Install Node** - `nvm install --lts`
5. **Install tmux plugins** - Open tmux, press `Ctrl+b` then `I`
6. **Open Neovim** - Plugins auto-install on first launch

## Key Bindings

### Shell (Zsh)
| Key | Action |
|-----|--------|
| `Ctrl+R` | Fuzzy search history (fzf) |
| `Ctrl+T` | Fuzzy search files (fzf) |
| `↑/↓` | History search with current prefix |

### Neovim
| Key | Action |
|-----|--------|
| `Space` | Leader key |
| `Space+ff` | Find files |
| `Space+fg` | Live grep |
| `Space+e` | Toggle file explorer |
| `Space+w` | Save file |

### tmux
| Key | Action |
|-----|--------|
| `Ctrl+b` | Prefix |
| `Prefix+\|` | Split horizontal |
| `Prefix+-` | Split vertical |
| `Prefix+h/j/k/l` | Navigate panes |
| `Prefix+r` | Reload config |

## Aliases

The setup creates these aliases:

```bash
cat     → bat (with syntax highlighting)
ls      → eza (with icons)
ll      → eza -la (detailed list)
lt      → eza --tree (tree view)
grep    → ripgrep
find    → fd
cd      → zoxide (smart cd)
vim/vi  → neovim
reload  → source ~/.zshrc
brewup  → brew update && upgrade && cleanup
```

## Architecture Support

Automatically supports:
- Apple Silicon (arm64) - Homebrew at `/opt/homebrew`
- Intel (x86_64) - Homebrew at `/usr/local`

## Idempotency

Safe to run multiple times:
- Checks if tools are installed before installing
- Uses markers in config files to avoid duplicates
- Backs up existing configuration files

## File Structure

```
setup/
├── setup.sh           # Main entry point
├── README.md          # This file
├── Brewfile           # Declarative packages
├── scripts/
│   ├── utils.sh       # Shared utilities
│   ├── 00-xcode-cli.sh
│   ├── 01-homebrew.sh
│   ├── 02-shell-setup.sh
│   ├── 03-dev-tools.sh
│   ├── 04-cli-tools.sh
│   ├── 05-terminal-apps.sh
│   ├── 06-macos-apps.sh
│   └── 07-macos-defaults.sh
└── configs/
    ├── zshrc.sh
    ├── starship.toml
    ├── nvim/init.lua
    ├── tmux.conf
    └── gitconfig
```

## Troubleshooting

### Icons not showing
Make sure you've set a Nerd Font in your terminal settings.

### Commands not found after install
Run `source ~/.zshrc` or restart your terminal.

### Homebrew permission issues
Run `sudo chown -R $(whoami) $(brew --prefix)/*`
