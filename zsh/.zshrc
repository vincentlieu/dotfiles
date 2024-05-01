# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [ -f "${HOME}/.p10k.zsh" ]; then
 source "${HOME}/.p10k.zsh"
fi

if [ -f "${HOME}/.zsh_aliases" ]; then
  source "${HOME}/.zsh_aliases"
fi

if [ -f $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme ]; then
  source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
fi

if [ -f "$(brew --prefix asdf)/libexec/asdf.sh" ]; then
  source $(brew --prefix asdf)/libexec/asdf.sh
fi

if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

if [ -f "$(brew --prefix)/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh" ]; then
  source "$(brew --prefix)/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
fi

if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"
  autoload -Uz compinit
  compinit
fi

command -v zoxide &> /dev/null && eval "$(zoxide init zsh)"
