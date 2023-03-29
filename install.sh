#!/usr/bin/env bash

set -e

rel_dir=$(dirname $0)
repo=$(readlink -f $rel_dir)
readonly repo

ln -sf $repo/zshenv     ~/.zshenv

function install_config() {
    function link_config() {
        ln -sf $repo/config/$1 ~/.config/$(dirname $1)/
    }
    link_config alacritty
    link_config bat
    link_config git
    link_config hypr
    link_config latexmk
    link_config mako
    link_config nvim
    link_config waybar
    link_config zsh
}
install_config

mkdir -p ~/.local/bin
ln -sf $repo/bin/* ~/.local/bin/

sudo cp $repo/xorg/* /etc/X11/xorg.conf.d/

sudo cp $repo/etc/tmpfiles.d/charge_threshold.conf /etc/tmpfiles.d/

ln -sf $repo/clang-format   $HOME/.clang-format
