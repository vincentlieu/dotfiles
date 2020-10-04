#! /bin/bash

echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Create symlink to .oh-my-zsh/custom
echo "Creating symlink to oh-my-zsh/custom..."
rm -rf ~/.oh-my-zsh/custom
ln -fs $(pwd)/oh-my-zsh/custom ~/.oh-my-zsh/

echo "Creating symlink to ~/.zshrc..."
rm ~/.zshrc
ln -s $(pwd)/oh-my-zsh/.zshrc ~/.zshrc

echo "Configuring iterm2 settings..."
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$(pwd)/iterm2"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
