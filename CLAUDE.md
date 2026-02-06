# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Idempotent macOS setup automation. Bash scripts install dev tools, configure the shell, and set system preferences. Safe to run repeatedly — uses existence checks, marker-based config blocks, and timestamped backups.

## Running

```bash
./setup.sh          # Full setup (interactive — prompts for confirmation)
```

Disable sections by setting flags to `0` at the top of `setup.sh` (e.g., `INSTALL_FONTS=0`).

There are no tests or linters. Verify changes by reading the script logic and, when possible, running the relevant script in isolation (e.g., `source scripts/utils.sh && source scripts/04-cli-tools.sh`).

## Architecture

**`setup.sh`** — Entry point. Detects architecture (arm64/x86_64), sets `HOMEBREW_PREFIX` and `SCRIPT_DIR`, then sources numbered scripts in order.

**`scripts/utils.sh`** — Shared helpers sourced by all scripts. Key functions:
- `brew_install` / `cask_install` / `npm_install` — idempotent installers (check before installing)
- `command_exists` / `brew_installed` / `cask_installed` — existence checks
- `backup_file` — timestamped backup before overwriting configs
- `add_line_to_file` — grep-based dedup for single lines
- `add_block_to_file` — marker-delimited blocks (`# >>> MARKER >>>` / `# <<< MARKER <<<`) for multi-line config injection into files like `~/.zshrc`. Uses Perl for reliable multiline replacement on macOS.

**`scripts/00-07,08`** — Ordered installation steps, each script sources `utils.sh` implicitly (via `setup.sh`). The execution order matters: Xcode CLI tools → Homebrew → shell → dev tools → CLI tools → terminal apps → AI tools → fonts → macOS defaults.

**`Brewfile`** — Declarative Homebrew dependencies. Processed by `01-homebrew.sh` via `brew bundle install`.

**`configs/`** — Source config files copied/injected into the user's home directory:
- `zshrc.sh` → injected into `~/.zshrc` via `add_block_to_file` with "MACBOOK_SETUP" marker
- `starship.toml` → copied to `~/.config/starship.toml`
- `nvim/init.lua` → copied to `~/.config/nvim/init.lua` (uses lazy.nvim, Catppuccin Macchiato theme)
- `tmux.conf` → copied to `~/.tmux.conf` (uses TPM for plugins)
- `gitconfig` → reference file; actual config set via `git config --global` in `03-dev-tools.sh`
- `ghostty/config` → copied to `~/.config/ghostty/config` (Catppuccin Mocha theme, JetBrainsMono Nerd Font)

## Conventions

- Every script uses `print_*` functions from `utils.sh` for colored output — use these instead of raw `echo`.
- Config blocks in `~/.zshrc` use named markers (e.g., "PYENV", "NVM", "CLI_ALIASES", "EDITOR") to allow idempotent updates.
- Git user info is hardcoded in `03-dev-tools.sh` (username: qwerkek).
- The terminal emulator is Ghostty (cask in Brewfile, config in `configs/ghostty/config`).
- Catppuccin Mocha/Macchiato is the color scheme across Ghostty, Neovim, tmux, and Starship.
- Modern CLI aliases override standard tools: `cat`→bat, `ls`→eza, `grep`→rg, `find`→fd, `cd`→zoxide.
