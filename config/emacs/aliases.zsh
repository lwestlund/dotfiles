#!/usr/bin/env zsh

# Open file(s) in current, or new if none exists, emacs.
e() { pgrep emacs && emacsclient -n "$@" || emacs -nw "$@" }
# ediff() { emacs -nw --eval "(ediff-files \"$1\" \"$2\")"; }
# eman()  { emacs -nw --eval "(switch-to-buffer (man \"$1\"))"; }
# Kill the emacs job.
ekill() { emacsclient --eval '(kill-emacs)'; }
