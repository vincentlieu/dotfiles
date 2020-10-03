echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Remove oh-my-zsh custom folder from installation.
rm -rf ~/.oh-my-zsh/custom

# Create symlink to .oh-my-zsh/custom
echo "Creating Symlink to oh-my-zsh/custom"
ln -fs $(pwd)/oh-my-zsh/custom ~/.oh-my-zsh/

echo "Removing .zshrc from oh-my-zsh installation"
# rm ~/.zshrc
