{ ... }:

{
  home.file.".config/kitty/kitty.conf".text = ''
    ########################
    # Fonte
    ########################

    font_family      JetBrainsMono Nerd Font
    bold_font        auto
    italic_font      auto
    bold_italic_font auto
    font_size        11.0

    # Mantém as ligaduras habilitadas em todos os contextos.
    disable_ligatures never

    # Recursos OpenType relacionados a ligaduras.
    font_features JetBrainsMonoNerdFont-Regular +liga +calt +clig +dlig +rlig

    ########################
    # Aparência
    ########################

    background #15141C
    foreground #E0DEF4

    background_opacity 0.80
    background_blur 30

    hide_window_decorations titlebar-only

    window_padding_width 8
    window_margin_width 0

    ########################
    # Seleção
    ########################

    selection_background #403D52
    selection_foreground #FFFFFF

    ########################
    # Cursor
    ########################

    cursor            #E0DEF4
    cursor_text_color #15141C

    cursor_shape beam
    cursor_beam_thickness 1.5
    cursor_blink_interval 0.5
    cursor_trail 20

    ########################
    # Mouse
    ########################

    mouse_hide_wait 3.0

    ########################
    # Histórico e rolagem
    ########################

    scrollback_lines 10000
    wheel_scroll_multiplier 3.0

    ########################
    # Shell
    ########################

    shell fish
    shell_integration enabled

    confirm_os_window_close 0

    ########################
    # Abas
    ########################

    tab_bar_edge top
    tab_bar_align center
    tab_bar_style separator

    tab_separator " • "
    tab_bar_margin_height 0.0 0.0

    tab_title_max_length 30
    tab_title_template "{index}: {title.split(' ')[0]}"

    active_tab_foreground   #FFFFFF
    active_tab_background   #403D52

    inactive_tab_foreground #A09FAF
    inactive_tab_background #15141C

    tab_bar_background #15141C

    ########################
    # Bordas e URLs
    ########################

    url_color #78A9FF

    active_border_color   #78A9FF
    inactive_border_color #403D52
    bell_border_color     #FF7EB6

    wayland_titlebar_color background

    ########################
    # Paleta ANSI
    ########################

    # Preto e cinza
    color0 #26242F
    color8 #52505E

    # Vermelho
    color1 #EE5396
    color9 #FF7EB6

    # Verde
    color2  #42BE65
    color10 #6FDC8C

    # Amarelo
    color3  #F1C21B
    color11 #FDDC69

    # Azul
    color4  #4589FF
    color12 #78A9FF

    # Magenta
    color5  #BE95FF
    color13 #D4BBFF

    # Ciano
    color6  #08BDBA
    color14 #3DDBD9

    # Branco
    color7  #C6C6C6
    color15 #FFFFFF

    ########################
    # Atalhos - Abas
    ########################

    # Alternar para a próxima aba.
    map ctrl+tab next_tab

    # Alternar para a aba anterior.
    map shift+alt+tab previous_tab

    # Criar uma nova aba.
    map ctrl+shift+t new_tab

    # Fechar a aba atual.
    map ctrl+shift+w close_tab

    ########################
    # Atalhos - Área de transferência
    ########################

    map ctrl+c copy_or_interrupt


    ########################
    # janelas e splits
    ########################

    enabled_layouts splits:split_axis=horizontal;equalize_on_close=true

    # Criar janela ao lado da janela atual.
    map ctrl+shift+enter launch --location=vsplit

    # Criar janela abaixo da janela atual.
    map ctrl+shift+down launch --location=hsplit

    # Alternar entre janelas empilhados e lado a lado.
    map ctrl+shift+r layout_action rotate

    # Igualar o tamanho das janelas.
    map ctrl+shift+e layout_action equalize

    # Remove a janela em foco
    map ctrl+shift+q close_window

    ########################
    # Foco entre janelas
    ########################

    # Vim-like
    map alt+h neighboring_window left
    map alt+j neighboring_window down
    map alt+k neighboring_window up
    map alt+l neighboring_window right

    # Setas
    map alt+left  neighboring_window left
    map alt+down  neighboring_window down
    map alt+up    neighboring_window up
    map alt+right neighboring_window right

    ########################
    # Mover janelas
    ########################

    # Vim-like
    map kitty_mod+h move_window left
    map kitty_mod+j move_window down
    map kitty_mod+k move_window up
    map kitty_mod+l move_window right

    # Setas
    map kitty_mod+left  move_window left
    map kitty_mod+down  move_window down
    map kitty_mod+up    move_window up
    map kitty_mod+right move_window right


    ########################
    # Atalhos - Pesquisa
    ########################

    map ctrl+shift+f send_text all "fzf_cd"
    map ctrl+shift+g launch --location=hsplit fish -c "fzf-history"
    map ctrl+shift+o launch --location=hsplit fish -c "fzf-open"

    ########################
    # Atalhos - Rolagem
    ########################

    map page_up scroll_page_up
    map page_down scroll_page_down

    ########################
    # Atalhos - Tamanho da fonte
    ########################

    map ctrl+plus   change_font_size all +1
    map ctrl+equal  change_font_size all +1
    map ctrl+kp_add change_font_size all +1

    map ctrl+minus       change_font_size all -1
    map ctrl+underscore  change_font_size all -1
    map ctrl+kp_subtract change_font_size all -1

    map ctrl+0    change_font_size all 0
    map ctrl+kp_0 change_font_size all 0
  '';
}

