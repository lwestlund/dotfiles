#!/usr/bin/env bash

set -e

rel_dir=$(dirname $0)
repo=$(readlink -f $rel_dir)
readonly repo

ln -sf $repo/zshenv            ~/.zshenv
ln -sf $repo/config/zsh        ~/.config/
ln -sf $repo/config/alacritty  ~/.config/
ln -sf $repo/config/git        ~/.config/
ln -sf $repo/config/latexmk    ~/.config/
ln -sf $repo/config/polybar    ~/.config/
ln -sf $repo/config/bspwm      ~/.config/
ln -sf $repo/config/sxhkd      ~/.config/
ln -sf $repo/config/rofi       ~/.config/
ln -sf $repo/config/picom      ~/.config/
ln -sf $repo/config/dunst      ~/.config/

mkdir -p ~/.local/bin
ln -sf $repo/bin/* ~/.local/bin/
