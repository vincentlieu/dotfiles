# Zsh history configuration

# History file location and size
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

# History options
setopt EXTENDED_HISTORY          # Write timestamp to history file
setopt INC_APPEND_HISTORY        # Add commands to history immediately
setopt SHARE_HISTORY             # Share history between sessions
setopt HIST_IGNORE_DUPS          # Don't record duplicate commands
setopt HIST_IGNORE_SPACE         # Don't record commands starting with space
setopt HIST_VERIFY               # Show command with history expansion before running
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks from history
