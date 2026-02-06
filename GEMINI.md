# Gemini Project Context: macOS Setup Automation

## Project Overview
This project is an automated setup suite for macOS development environments. It orchestrates the installation and configuration of developer tools, shell enhancements, and system preferences. It is designed to be **idempotent**, meaning it can be run multiple times safely to update or repair the configuration.

**Key Technologies:**
*   **Shell:** Bash (orchestration), Zsh (interactive shell).
*   **Package Management:** Homebrew (via `Brewfile`).
*   **Configuration:** Starship (prompt), Neovim (Lua), tmux, Git.
*   **Version Managers:** `pyenv` (Python), `nvm` (Node.js).

## Usage

### 1. Installation
To start the setup process, execute the main script from the project root:

```bash
chmod +x setup.sh
./setup.sh
```

### 2. Customization
You can customize the installation by editing the flags at the top of `setup.sh`. Set a flag to `0` to disable that specific section.

```bash
INSTALL_FONTS=0              # Skip font installation
CONFIGURE_MACOS_DEFAULTS=0   # Skip system preferences
```

To add or remove packages, modify the `Brewfile`.

## Architecture & Structure

The project is modularized into a main runner and specific task scripts.

*   **`setup.sh`**: The main entry point. Detects architecture (Intel/Apple Silicon), sets global variables, and executes the scripts in `scripts/` based on configuration flags.
*   **`Brewfile`**: A declarative list of Homebrew formulae, casks, and Mac App Store apps to install.
*   **`configs/`**: Contains configuration files that are linked or copied to the user's home directory.
    *   `zshrc.sh`: Sourced by the main `.zshrc`.
    *   `starship.toml`: Prompt configuration.
    *   `nvim/init.lua`: Neovim configuration.
    *   `tmux.conf`: Terminal multiplexer configuration.
    *   `gitconfig`: Git user configuration.
*   **`scripts/`**: Individual installation scripts run by `setup.sh`.
    *   `utils.sh`: Helper functions (logging, linking, etc.).
    *   `00-xcode-cli.sh` to `07-macos-defaults.sh`: Ordered steps for the setup process.

## Key Tools & Aliases

The setup replaces standard Unix tools with modern Rust-based alternatives and establishes aliases for them.

| Standard | Replacement | Alias | Features |
| :--- | :--- | :--- | :--- |
| `cat` | `bat` | `cat` | Syntax highlighting, line numbers. |
| `ls` | `eza` | `ls`, `ll`, `lt` | Icons, Git status, tree view. |
| `grep` | `ripgrep` | `grep` | Significantly faster search. |
| `find` | `fd` | `find` | User-friendly syntax. |
| `cd` | `zoxide` | `cd` | Smart directory jumping. |
| `vim` | `neovim` | `vim`, `vi` | Extensible, modern text editor. |

**Key Bindings:**
*   **Fuzzy Find (fzf):** `Ctrl+R` (History), `Ctrl+T` (Files).
*   **Tmux Prefix:** `Ctrl+b`.

## Development & Maintenance

*   **Idempotency:** Scripts check for existence before installing. `utils.sh` provides helpers like `brew_install_safe` or check functions to ensure safe re-runs.
*   **Updates:** To update tools, you can rely on Homebrew (`brew upgrade`). To update configurations, pull the latest changes to this repo and run `./setup.sh` again.
*   **Debugging:** If a step fails, check the output immediately above the failure. The `setup.sh` script is set to `set -e` (exit on error).

## Post-Install Checklist

1.  **Restart Terminal:** Essential for Zsh and environment variable changes to take effect.
2.  **Fonts:** Configure the terminal emulator to use a "Nerd Font" (e.g., FiraCode or JetBrainsMono) to ensure icons render correctly.
3.  **Language Runtimes:**
    *   Python: `pyenv install <version> && pyenv global <version>`
    *   Node.js: `nvm install --lts`
