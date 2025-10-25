#!/usr/bin/env zsh

source $ZDOTDIR/config.zsh
if [[ $TERM != dumb ]]; then
    if command -v fzf >/dev/null; then
        source <(fzf --zsh)
        # # Open in tmux popup if on tmux, otherwise use --height mode
        export FZF_DEFAULT_OPTS="--height 40% --layout reverse"
    fi

    source $ZDOTDIR/zgenom.zsh
    source $ZDOTDIR/completion.zsh
    source $ZDOTDIR/aliases.zsh
    source $ZDOTDIR/keybinds.zsh
    source $ZDOTDIR/prompt.zsh

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

    # Source additional things like completions.
    missing_source_files=()
    source_if_exists() {
        if [[ -f $1 ]]; then
            source $1
        else
            missing_source_files+=($1)
        fi
    }
    source_if_exists /usr/bin/aws_zsh_completer.sh # aws-cli-bin
    source_if_exists /usr/share/zsh/site-functions/_pipenv # python-pipenv
    source_if_exists /usr/share/zsh/site-functions/_just # just
    if [[ -n ${missing_source_files} ]]; then
        echo "missing source files: ${(j:, :)missing_source_files}"
    fi

    eval "$(direnv hook zsh)"
fi
