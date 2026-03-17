#!/usr/bin/env bash

OUT="$XDG_RUNTIME_DIR/wlogout.png"

grim - | magick - \
  -scale 25% \
  -blur 0x4 \
  -scale 400% \
  "$OUT"

wlogout --protocol layer-shell