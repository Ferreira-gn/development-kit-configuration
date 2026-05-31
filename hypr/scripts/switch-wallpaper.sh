#!/usr/bin/env bash

DIR="$HOME/Imagens/wallpaper"
STATE_FILE="$HOME/.cache/swww-last-wallpaper"
DEFAULT_WALL="$HOME/.config/hypr/assets/default-02.jpg"

# Verifica se diretório existe
if [ ! -d "$DIR" ]; then
    echo "Diretório não encontrado: $DIR"
    exit 1
fi

# Escolhe imagem aleatória
IMG=$(find "$DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n 1)

# Se nenhuma imagem for encontrada
if [ -z "$IMG" ]; then
    echo "Nenhuma imagem encontrada em $DIR"

    if [ -f "$DEFAULT_WALL" ]; then
        IMG="$DEFAULT_WALL"
    else
        echo "Wallpaper padrão também não encontrado."
        exit 1
    fi
fi

# Aplica wallpaper
swww img "$IMG" \
  --transition-type random \
  --transition-angle 90 \
  --transition-duration 2 \
  --transition-fps 60

# Salva estado
echo "$IMG" > "$STATE_FILE"