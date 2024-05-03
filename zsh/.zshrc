# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export DOTFILES="${HOME}/.dotfiles"
export DOTFILES_ZSH="${DOTFILES}/zsh"

if [ -e "${DOTFILES_ZSH}/config/sources.zsh" ]; then 
  source "${DOTFILES_ZSH}/config/sources.zsh"
fi

if [ -e "${DOTFILES_ZSH}/config/aliases.zsh" ]; then 
    source "${DOTFILES_ZSH}/config/aliases.zsh"
fi

if [ -e "${DOTFILES_ZSH}/config/p10k.zsh" ]; then 
    source "${DOTFILES_ZSH}/config/p10k.zsh"
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

# To customize prompt, run `p10k configure` or edit ~/.dotfiles/zsh/config/p10k.zsh.
[[ ! -f ~/.dotfiles/zsh/config/p10k.zsh ]] || source ~/.dotfiles/zsh/config/p10k.zsh
