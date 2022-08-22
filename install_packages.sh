packages=(
    alacritty
    aspell
    aspell-en
    aspell-sv
    bash-completion
    bash-language-server
    bat
    bspwm
    clang
    cmake
    discord
    dunst
    emacs-nativecomp
    exa
    fd
    feh
    firefox
    fzf
    gcc
    git
    git-delta
    hacksaw
    htop
    languagetool
    libreoffice-fresh
    lightdm
    lightdm-mini-greeter
    make
    man-db
    man-pages
    mkinitcpio
    mpv
    neovim
    nerd-fonts-fira-code
    networkmanager
    networkmanager-openvpn
    patch
    picom
    playerctl
    polybar
    python
    python-black
    python-pip
    python-isort
    python-lsp-server
    python-pyflakes
    qbittorrent
    reflector
    ripgrep
    rofi
    rsync
    rust-analyzer
    rustup
    shotgun
    signal-desktop
    spotify
    sxhkd
    openssh
    ttf-jetbrains-mono
    ttf-font-awesome
    ttf-lato
    ttf-liberation
    unzip
    vdpauinfo
    wmctrl
    xclip
    xorg
    zip
    zsh
    )

if [[ $(hostnamectl --static) == "wire" ]]; then
    packages+=(
        audacity
        audio-recorder
        calibre
        ckb-next
        gimp
        lib32-pipewire
        lutris
        nordvpn-bin
        ntfs-3g
        nvidia
        nvidia-settings
        ocl-icd
        open-adventure
        perl-image-exiftool
        pipewire
        pipewire-alsa
        shaderc
        steam
        texlab
        texlive-core
        texlive-most
        vulkan-devel
        wine-mono
        wine-staging
        winetricks
        zathura
    )
elif [[ $(hostnamectl --static) == "netbook" ]]; then
    packages+=(
        vulkan-devel
        vulkan-intel
        vulkan-icd-loader
    )
fi

if [[ ! $(command -v yay) ]]; then
    sudo pacman -S --noconfirm --needed git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    pushd /tmp/yay/
    makepkg -si
    popd
fi

yay -S ${packages[@]}
