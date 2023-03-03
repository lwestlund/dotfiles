#!/usr/bin/env bash

set -e

rel_dir=$(dirname $0)
repo=$(readlink -f $rel_dir)
readonly repo

ln -sf $repo/zshenv     ~/.zshenv
ln -sf $repo/config/*   ~/.config/

mkdir -p ~/.local/bin
ln -sf $repo/bin/* ~/.local/bin/

sudo cp $repo/xorg/* /etc/X11/xorg.conf.d/

sudo cp $repo/etc/tmpfiles.d/charge_threshold.conf /etc/tmpfiles.d/

ln -sf $repo/clang-format   $HOME/.clang-format
