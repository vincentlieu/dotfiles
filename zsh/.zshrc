export DOTFILES="${HOME}/.dotfiles"
export DOTFILES_ZSH="${DOTFILES}/zsh"

if [ -e "${DOTFILES_ZSH}/config/sources.zsh" ]; then 
  source "${DOTFILES_ZSH}/config/sources.zsh"
fi

if [ -e "${DOTFILES_ZSH}/config/aliases.zsh" ]; then 
    source "${DOTFILES_ZSH}/config/aliases.zsh"
fi

if [ -e "${DOTFILES_ZSH}/config/.p10k.zsh" ]; then 
    source "${DOTFILES_ZSH}/config/.p10k.zsh"
fi

if type brew &>/dev/null; then
  FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:${FPATH}"
  if [ -e "$HOMEBREW_PREFIX/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh" ]; then
    FPATH="$HOMEBREW_PREFIX/share/zsh-completions:${FPATH}"
  fi
fi

autoload -Uz compinit
compinit

command -v zoxide &> /dev/null && eval "$(zoxide init zsh)"
