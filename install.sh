#!/usr/bin/env bash

set -e

repo=$(git rev-parse --show-toplevel)
readonly repo

ln -sf $repo/.zshenv            ~/.zshenv
ln -sf $repo/.config/zsh        ~/.config/zsh
ln -sf $repo/.config/alacritty  ~/.config/alacritty
ln -sf $repo/.config/git        ~/.config/git
ln -sf $repo/.config/latexmk    ~/.config/latexmk
