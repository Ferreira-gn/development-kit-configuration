{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    shellIntegration.enableFishIntegration = true;

    settings = {
      shell = "fish";

      ## Aparência geral
      background = "#15141C";
      background_opacity = "0.85";
      foreground = "#E0DEF4";

      ## Cursor
      cursor_shape = "beam";
      cursor_beam_thickness = "1.5";
      cursor_blink_interval = "0.5";

      ## Bordas e padding
      window_padding_width = "12";
      confirm_os_window_close = 0;

      ## Barra de título
      hide_window_decorations = "no";

      ## Scroll
      scrollback_lines = 10000;
      wheel_scroll_multiplier = "5.0";

      ## Seleção
      selection_background = "#403D52";
      selection_foreground = "#FFFFFF";

      ## Performance
      repaint_delay = 10;
      input_delay = 3;

      ## Cursor trail (desative se não gostar)
      cursor_trail = 1;
      cursor_trail_decay = "0.1 0.4";
      cursor_trail_start_threshold = 0;

      ## Cores básicas (inspirado em Rose Pine / Nord híbrido)
      color0  = "#1F1D2E";
      color1  = "#EB6F92";
      color2  = "#9CCFD8";
      color3  = "#F6C177";
      color4  = "#31748F";
      color5  = "#C4A7E7";
      color6  = "#9CCFD8";
      color7  = "#E0DEF4";

      color8  = "#6E6A86";
      color9  = "#EB6F92";
      color10 = "#9CCFD8";
      color11 = "#F6C177";
      color12 = "#31748F";
      color13 = "#C4A7E7";
      color14 = "#9CCFD8";
      color15 = "#FFFFFF";
    };

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
  };
}
