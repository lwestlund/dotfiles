#!/usr/bin/env bash

set -e

rel_dir=$(dirname "$0")
repo=$(readlink -f "$rel_dir")
readonly repo

ln -sf "$repo"/zshenv   ~/.zshenv

function install_config() {
    function link_config() {
        ln -sf "$repo"/config/"$1" ~/.config/"$(dirname "$1")"/
    }
    link_config alacritty
    link_config bat
    link_config git
    link_config hypr
    link_config kanshi
    link_config latexmk
    link_config nvim
    link_config pipewire
    link_config swaylock
    link_config swaync
    link_config systemd/user/hyprland-session.target
    link_config systemd/user/kanshi.service
    link_config systemd/user/polkit-kde.service
    link_config waybar
    link_config wireplumber
    link_config zsh
}
install_config

systemctl --user daemon-reload
systemctl --user enable kanshi.service
systemctl --user enable pipewire.service
systemctl --user enable polkit-kde.service
systemctl --user enable swaync.service
systemctl --user enable wireplumber.service

install -d ~/.local/bin
ln -sf "$repo"/bin/*    ~/.local/bin/

sudo install -m 644 "$repo"/etc/tmpfiles.d/charge_thresholds.conf /etc/tmpfiles.d/

# Pacman hooks
(
    sudo install -d /etc/pacman.d/hooks
    sudo install -m 644 "$repo"/etc/pacman.d/hooks/cache-cleanup.hook /etc/pacman.d/hooks/
)

ln -sf "$repo"/clang-format "$HOME"/.clang-format

echo "Config install complete."
