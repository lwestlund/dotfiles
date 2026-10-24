typeset -U PATH path
path=(~/.local/bin ~/.config/emacs/bin/ ~/.cargo/bin $path)

export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_TEMPLATES_DIR="$HOME/Templates"
export XDG_PUBLICSHARE_DIR="$HOME/Public"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_VIDEOS_DIR="$HOME/Videos"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_BIN_HOME="$HOME/.local/bin"

export ZSH_CACHE=$XDG_CACHE_HOME/zsh

export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

export VISUAL=nvim

# groff's ANSI escapes confuse bat's man highlighter (stray `[24m` etc.).
# -c makes groff use backspace overstrikes instead, which col -bx strips.
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -plman'"

export HOSTNAME=$(hostnamectl hostname)

if uwsm check may-start -q; then
    exec uwsm start hyprland.desktop
fi
