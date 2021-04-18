### PATH TO OH-MY-ZSH INSTALLATION ###
export ZSH="/Users/vincentlieu/.oh-my-zsh"

### OH-MY-ZSH CONFIGURATION ###
DISABLE_MAGIC_FUNCTIONS="true"
ZSH_THEME="spaceship"

### ENVIRONMENT VARIABLES ###

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh" --no-use # This loads nvm

# PYENV
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

# RVM
export PATH="$PATH:$HOME/.rvm/bin"

### OH-MY-ZSH PLUGINS ###

plugins=(
    zsh-z
    zsh-autosuggestions

    zsh-completions
)

# zsh-autosuggestion configuration
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#abb1bf,bg=abb1bf,bold,underline"
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

source $ZSH/oh-my-zsh.sh
source ~/.zshrc_aliases
source ~/.spaceship_config
