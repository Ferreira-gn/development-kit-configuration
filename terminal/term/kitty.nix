{ ... }:

{
  home.file.".config/kitty/kitty.conf".text = ''
    ########################
    # Aparência
    ########################
    background #15141C
    foreground #E0DEF4
    background_opacity 1

    ########################
    # Fonte
    ########################
    font_family JetBrainsMono Nerd Font
    bold_font        auto
    italic_font      auto
    bold_italic_font auto
    font_size 11.0

    ########################
    # Cursor
    ########################
    cursor_shape beam
    cursor_beam_thickness 1.5
    cursor_blink_interval 0.5
    cursor_trail 1

    ########################
    # Espaçamento
    ########################
    window_padding_width 8
    #window_margin_width 10.75

    ########################
    # Scroll
    ########################
    scrollback_lines 10000
    wheel_scroll_multiplier 3.0

    ########################
    # Seleção
    ########################
    selection_background #403D52
    selection_foreground #FFFFFF

    ########################
    # Comportamento
    ########################
    confirm_os_window_close 0
    shell fish

    ########################
    # Atalhos - Copy
    ########################
    map ctrl+c copy_or_interrupt

    ########################
    # Atalhos - Search
    ########################
    map ctrl+shift+f send_text all "fzf_cd"
    map ctrl+shift+h launch --location=hsplit fish -c "fzf-history"
    map ctrl+shift+o launch --location=hsplit fish -c "fzf-open"

    ########################
    # Atalhos - Scroll
    ########################
    map page_up scroll_page_up
    map page_down scroll_page_down

    ########################
    # Atalhos - Zoom
    ########################
    map ctrl+plus change_font_size all +1
    map ctrl+equal change_font_size all +1
    map ctrl+kp_add change_font_size all +1
    map ctrl+minus change_font_size all -1
    map ctrl+underscore change_font_size all -1
    map ctrl+kp_subtract change_font_size all -1
    map ctrl+0 change_font_size all 0
    map ctrl+kp_0 change_font_size all 0
  '';
}
