# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
echo "Removing custom folder"
rm -rf ~/.oh-my-zsh/custom

echo "Creating Symlink to oh-my-zsh/custom"
ln -fs $(pwd)/.oh-my-zsh/custom ~/.oh-my-zsh/

echo "Removing .zshrc from oh-my-zsh installation"
rm ~/.zshrc

echo "Update submodules"
git submodule init && git submodule update
