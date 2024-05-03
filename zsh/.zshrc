export DOTFILES="${HOME}/.dotfiles"
export DOTFILES_ZSH="${DOTFILES}/zsh"

if [ -e "${DOTFILES_ZSH}/config/sources.zsh" ]; then 
  source "${DOTFILES_ZSH}/config/sources.zsh"
fi

if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  if [ -f "$(brew --prefix)/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh" ]; then
    FPATH="$(brew --prefix)/share/zsh-completions:${FPATH}"
  fi 
  
  autoload -Uz compinit
  compinit
fi

command -v zoxide &> /dev/null && eval "$(zoxide init zsh)"
