alias "gbsup"='git branch --set-upstream-to=origin/$(git branch | grep \* | cut -d " " -f2)'
alias "gpsup"='git push --set-upstream origin $(git branch | grep \* | cut -d " " -f2)'

# Add all given files or select one using FZF.
ga() {
    if [ $# -gt 0 ]; then
        git add "$@"
    else
        git status -s | fzf | cut -c3- | xargs git add "$@"
    fi
}; compdef _git ga=git-add

# Restore changes made to a tracked file, staged or unstaged.
grs() {
    git diff --name-status | fzf | cut -f2 | xargs git restore --staged --worktree
}

# Switch to another local branch.
gsb() {
    other_branches=$(git branch | grep -v "^*")
    [[ -n $other_branches ]] || (print "No other local branches"; return)
    print $other_branches | fzf | xargs git switch
}

# Checkout a remote branch.
gcor() {
    readonly current_branch=$(git branch | grep "^*" | cut -d" " -f2)
    git branch -r | grep -vE "(HEAD|$current_branch)" | fzf \
        | tr -d "[:blank:]" | sed "s,^origin/,," | xargs git checkout
}

# Delete local branches merged to master/develop on remote.
gbdmr() {
    git branch -r --merged | sed "s,origin/,," | xargs -n1 git branch -D 2>/dev/null
}
