alias path='echo -e ${PATH//:/\\n}'
alias fpath='echo -e ${FPATH//:/\\n}'

# Core utils
if [[ $(pacman -Qi uutils-coreutils &> /dev/null) ]]; then
  alias \[='uu-['
  alias base32='uu-base32'
  alias base64='uu-base64'
  alias basename='uu-basename'
  alias cat='uu-cat'
  alias chmod='uu-chmod'
  alias chown='uu-chown'
  alias chroot='uu-chroot'
  alias cp='uu-cp -i'
  alias dd='uu-dd'
  alias df='uu-df --human-readable'
  alias dirname='uu-dirname'
  alias du='uu-du'
  alias echo='uu-echo'
  alias groups='uu-groups'
  alias head='uu-head'
  alias hostname='uu-hostname'
  alias install='uu-install'
  alias kill='uu-kill'
  alias ln='uu-ln'
  alias ls='uu-ls'
  alias mkdir='uu-mkdir -p'
  alias mv='uu-mv -i'
  alias nohup='uu-nohup'
  alias readlink='uu-readlink'
  alias rm='uu-rm'
  alias rmdir='uu-rmdir'
  alias sleep='uu-sleep'
  alias sort='uu-sort'
  alias tail='uu-tail'
  alias touch='uu-touch'
  alias uname='uu-uname'
  alias wc='uu-wc'
else
  alias cp='cp -i'
  alias df='df --human-readable'
  alias mkdir='mkdir -p'
  alias mv='mv -i'
fi

alias free='free --human'

alias grep='grep --color=auto'

if command -v rg > /dev/null; then
    alias rg='rg --smart-case'
fi

if command -v eza > /dev/null; then
    alias eza="eza --group-directories-first"
    alias l="eza -1"
    alias ll="eza --long"
    alias la="ll --all"
    alias lr="ll --tree"
else
    alias l='ls -gGFhp'
    alias ll='ls -AlFhp'
    alias la='ls -Ahp'
    alias lr='ls -R'
fi

if command -v zoxide > /dev/null; then
  alias cd="z"
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
