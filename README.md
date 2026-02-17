# Dotfiles

This repository contains my personal dotfiles tailored for macOS, aiming to provide a lightweight and customizable development environment.

## Overview

- Set up zsh shell configuration.
- Install Homebrew and package installation with Brewfile.
- Set up mise, a polyglot version manager. Uses a zero-config approach where projects define their own tool versions.

## Usage

To use these dotfiles on a new system:

1. Clone the repository to your home directory:

    ```bash
    git clone https://github.com/vincentlieu/dotfiles.git ~/.dotfiles
    ```

2. Install the dotfiles by running the bootstrap script:

    ```bash
    cd ~/.dotfiles
    make bootstrap
    ```

    If you encounter script permission errors during the bootstrap process, run the following command to fix them:

    ```bash
    make scripts_permissions
    ```

## Maintenance

### Health Check

Verify your dotfiles setup is working correctly:

```bash
make doctor
```

This will check that all essential tools are installed, dotfiles are properly symlinked, and mise tools are configured.

### Managing Tool Versions

This dotfiles uses a **zero-config approach** - no global tool versions are defined. Each project should specify its own versions via `.tool-versions` or `mise.toml`.

To upgrade tools in a project:

```bash
cd your-project
mise upgrade
```

mise is configured via `config/mise/config.toml` with sensible defaults and global environment variables.

### Symlinking

Re-apply or remove dotfile symlinks:

```bash
make link              # Apply symlinks
make unlink            # Remove symlinks
```

### Backup Management

Manage your dotfile backups:

```bash
make backup-list         # List all backup files
make backup-restore      # Interactively restore a file from backup
make backup-clean        # Remove old backup files (keeps 5 most recent)
```

### Homebrew Management

Check and maintain your Homebrew packages:

```bash
make brew-check          # Verify all Brewfile packages are installed
make brew-cleanup        # Remove unused packages and clean caches
```

## Contributing

Feel free to fork this repository and customize it to suit your own preferences. Pull requests and suggestions for improvements are always welcome!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Feel free to adjust the description further to reflect your specific goals and preferences!
