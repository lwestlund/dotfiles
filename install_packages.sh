#!/usr/bin/env sh

wm_hyprland=(
    hyprland-git                    # The thing that we are all here for

    hyprpaper                       # Wallpaper setter
    kanshi                          # Automatic monitor handling
    mako                            # Notification daemon
    qt5-wayland
    qt6-wayland
    sddm                            # Display manager
    swaylock                        # Screen locker
    waybar-hyprland-git             # A decent status bra
    wofi                            # An application launcher
    xdg-desktop-portal-hyprland-git

    # Screen shots
    grim                # Capture
    slurp               # Capture selection
    wl-clipboard        # Capture to clipboard
)

wm_bspwm=(
    bspwm
    sxhkd               # Hot key daemon used with BSPWM

    betterlockscreen    # Screen locker
    dunst               # Notification daemon
    picom               # Compositor
    polybar             # A status bar
    redshift            # Decreases monitor blue light
    rofi                # An application launcher
    sddm                # Display manager
    xclip
    xorg

    # Screen shots
    hacksaw             # Screenshot selection tool
    shotgun             # Screenshot util
)

packages=(
    alacritty
    aspell
    aspell-en
    aspell-sv
    bash-completion
    bash-language-server
    bat
    bitwarden
    clang
    cmake
    discord
    dust
    emote
    exa
    fd
    feh
    firefox
    fzf
    gcc
    git
    git-delta
    htop
    languagetool
    libreoffice-fresh
    make
    man-db
    man-pages
    mkinitcpio
    mpv
    neovim
    networkmanager
    networkmanager-openvpn
    noto-fonts
    noto-fonts-emoji # How else would you be able to write 🔥?
    openssh
    otf-san-francisco
    patch
    pipewire
    pipewire-pulse
    playerctl
    polkit-kde-agent
    python
    python-black
    python-pip
    python-isort
    python-lsp-server
    python-pyflakes
    qbittorrent
    reflector
    ripgrep
    rsync
    rustup              # Rust toolchain installer
    sccache             # Shared compiler cache
    signal-desktop
    spotify
    ttf-jetbrains-mono
    ttf-font-awesome
    ttf-iosevka-nerd
    ttf-lato
    ttf-liberation
    unzip
    usbutils
    uutils-coreutils    # Coreutils written in Rust
    vdpauinfo
    wget
    wireplumber
    wmctrl
    zip
    zsh                 # My shell of choice
    )

if [[ $(hostnamectl --static) == "wire" ]]; then
    packages+=(
        ${wm_bspwm[@]}
        audacity
        audio-recorder
        calibre
        ckb-next
        emacs-nativecomp
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
        ${wm_hyprland[@]}
        blueman
        bluez
        bluez-utils
        brightnessctl
        emacs-gcc-wayland-devel-bin
        fprintd
        libinput-gestures
        network-manager-applet
        pavucontrol
        slack-bin
        sof-firmware
        tlp
        vulkan-devel
        vulkan-intel
        vulkan-icd-loader
        xorg-xbacklight
    )
fi

if [[ ! $(command -v paru) ]]; then
    sudo pacman -S --noconfirm --needed git base-devel
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    pushd /tmp/paru/
    makepkg -si
    popd
fi

paru -S ${packages[@]}
