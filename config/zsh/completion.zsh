fpath+=( $ZDOTDIR/completions $ZDOTDIR/functions )

## Options
setopt COMPLETE_IN_WORD     # Complete 'f|<TAB>1' to 'file|1'.
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt AUTO_MENU            # Show completion menu on a successive tab press.
setopt AUTO_PARAM_KEYS      # If a parameter was completed and a following character was automatically
                            # inserted (normally a space), and the next typed character should come
                            # directly after the name, the automatically inserted character is deleted.
setopt AUTO_PARAM_SLASH     # If completed parameter is a directory, add a trailing slash.
unsetopt MENU_COMPLETE      # Do not automatically insert the first menu item to the line.

# Use caching to make completion for slow commands usable.
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$ZSH_CACHE/zcompcache"

zstyle ':completion:*' completer _complete _match _complete:-extended
    _approximate

# _complete
#   First, try to complete without changing anything.
#   Then, try case-insensitive matching (lower to upper case).
#   Finally, try to match:
#     something other than an upper case letter or a digit to the left and an upper
#     case letter or digit to the right
#   with:
#     anything, including the anchor.
#   This matches `cat SFN<tab>` to `cat SomeFileName`.
zstyle ':completion:*' matcher-list \
    '' \
    'm:{a-z\-}={A-Z\_}' \
    'r:[^A-Z0-9]||[A-Z0-9]=** r:|=*'

# _match
# Don't insert a wildcard at the cursor position since that would allow for unexpected completions
# if the word already contains wildcards.
zstyle ':completion:*:match:*' match-original only
# _complete-extended
zstyle ':complettion:*:complete-extended:*' matcher 'r:[._-]=* r:|=*'  # Treat special char c as *c for completion.
# _approximate
zstyle ':completion:*:approximate:*' max-errors 1 numeric   # Allow only a single error

zstyle ':completion:*' menu select  # Show a menu on ambiguous completions.
zstyle ':completion:*:options' auto-description '%d'    # Description of single arg options when comp func does not describe it.
zstyle ':completion:*:corrections' format '%F{green}-- %d (errors: %e) --%f'    # Show error of corrections.
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'   # Description of matches in completion list.
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'       # Messages from completion functions.
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'    # When no matches are found.
zstyle ':completion:*' select-prompt '%SScrolling: %m%s'    # Show current position in menu selection items.
zstyle ':completion:*' format '%F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''    # Group completions under the respective description.
zstyle ':completion:*' list-colors ''   # List file matches in different colors based on the file type.
zstyle ':completion:*' verbose yes      # Make completion listings more verbose, e.g. show option desctiptions.

# Don't suggest `path` when completing `some/path/../`, or the current working directory in `../`.
zstyle ':completion:*:*:cd:*' ignore-parents parent pwd
# Make `foo//bar` be treated as `foo/bar`.
zstyle ':completion:*' squeeze-slashes true

# Don't complete underlined things.
zstyle ':completion:*:functions' ignored-patterns '(_*)'
zstyle ':completion:*:parameters' ignored-patterns '(_*)'

# Kill
# Only list processes from the current user on the form "<PID> <command>".
zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,command'
# Match groups
#   1. the PID (0=white),
#   2. an optional prefixed path to a command (35=purple),
#   3. a command (01;1=bold white)
# and let the remaining be considered options (33=yellow).
zstyle ':completion:*:*:kill:*:processes' list-colors \
    '=(#b)[[:space:]]#([[:digit:]]#) ([[:alnum:][:punct:]]#/)#([[:alnum:][:punct:]]#)*=33=0=35=01;1'
zstyle ':completion:*:*:kill:*' menu yes select     # Always enter menu selection, because do you
                                                    # really want to type the numbers in a PID?
zstyle ':completion:*:*:kill:*' insert-ids single   # Only insert the PID when the command name is unique.

# Man
zstyle ':completion:*:manuals' separate-sections true       # Show the different man sections (numbers).
zstyle ':completion:*:manuals.(^1*)' insert-sections true   # Insert the section number from menu select.
