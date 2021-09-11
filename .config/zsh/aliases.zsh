alias path='echo -e ${PATH//:/\\n}'
alias fpath='echo -e ${FPATH//:/\\n}'
alias mkdir='mkdir -pv'
alias cp='cp -i'
alias mv='mv -i'
alias df='df --human-readable'
alias free='free --human'

alias grep='grep --color=auto'

if command -v rg > /dev/null; then
    alias rg='rg --smart-case'
fi

if command -v exa > /dev/null; then
    alias exa="exa --group-directories-first"
    alias l="exa -1"
    alias ll="exa --long"
    alias la="ll --all"
    alias lr="ll --tree"
else
    alias l='ls -gGFhp'
    alias ll='ls -AlFhp'
    alias la='ls -Ahp'
    alias lr='ls -R'
fi

# Yank/paste to/from system clipboard.
alias y='xclip -selection clipboard -in'
alias p='xclip -selection clipboard -out'

# An rsync that respects gitignore.
rcp() {
  # -a = -rlptgoD
  #   -r = recursive
  #   -l = copy symlinks as symlinks
  #   -p = preserve permissions
  #   -t = preserve mtimes
  #   -g = preserve owning group
  #   -o = preserve owner
  # -z = use compression
  # -P = show progress on transferred file
  # -J = don't touch mtimes on symlinks (always errors)
  rsync -azPJ \
    --include=.git/ \
    --filter=':- .gitignore' \
    --filter=":- $XDG_CONFIG_HOME/git/ignore" \
    "$@"
}; compdef rcp=rsync

take() {
  mkdir "$1" && cd "$1";
}; compdef take=mkdir

zman() {
  PAGER="less -g -I -s '+/^       "$1"'" man zshall;
}
