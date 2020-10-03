# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
rm -rf ~/.oh-my-zsh/custom
ln -fs $(pwd)/.oh-my-zsh/custom ~/.oh-my-zsh/
rm ~/.zshrc
git submodule init && git submodule update
