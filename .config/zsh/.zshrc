export LESS_TERMCAP_mb=$(tput blink; tput setaf 22) # Start blink.
export LESS_TERMCAP_md=$(tput bold; tput setaf 38) # Start bold.
export LESS_TERMCAP_me=$(tput sgr0) # Stop blink, bold, underline.
export LESS_TERMCAP_so=$(tput bold; tput setaf 7; tput setab 24) # Start standout.
export LESS_TERMCAP_se=$(tput rmso; tput sgr0) # Stop standout.
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # Start underline.
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0) # Stop underline.
export LESS_TERMCAP_mr=$(tput rev) # Start reverse.
export LESS_TERMCAP_mh=$(tput dim) # Start half bright.
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)
export GROFF_NO_SGR=1         # For Konsole and Gnome-terminal
export LESS=--RAW-CONTROL-CHARS

# Source additional configuration and functions
source $ZDOTDIR/zgen.zsh            # zsh package manager.
source $ZDOTDIR/completion.zsh      # Completion configuration.
source $ZDOTDIR/keybinds.zsh        # Keybinds, what did you expect?
source $ZDOTDIR/aliases.zsh         # Straight up aliases.
source $ZDOTDIR/abbreviations.zsh   # Like aliases, but explicit.
source $ZDOTDIR/prompt.zsh          # Terminal prompt.

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=#00ff00,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=#ff0000,bold'

export VISUAL=/usr/bin/nvim

WORDCHARS=${WORDCHARS//[\/.]/}      # Don't consider certain characters part of the word.

HISTFILE=$ZSH_CACHE/history
HISTSIZE=2400
SAVEHIST=2000
setopt autocd
setopt histignorealldups
setopt histignorespace
setopt incappendhistory
setopt interactive_comments

autoload -Uz compinit && compinit -d $ZSH_CACHE/zcompdump

# zsh-autopair has to be loaded after compinit.
autopair-init
