#! /bin/bash

echo "Installing dotfiles..."

# Install Homebrew
if ! [ -x "$(which brew)" ]; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
    echo "Homebrew already installed. Updating..."
    brew update
    brew upgrade
fi

echo "Turning off analytics..."
brew analytics off
export HOMEBREW_NO_ANALYTICS=1

echo "Installing packages..."

# Add or remove third-party formulae from github as homebrew taps
taps=(
    # user/repo
    mongodb/brew # Add mongoDB
    heroku/brew  # Add Heroku
)

for i in "${taps[@]}"; do
    brew tap "$i"
done

# Add or remove homebrew formulae to install
formulae=(
    git               # Keep git updated with homebrew
    nvm               # Node version manager
    pyenv             # Python version manager
    postgres          # Postgres DB
    heroku            # Heroku CLI
    mongodb-community # MongoDB latest production release
)

for i in "${formulae[@]}"; do
    brew install "$i"
done

echo "Installing casks..."

# Add or remove homebrew casks to install
casks=(
    google-chrome      # Web browser
    firefox            # Web browser
    visual-studio-code # Code editor
    typora             # Markdown editor
    slack              # Team communicate platform
    alfred             # Application launcher and productivity
    vlc                # Video player
    the-unarchiver     # Archieve opener
    postman            # RESTful API tool
    iterm2             # Better terminal
    notion             # Note taking application
    spotify            # Music client
    docker             # Docker client
    # mongodb-compass      # Mongodb client
    # adobe-acrobat-reader # PDF reader
    # pock                 # Macbook pro touchbar application
    # balsamiq-wireframes  # Wireframing application
    # one-switch           # System and utility switches all in one place
)

for i in "${casks[@]}"; do
    brew cask install "$i"
done

echo "Cleaning up..."
brew cleanup

# config nvm to mount when running node or nvm command

# install node via nvm

# install python via pyenv
