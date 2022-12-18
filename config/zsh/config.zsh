if [[ $TERM == dumb ]]; then
    PS1="$ "
fi

# Treat these characters as part of a word.
WORDCHARS='_-*?[]~&;!#$%^(){}<>'

# Completion
setopt HASH_LIST_ALL        # Avoid false reports of spelling errors.

# Expansion and Globbing
setopt EXTENDED_GLOB        # Use extended globbing with #, ~, and ^. Required for _expand_alias to work
unsetopt NOMATCH            # Pass on arguments containing asterisks even if it does not expand to anything.

# Changing Directories
DIRSTACKSIZE=9
setopt AUTO_CD              # Treat commands that are the name of a directory as `cd <command>`.
setopt AUTO_PUSHD           # Treat any cd-like command as pushd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the directory stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
setopt PUSHD_TO_HOME        # Push to the home directory when no argument is given.

# History
HISTFILE=$ZSH_CACHE/history
HISTSIZE=1000               # Max events to store in internal history.
SAVEHIST=1000               # Max events to store in history file.
setopt APPEND_HISTORY       # Appends history to history file on exit.
setopt BANG_HIST            # Expand from history with `!`.
setopt EXTENDED_HISTORY     # Write the history file in the ':start:elapsed;command' format.
setopt HIST_IGNORE_ALL_DUPS # Delete old duplicate events in favor of a new one.
setopt HIST_IGNORE_SPACE    # Do not record an event starting with a space.
setopt HIST_REDUCE_BLANKS   # Remove superfluous blanks from events added to the history.
setopt HIST_SAVE_NO_DUPS    # Do not write a duplicate event to the history file.
setopt HIST_VERIFY          # Do not execute immediately upon history expansion.
setopt INC_APPEND_HISTORY   # Write to the history file immediately, not when the shell exits.
unsetopt HIST_BEEP          # Beep when accessing non-existent history.

# Input/Output
setopt FLOW_CONTROL         # Pause/resume output with Ctrl+Q/S
unsetopt CORRECT_ALL        # Don't try to correct everything, if I fail, I fail.

# Job Control
setopt AUTO_CONTINUE        # Automatically continue stopped jobs that are `disown`ed.
setopt CHECK_JOBS           # On exit, prompt if there are background jobs.
unsetopt BG_NICE            # Don't run background (&) jobs at a lower priority.
unsetopt HUP                # Don't kill jobs on shell exit.

# Zle
unsetopt BEEP               # Hush, don't you beep at me.
