ZGEN_DIR="$XDG_DATA_HOME/zsh/zgenom"
ZGEN_SRC="$ZGEN_DIR/zgenom.zsh"

[ -d "$ZGEN_DIR" ] || git clone https://github.com/jandamm/zgenom "$ZGEN_DIR"
ZGEN_CUSTOM_COMPDUMP=$ZSH_CACHE/zcompdump
source $ZGEN_SRC
zgenom autoupdate --background
if ! zgenom saved; then
    print "Creating a zgenom save"
    zgenom load hlissner/zsh-autopair autopair.zsh
    zgenom load zsh-users/zsh-history-substring-search
    zgenom load junegunn/fzf shell
    zgenom load skywind3000/z.lua
    [ -z "$SSH_CONNECTION" ] && zgenom load zdharma/fast-syntax-highlighting
    zgenom save
fi

# TODO: Is this run twice?
autopair-init
