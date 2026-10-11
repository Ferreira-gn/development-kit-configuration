{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rofi
    translate-shell
    wl-clipboard
  ];

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  xdg.configFile."rofi".source = ../rofi;

  # Lembrar de ajustar o
  # tema para um tema do rofi coerente

  home.file.".local/bin/rofi-translate" = {
    executable = true;

    text = ''
      #!/usr/bin/env bash

      set -euo pipefail

      theme="$HOME/.config/rofi/launchers/type-6/style-7.rasi"

      text="$(
        rofi \
          -dmenu \
          -p "Translate" \
          -theme "$theme"
      )"

      [[ -z "$text" ]] && exit 0

      translation="$(trans -brief :pt "$text")"

      printf '%s' "$translation" | wl-copy

      rofi \
        -e "$translation" \
        -theme "$theme"
    '';
  };
}
