# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for macOS development environment setup. It provides automated installation and configuration of development tools, shell environment, and system preferences.

## Key Commands

### Bootstrap (Initial Setup)
```bash
make bootstrap          # Full setup: symlink dotfiles, install homebrew packages, setup asdf
make scripts_permissions # Fix script permissions if bootstrap fails
```

### Individual Components
```bash
make link              # Symlink dotfiles only
make homebrew          # Install/update homebrew and packages
make asdf              # Setup asdf version manager and plugins
```

## Architecture

### Directory Structure
- `/homebrew/Brewfile` - Homebrew package definitions (formulae and casks)
- `/scripts/` - Bash scripts for setup automation
  - `link.sh` - Symlinks all dotfiles (files starting with `.`) to `$HOME`
  - `homebrew.sh` - Installs/updates Homebrew and packages from Brewfile
  - `asdf.sh` - Installs asdf plugins (nodejs, python)
- `/zsh/` - Zsh shell configuration
  - `.zshrc` - Main zsh configuration file
  - `config/` - Modular zsh configuration files
- `/git/` - Git configuration files
- `/asdf/` - asdf version manager configuration and default packages

### Configuration System
The dotfiles use a modular approach where:
1. The main `.zshrc` sources individual config files from `zsh/config/`
2. All dotfiles (hidden files starting with `.`) are automatically symlinked to `$HOME`
3. Package management is centralized through the Brewfile
4. Version managers (asdf) are configured with default packages

### Key Environment Variables
- `DOTFILES` - Points to `~/.dotfiles`
- `HOMEBREW_BUNDLE_FILE_GLOBAL` - Points to the Brewfile location
- `HOMEBREW_PREFIX` - Set by Homebrew for package locations

## Development Tools Included
- **Shell**: zsh with powerlevel10k theme, autosuggestions, syntax highlighting
- **Version Management**: asdf for nodejs and python
- **Editor**: neovim, visual-studio-code
- **Development**: git, docker, kubernetes-cli, postgresql
- **Utilities**: bat, jq, rg (ripgrep), tree, zoxide

## Important Notes
- The repository assumes macOS environment
- Apple Silicon (M1/M2) Macs require different Homebrew paths which are handled automatically
- All scripts check for command availability before execution
- The linking script uses `ln -fs` to force symlink creation and overwrite existing files