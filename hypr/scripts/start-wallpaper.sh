#!/usr/bin/env bash

STATE_FILE="$HOME/.cache/swww-last-wallpaper"
DEFAULT_WALL="$HOME/.config/hypr/assets/default-02.jpg"

apply_wall() {
    swww img "$1" --transition-type fade --transition-duration 1
}

# Caso 1: arquivo existe e não está vazio
if [ -s "$STATE_FILE" ]; then
    IMG=$(cat "$STATE_FILE")

    # Caso 2: imagem ainda existe
    if [ -f "$IMG" ]; then
        apply_wall "$IMG"
        exit 0
    fi
fi

# Caso 3: fallback
if [ -f "$DEFAULT_WALL" ]; then
    apply_wall "$DEFAULT_WALL"
    echo "$DEFAULT_WALL" > "$STATE_FILE"
fi