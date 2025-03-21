#!/usr/bin/env bash

wm_hyprland=(
    hyprland # The thing that we are all here for

    uwsm # How we launch it

    hypridle  # Remembers to lock your computer when you don't
    hyprlock  # Screen locker
    hyprpaper # Wallpaper setter
    shikane # Automatic monitor handling
    qt5-wayland
    qt6-wayland
    swaync # Notification center
    waybar # A decent status bar
    wofi   # An application launcher
    xdg-desktop-portal-hyprland

    # Screen shots
    grim         # Capture
    slurp        # Capture selection
    wl-clipboard # Capture to clipboard
)

wm_bspwm=(
    bspwm
    sxhkd # Hot key daemon used with BSPWM

    betterlockscreen # Screen locker
    dunst            # Notification daemon
    libinput-gestures
    picom    # Compositor
    polybar  # A status bar
    redshift # Decreases monitor blue light
    rofi     # An application launcher
    sddm     # Display manager
    wmctrl
    xclip
    xorg

    # Screen shots
    hacksaw # Screenshot selection tool
    shotgun # Screenshot util
)

audio=(
    qpwgraph       # Pipewire graph GUI
    pipewire       # Audio (and video) router and processor
    pipewire-pulse # Pipewire replacement for Pulseaudio
    playerctl      # Media player control for e.g. Spotify
    pwvucontrol    # Volume control applet for Pipewire
    wireplumber    # Pipewire session/policy manager (think Pipewire interface)
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

communication=(
    discord
    signal-desktop
    slack-desktop-wayland
)

docker=(
    docker
    docker-buildx
)

programming_python=(
    python
    python-grip
    python-pip
    python-pyright
    python-ruff
)

programming_shell=(
    bash-language-server
    shellcheck
    shfmt
)

programming_yaml=(
    yaml-language-server
)

packages=(
    alacritty
    aspell
    aspell-en
    aspell-sv
    bash-completion
    bat
    bitwarden
    clang
    cmake
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
    pacman-contrib # Extra pacman things, like paccache
    patch
    qbittorrent
    reflector
    ripgrep
    rsync
    rustup  # Rust toolchain installer
    sccache # Shared compiler cache
    spotify
    unzip
    usbutils
    uutils-coreutils # Coreutils written in Rust
    vdpauinfo
    wget
    zip
    zoxide # A smarter cd command
    zsh    # My shell of choice
)

packages+=(
    "${audio[@]}"
    "${fonts[@]}"
    "${programming_python[@]}"
    "${programming_shell[@]}"
    "${programming_yaml[@]}"
    "${communication[@]}"
)

if [[ $(cat /etc/hostname) == "wire" ]]; then
    packages+=(
        "${wm_bspwm[@]}"
        audacity
        audio-recorder
        calibre
        ckb-next
        "${docker[@]}"
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
        "${docker[@]}"
        emacs-wayland
        fprintd
        network-manager-applet
        sof-firmware
        tlp
        vulkan-devel
        vulkan-intel
        vulkan-icd-loader
        xorg-xbacklight
    )
    if [[ $(lscpu | grep "Vendor ID") =~ GenuineIntel ]]; then
        packages+=(
            intel-media-driver # For hardware video acceleration on iGPU.
        )
    fi
fi

if [[ ! $(command -v paru) ]]; then
    sudo pacman -S --noconfirm --needed git base-devel
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    (
        cd /tmp/paru/ || exit
        makepkg -si
    )
fi

paru -S "${packages[@]}"
