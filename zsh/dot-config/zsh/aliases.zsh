#!/usr/bin/env zsh

alias path='echo -e ${PATH//:/\\n}'
alias fpath='echo -e ${FPATH//:/\\n}'

# Core utils
if [[ $(pacman -Qi uutils-coreutils &>/dev/null) ]]; then
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

if command -v bat >/dev/null; then
  alias cat='bat'
fi

alias free='free --human'

alias grep='grep --color=auto'

if command -v rg >/dev/null; then
  alias rg='rg --smart-case'
fi

if command -v eza >/dev/null; then
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

if command -v zoxide >/dev/null; then
  alias cd="z"
fi

if command -v sshpass >/dev/null; then
  # scp a file to a CM.
  scpcm() {
    target=$1
    shift
    if [[ "$target" =~ ".*@.*" ]]; then
      # There is a user and a host, use all of it.
      sshpass -p heatly scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -q "$target" $@
    else
      # There is probably only the host, assume root user.
      sshpass -p heatly scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -q "root@$target" $@
    fi
  }
  # ssh to a CM.
  sshcm() {
    target=$1
    shift
    if [[ "$target" =~ ".*@.*" ]]; then
      # There is a user and a host, use all of it.
      sshpass -p heatly ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -q "$target" $@
    else
      # There is probably only the host, assume root user.
      sshpass -p heatly ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -q "root@$target" $@
    fi
  }
fi

# Yank/paste to/from system clipboard.
if [[ -n "${WAYLAND_DISPLAY}" ]]; then
  alias y='wl-copy'
  alias p='wl-paste'
else
  alias y='xclip -selection clipboard -in'
  alias p='xclip -selection clipboard -out'
fi

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
}
compdef rcp=rsync

take() {
  mkdir "$1" && cd "$1"
}
compdef take=mkdir

zman() {
  PAGER="less -g -I -s '+/^       "$1"'" man zshall
}

# Decode the header and payload of a JWT read from a file, an argument or stdin.
jwt-decode() {
  local token
  if (( $# )); then
    if [[ -f "$1" ]]; then
      token=$(<"$1")
    else
      token=$1
    fi
  else
    token=$(</dev/stdin)
  fi

  # Tolerate wrapped/quoted tokens and an Authorization header prefix.
  token=${token//[[:space:]]/}
  token=${token//[\"\']/}
  token=${token#Bearer}

  local -a parts
  parts=(${(s:.:)token})
  if (( ${#parts} < 2 )); then
    print -ru2 -- "jwt-decode: not a JWT"
    return 1
  fi

  local part
  for part in $parts[1,2]; do
    # base64url -> base64, then pad to a multiple of 4.
    part=${part//-/+}
    part=${part//_//}
    while (( ${#part} % 4 )); do part+='='; done

    if command -v jq >/dev/null; then
      print -r -- "$part" | base64 -d | jq . || return 1
    else
      print -r -- "$part" | base64 -d || return 1
      print
    fi
  done
}
