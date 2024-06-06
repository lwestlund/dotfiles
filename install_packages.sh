#!/usr/bin/env bash

wm_hyprland=(
    hyprland                        # The thing that we are all here for

    hyprlock                        # Screen locker
    hyprpaper                       # Wallpaper setter
    kanshi                          # Automatic monitor handling
    qt5-wayland
    qt6-wayland
    sddm                            # Display manager
    swaync                          # Notification center
    waybar                          # A decent status bar
    wofi                            # An application launcher
    xdg-desktop-portal-hyprland

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

audio=(
    qpwgraph            # Pipewire graph GUI
    pipewire            # Audio (and video) router and processor
    pipewire-pulse      # Pipewire replacement for Pulseaudio
    playerctl           # Media player control for e.g. Spotify
    wireplumber         # Pipewire session/policy manager (think Pipewire interface)
)

fonts=(
    noto-fonts
    noto-fonts-emoji # How else would you be able to write 🔥?
    otf-san-francisco
    ttf-jetbrains-mono-nerd
    ttf-font-awesome
    ttf-iosevka-nerd
    ttf-lato
    ttf-liberation
    ttf-nerd-fonts-symbols-mono
)

shell_programming=(
    bash-language-server
    shellcheck
    shfmt
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
    eza
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
    openssh
    pacman-contrib      # Extra pacman things, like paccache
    patch
    polkit-kde-agent
    python
    python-black
    python-isort
    python-lsp-server
    python-pip
    python-pyflakes
    qbittorrent
    reflector
    ripgrep
    rsync
    rustup              # Rust toolchain installer
    sccache             # Shared compiler cache
    signal-desktop
    spotify
    unzip
    usbutils
    uutils-coreutils    # Coreutils written in Rust
    vdpauinfo
    wget
    wmctrl
    zip
    zoxide              # A smarter cd command
    zsh                 # My shell of choice
    )

packages+=(
    "${audio[@]}"
    "${fonts[@]}"
    "${shell_programming[@]}"
)

if [[ $(cat /etc/hostname) == "wire" ]]; then
    packages+=(
        "${wm_bspwm[@]}"
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
elif [[ $(cat /etc/hostname) == "netbook" ]]; then
    packages+=(
        "${wm_hyprland[@]}"
        blueman
        bluez
        bluez-utils
        brightnessctl
        emacs-wayland
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
    if [[ $(lscpu | grep "Vendor ID") =~ GenuineIntel ]]; then
        packages+=(
            intel-media-driver  # For hardware video acceleration on iGPU.
        )
    fi
fi

if [[ ! $(command -v paru) ]]; then
    sudo pacman -S --noconfirm --needed git base-devel
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    pushd /tmp/paru/ || exit
    makepkg -si
    popd || exit
fi

paru -S "${packages[@]}"
