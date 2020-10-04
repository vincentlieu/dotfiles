#! /bin/bash

echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Remove oh-my-zsh custom folder from installation.
rm -rf ~/.oh-my-zsh/custom

# Create symlink to .oh-my-zsh/custom
echo "Creating symlink to oh-my-zsh/custom"
ln -fs $(pwd)/oh-my-zsh/custom ~/.oh-my-zsh/

# Remove oh-my-zsh .zshrc from installation.
rm ~/.zshrc

echo "Creating symlink to ~/.zshrc"
ln -s $(pwd)/oh-my-zsh/.zshrc ~/.zshrc

echo "Configuring iterm2 settings"
# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$(pwd)/iterm2"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
