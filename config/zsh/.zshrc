#!/usr/bin/env zsh

source $ZDOTDIR/config.zsh
if [[ $TERM != dumb ]]; then
    source $ZDOTDIR/zgenom.zsh
    source $ZDOTDIR/completion.zsh
    source $ZDOTDIR/aliases.zsh
    source $ZDOTDIR/keybinds.zsh
    source $ZDOTDIR/prompt.zsh

    # fzf
    # fd is faster than find.
    if command -v fd >/dev/null; then
        export FZF_DEFAULT_COMMAND="fd ."
        export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
        export FZF_ALT_C_COMMAND="fd -t d . $HOME"
    fi
    # rg is faster than fd on listing files.
    if command -v rg >/dev/null; then
        export FZF_CTRL_T_COMMAND="rg --files ."
    fi

    # If you have host-local configuration, this is where you'd put it
    [ -f ~/.zshrc ] && source ~/.zshrc
fi
