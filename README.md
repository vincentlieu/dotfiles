# Dotfiles

This repository contains my personal dotfiles tailored for macOS, aiming to provide a lightweight and customizable development environment.

## Overview

- Set up zsh shell configuration.
- Install Homebrew and package installation with Brewfile.
- Set up asdf, a version manager that can manage multiple language runtime versions.

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

### Updating Tool Versions
Keep your development tools up to date:

```bash
make update-tools-versions
```

This will check for the latest stable versions of Node.js and Python and update your `.tool-versions` file.

### Cleaning Up
Remove broken symlinks from your home directory:

```bash
make clean
```

## Contributing

Feel free to fork this repository and customize it to suit your own preferences. Pull requests and suggestions for improvements are always welcome!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Feel free to adjust the description further to reflect your specific goals and preferences!