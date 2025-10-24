#!/usr/bin/env bash

set -e

rel_dir=$(dirname "$0")
repo=$(readlink -f "$rel_dir")
readonly repo


ln -sf "$repo"/zshenv ~/.zshenv

"$repo"/stow.sh

systemctl --user daemon-reload
systemctl --user enable pipewire.service
systemctl --user enable swaync.service
systemctl --user enable wireplumber.service
systemctl --user enable shikane.service
systemctl --user enable hyprpolkitagent.service
systemctl --user enable ssh-agent.service

sudo install -m 644 "$repo"/etc/tmpfiles.d/charge_thresholds.conf /etc/tmpfiles.d/

# Pacman hooks
(
    sudo install -d /etc/pacman.d/hooks
    sudo install -m 644 "$repo"/etc/pacman.d/hooks/cache-cleanup.hook /etc/pacman.d/hooks/
    sudo install -m 644 "$repo"/etc/pacman.d/hooks/mirrorupgrade.hook /etc/pacman.d/hooks/
)

ln -sf "$repo"/clang-format "$HOME"/.clang-format

echo "Config install complete."
