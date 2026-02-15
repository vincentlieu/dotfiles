export DOTFILES="${HOME}/.dotfiles"
export DOTFILES_ZSH="${DOTFILES}/zsh"
export HOMEBREW_BUNDLE_FILE_GLOBAL="${DOTFILES}/homebrew/Brewfile"
export CLICOLOR=1

if [ -e "${DOTFILES_ZSH}/config/sources.zsh" ]; then
  source "${DOTFILES_ZSH}/config/sources.zsh"
fi

if [ -e "${DOTFILES_ZSH}/config/history.zsh" ]; then
    source "${DOTFILES_ZSH}/config/history.zsh"
fi

if [ -e "${DOTFILES_ZSH}/config/aliases.zsh" ]; then
    source "${DOTFILES_ZSH}/config/aliases.zsh"
fi

if [ -e "${DOTFILES_ZSH}/config/p10k.zsh" ]; then
    source "${DOTFILES_ZSH}/config/p10k.zsh"
fi

if type brew &>/dev/null; then
  FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:${FPATH}"
fi

zstyle ':completion:*' menu select

autoload -U compinit
compinit -i

command -v zoxide &> /dev/null && eval "$(zoxide init zsh)"
