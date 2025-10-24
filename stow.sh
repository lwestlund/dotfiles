#!/usr/bin/env sh

set -e

if ! command -v stow >/dev/null; then
    echo "missing stow"
    exit 1
fi

PACKAGE="config"
TARGET="$HOME/.config"

stow \
    --target "$TARGET" \
    "$PACKAGE" \
    --ignore latexmk \
    --ignore pipewire \
    --ignore wireplumber
