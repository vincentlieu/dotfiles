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
ln -s $(pwd)/.zshrc ~/.zshrc
