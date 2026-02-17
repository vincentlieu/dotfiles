# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for macOS development environment setup. It provides automated installation and configuration of development tools, shell environment, and system preferences.

## Key Commands

### Bootstrap (Initial Setup)
```bash
make bootstrap          # Full setup: symlink dotfiles, install homebrew packages
make scripts_permissions # Fix script permissions if bootstrap fails
```

### Individual Components
```bash
make link              # Symlink dotfiles (via stow)
make unlink            # Remove dotfile symlinks
make homebrew          # Install/update homebrew and packages
```

## Architecture

### Directory Structure
- `/homebrew/Brewfile` - Homebrew package definitions (formulae and casks)
- `/scripts/` - Bash scripts for setup automation
  - `link.sh` - Symlinks dotfiles using GNU Stow
  - `homebrew.sh` - Installs/updates Homebrew and packages from Brewfile
- `/home/` - Dotfiles symlinked to `$HOME` (via stow)
  - `.zshrc` - Main zsh configuration file
  - `.gitconfig`, `.gitignore_global` - Git configuration
  - `.default-npm-packages`, `.default-python-packages` - mise default packages
- `/config/` - XDG config files symlinked to `~/.config/` (via stow)
  - `mise/config.toml` - mise configuration
- `/zsh/` - Zsh config files (sourced by `.zshrc`, not symlinked)
  - `config/` - Modular zsh configuration files

### Configuration System
The dotfiles use a modular approach where:
1. GNU Stow manages all symlinking — `home/` → `$HOME`, `config/` → `~/.config/`
2. The main `.zshrc` sources individual config files from `zsh/config/`
3. Package management is centralized through the Brewfile
4. mise uses a zero-config approach — projects define their own tool versions

### Key Environment Variables
- `DOTFILES` - Points to `~/.dotfiles`
- `HOMEBREW_BUNDLE_FILE_GLOBAL` - Points to the Brewfile location
- `HOMEBREW_PREFIX` - Set by Homebrew for package locations

## Development Tools Included
- **Shell**: zsh with powerlevel10k theme, autosuggestions, syntax highlighting
- **Symlinking**: GNU Stow
- **Version Management**: mise (zero-config, project-driven)
- **Editor**: neovim, visual-studio-code
- **Development**: git, docker, kubernetes-cli, postgresql
- **Utilities**: bat, jq, rg (ripgrep), tree, zoxide

## Important Notes
- The repository assumes macOS environment
- Apple Silicon (M1/M2) Macs require different Homebrew paths which are handled automatically
- All scripts check for command availability before execution
- Stow will error (not overwrite) if a conflicting file already exists at the target
