# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### PATH TO OH-MY-ZSH INSTALLATION ###
export ZSH="/Users/vincentlieu/.oh-my-zsh"

### OH-MY-ZSH CONFIGURATION ###
DISABLE_MAGIC_FUNCTIONS="true"
ZSH_THEME="powerlevel10k/powerlevel10k"

### ENVIRONMENT VARIABLES ###

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

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
    zsh-syntax-highlighting
    zsh-completions
)

# zsh-autosuggestion configuration
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#abb1bf,bg=abb1bf,bold,underline"
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

source $ZSH/oh-my-zsh.sh
source ~/.aliases
source ~/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
