echo "Installing dotfiles..."

## Install Homebrew and packages
# $? is used to find the return value of the last executed command. 0 is success.

which -s brew
if [ $? != 0 ]; then
    echo "Homebrew not found. Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
    echo "Homebrew already installed. Updating..."
    brew update
    brew upgrade
fi

echo "Turning off analytics..."
brew analytics off
export HOMEBREW_NO_ANALYTICS=1

echo "Installing Homebrew packages..."

packages=(
    nvm               # Node version manager
    pyenv             # Python version manager
    heroku            # Heroku CLI
    postgres          # Postgres DB
    mongodb-community # MongoDB
)

for i in "${packages[@]}"; do
    brew install $i
done
