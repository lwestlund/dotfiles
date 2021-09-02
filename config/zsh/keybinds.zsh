autoload -U is-at-least

# vi-mode
bindkey -v

bindkey -M viins 'jk' vi-cmd-mode

# abbrev-expand, my own module.
autoload -Uz abbrev-expand
zle -N abbrev-expand-magic-space abbrev-expand
zle -N abbrev-expand-and-accept abbrev-expand
zle -N abbrev-expand-or-complete abbrev-expand
bindkey "^M" abbrev-expand-and-accept            # Return key.
bindkey -M viins "^I" abbrev-expand-or-complete  # Tab key.
bindkey -M viins " " abbrev-expand-magic-space   # Space key.
# TODO: Maybe this is not necesserary with magic-space, have to try it.
bindkey -M isearch " " self-insert              # Don't try to expand anything in search mode.

# surround
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround

# Open current prompt in external editor
autoload -Uz edit-command-line; zle -N edit-command-line
bindkey '^E' edit-command-line

bindkey -M viins '^j' history-substring-search-down
bindkey -M viins '^k' history-substring-search-up
bindkey -M viins '^s' history-incremental-pattern-search-backward
bindkey -M viins '^u' backward-kill-line
bindkey -M viins '^w' backward-kill-word
bindkey -M viins '^b' backward-word
bindkey -M viins '^f' forward-word
bindkey -M viins '^g' push-line-or-edit
bindkey -M viins '^a' beginning-of-line
bindkey -M viins '^e' end-of-line
bindkey -M viins '^d' push-line-or-edit
bindkey -M viins '^[[Z' undo

bindkey -M vicmd '^k' kill-line
bindkey -M vicmd 'H'  run-help
bindkey -M vicmd 'u'  undo

zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete

bindkey '^[[H' beginning-of-line                # Home key.
bindkey '^[[F' end-of-line                      # End key.

bindkey '^[[A' history-substring-search-up      # Arrow up searches upwards in history by substring.
bindkey '^[[B' history-substring-search-down    # Arrow down searches downwards in history by substring.
bindkey '^[[1;5D' backward-word                 # ctrl+left arrow.
bindkey '^[[1;5C' forward-word                  # ctrl+right arrow.

bindkey '^R' fzf-history-widget

# Ctrl-z to toggle latest job between background and foreground.
fancy-ctrl-z() {
    if [[ $#BUFFER -eq 0 ]]; then
        BUFFER="fg"
        zle accept-line
    else
        zle push-input
    fi
}
zle -N fancy-ctrl-z
bindkey "^Z" fancy-ctrl-z
