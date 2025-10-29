#!/usr/bin/env bash

set -e

rel_dir=$(dirname "$0")
repo=$(readlink -f "$rel_dir")
readonly repo

log() {
    opts=()
    while [[ $# -gt 0 ]]; do
        case "$1" in
        -*)
            opts+=("$1")
            ;;
        *)
            break
            ;;
        esac
        shift 1
    done

    LIGHT_BLUE="\033[1;34m"
    NC="\033[0m"

    # Intended split
    # shellcheck disable=SC2068
    echo -e ${opts[@]} "${LIGHT_BLUE}>>${NC}" "$@"
}

check-updated() {
    log "Making sure that the system is updated before proceeding... 🧐"
    sudo pacman -Sy
    if [[ -n $(pacman -Qu) ]]; then
        log -n "System needs updates, perform now? [Y/n] "
        read -r response
        case $response in
        "" | Y | y | yes)
            sudo pacman -Syu
            ;;
        *)
            exit 1
            ;;
        esac
    fi
    log "System is up-to-date, proceeding ✅"
}
check-updated

install-pkg() {
    sudo pacman -S --needed --noconfirm "$@"
}

install-stow() {
    log "Making sure that stow is installed..."
    install-pkg stow
    log "Stow is installed, proceeding ✅"
}
install-stow

install-pkg-aur() {
    if ! command -v paru >/dev/null; then
        sudo pacman -S --needed --noconfirm git base-devel
        git clone https://aur.archlinux.org/paru.git /tmp/paru
        (
            cd /tmp/paru/ || exit
            makepkg -si
        )
    fi

    paru -S --needed "$@"
}

audio() {
    log "Installing audio"
    packages=(
        pipewire       # Audio (and video) router and processor
        pipewire-pulse # Pipewire replacement for Pulseaudio
        playerctl      # Media player control for e.g. Spotify
        wireplumber    # Pipewire session/policy manager (think Pipewire interface)
    )
    install-pkg "${packages[@]}"

    packages_aur=(
        pwvucontrol # Volume control applet for Pipewire
    )
    install-pkg-aur "${packages_aur[@]}"

    systemctl --user enable --now pipewire.service
    systemctl --user enable --now wireplumber.service
}

battery-threshold() {
    log "Setting up battery threshold"
    sudo stow --target / battery-threshold
}

bluetooth() {
    log "Installing Bluetooth"
    packages=(
        blueman
        bluez
        bluez-utils
    )
    install-pkg "${packages[@]}"

    while [[ $# -gt 0 ]]; do
        case "$1" in
        --rfkill-unblock)
            sudo systemctl enable --now rfkill-unblock@bluetooth
            ;;
        esac
        shift 1
    done
}

chat() {
    log "Installing chat"
    packages=(
        # discord
        signal-desktop
    )
    install-pkg "${packages[@]}"
}

dev-cpp() {
    log "Installing dev cpp"
    packages=(
        clang
        cmake
        gcc
    )
    install-pkg "${packages[@]}"
}

dev-python() {
    log "Installing dev python"

    packages=(
        pyright
        python
        python-pip
        python-ruff
        python-uv
    )
    install-pkg "${packages[@]}"

    install-pkg-aur python-grip
}

dev-rust() {
    log "Installing dev rust"
    packages=(
        rustup  # Rust toolchain installer
        sccache # Shared compiler cache
        cargo-binstall
        cargo-deny
        cargo-expand
        cargo-machete
    )
    install-pkg "${packages[@]}"
}

dev-shell() {
    log "Installing dev shell"
    packages=(
        bash-language-server
        shellcheck
        shfmt
    )
    install-pkg "${packages[@]}"
}

dev-yaml() {
    log "Installing dev yaml"
    install-pkg yaml-language-server
}

fonts() {
    log "Installing fonts"

    packages=(
        noto-fonts
        noto-fonts-emoji # How else would you be able to write 🔥?
        ttf-jetbrains-mono-nerd
        ttf-font-awesome
        ttf-iosevka-nerd
        ttf-lato
        ttf-liberation
        ttf-nerd-fonts-symbols-mono
    )
    install-pkg "${packages[@]}"

    install-pkg-aur otf-san-francisco
}

intel-cpu() {
    log "Configuring for Intel CPU"
    packages=(
        intel-media-driver # For hardware video acceleration on iGPU.
    )
    install-pkg "${packages[@]}"
}

laptop-power-key-config() {
    log "Configuring laptop power key"
    sudo sed -i 's/#HandlePowerKey=poweroff/HandlePowerKey=suspend/' /etc/systemd/logind.conf
    sudo sed -i 's/#HandlePowerKeyLongPress=ignore/HandlePowerKeyLongPress=poweroff/' /etc/systemd/logind.conf
}

pacman-extra() {
    log "Setting up pacman extras"
    packages=(
        pacman-contrib # Extra pacman things, like paccache
        reflector
    )
    install-pkg "${packages[@]}"
    sudo stow --target / pacman
}

pkg-alacritty() {
    install-pkg alacritty
    stow alacritty
}

pkg-bat() {
    install-pkg bat
    stow bat
}

pkg-brightnessctl() {
    install-pkg brightnessctl
}

pkg-calibre() {
    install-pkg calibre
}

pkg-darktable() {
    install-pkg darktable
}

pkg-direnv() {
    install-pkg direnv
    stow direnv
}

pkg-docker() {
    packages=(
        docker
        docker-buildx
        docker-compose
    )
    install-pkg "${packages[@]}"
    sudo usermod -aG docker "$(whoami)"

    install-pkg-aur dockerfmt
}

pkg-emacs() {
    packages=(
        emacs-wayland
        fd
        git
        git-delta
        ripgrep
    )
    install-pkg "${packages[@]}"
    stow doom
    [[ -d ~/.config/emacs ]] || git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
    ~/.config/emacs/bin/doom install --no-env
}

pkg-fprintd() {
    install-pkg fprintd
}

pkg-git() {
    packages=(
        git
        git-delta
    )
    install-pkg "${packages[@]}"
    stow git
}

pkg-hyprland() {
    packages=(
        hyprland # The thing that we are all here for

        uwsm # How we launch it

        hypridle  # Remembers to lock your computer when you don't
        hyprlock  # Screen locker
        hyprpaper # Wallpaper setter
        hyprpolkitagent
        qt5-wayland
        qt6-wayland
        swaync # Notification center
        waybar # A decent status bar
        xdg-desktop-portal-hyprland

        # Screen shots
        grim         # Capture
        slurp        # Capture selection
        wl-clipboard # Capture to clipboard
    )
    install-pkg "${packages[@]}"
    stow hypr
    stow swaync
    stow waybar

    systemctl --user daemon-reload
    systemctl --user enable --now hyprpolkitagent.service
    systemctl --user enable --now swaync.service
}

pkg-neovim() {
    install-pkg neovim
    stow nvim
}

pkg-networkmanager() {
    packages=(
        networkmanager
    )
    while [[ $# -gt 0 ]]; do
        case "$1" in
        --applet)
            packages+=(network-manager-applet)
            ;;
        --vpn)
            packages+=(networkmanager-openvpn)
            ;;
        esac
        shift 1
    done
    install-pkg "${packages[@]}"
}

pkg-openssh() {
    install-pkg openssh
    systemctl --user enable --now ssh-agent.service
}

pkg-pipewire-libcamera() {
    install-pkg pipewire-libcamera
}

pkg-shikane() {
    install-pkg shikane
    stow shikane
    systemctl --user daemon-reload
    systemctl --user enable --now shikane.service
}

pkg-steam() {
    sudo sed -i '/^#\[multilib\]/,+1 s/^#//' /etc/pacman.conf
    sudo pacman -Sy
    install-pkg steam
}

pkg-spotify() {
    install-pkg-aur spotify
}

pkg-wireshark() {
    install-pkg wireshark-qt
    sudo usermod -aG wireshark "$(whoami)"
}

pkg-wofi() {
    install-pkg wofi
    stow wofi
}

pkg-zsh() {
    install-pkg zsh
    stow zshenv
    stow zsh
}

typical() {
    packages=(
        aspell
        aspell-en
        aspell-sv
        bash-completion
        bitwarden
        btop
        dust
        eza
        fd
        feh
        firefox
        fzf
        htop
        just
        languagetool
        libreoffice-fresh
        make
        man-db
        man-pages
        mkinitcpio
        patch
        qbittorrent
        ripgrep
        rsync
        unzip
        usbutils
        wget
        zip
        zoxide # A smarter cd command
    )
    install-pkg "${packages[@]}"

    install-pkg-aur emote
}

work() {
    packages=(
        kubectl
        kubectx
    )
    install-pkg "${packages[@]}"

    install-pkg-aur slack-desktop-wayland
}

(
    cd "$repo"

    if [[ $(cat /etc/hostname) == "burken" ]]; then
        audio
        bluetooth --rfkill-unblock
        chat
        dev-python
        dev-rust
        dev-shell
        dev-yaml
        fonts
        pacman-extra
        pkg-alacritty
        pkg-bat
        pkg-calibre
        pkg-darktable
        pkg-direnv
        pkg-docker
        pkg-emacs
        pkg-git
        pkg-hyprland
        pkg-networkmanager
        pkg-openssh
        pkg-pipewire-libcamera
        pkg-steam
        pkg-spotify
        pkg-wofi
        pkg-zsh
        typical
        work
    elif [[ $(cat /etc/hostname) == "toaster" ]]; then
        if [[ $(lscpu | grep "Vendor ID") =~ GenuineIntel ]]; then
            intel-cpu
        fi

        battery-threshold
        laptop-power-key-config

        audio
        bluetooth
        chat
        dev-python
        dev-rust
        dev-shell
        dev-yaml
        fonts
        pacman-extra
        pkg-alacritty
        pkg-bat
        pkg-brightnessctl
        pkg-direnv
        pkg-docker
        pkg-emacs
        pkg-fprintd
        pkg-git
        pkg-hyprland
        pkg-networkmanager --applet
        pkg-openssh
        pkg-shikane
        pkg-spotify
        pkg-wireshark
        pkg-wofi
        pkg-zsh
        typical
        work
    fi
)

echo "Config install complete"
